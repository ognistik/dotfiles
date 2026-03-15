#!/usr/bin/env bash

# --- Configuration ---
# Set to 'true' to enable debugging. When debugging is active, no spaces will be destroyed.
# Debugging output will be saved to your Desktop.
DEBUG=false

# --- Debugging Setup ---
# Define the debug log file path and a function to log messages.
DEBUG_LOG_DIR="${HOME}/Desktop"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
DEBUG_LOG_FILE="${DEBUG_LOG_DIR}/yabai_destroy_spaces_debug_${TIMESTAMP}.log"

log_debug() {
  if [ "$DEBUG" = "true" ]; then
    echo "$@" >> "$DEBUG_LOG_FILE"
  fi
}

# Clear previous debug log content if it exists and start new session.
if [ "$DEBUG" = "true" ]; then
  echo "--- Debugging Yabai Space Destruction Script ---" > "$DEBUG_LOG_FILE"
  echo "Timestamp: $(date)" >> "$DEBUG_LOG_FILE"
  echo "" >> "$DEBUG_LOG_FILE"
  echo "DEBUG mode is active. Spaces will NOT be destroyed; analysis only." >> "$DEBUG_LOG_FILE"
  echo "Debugging output written to: $DEBUG_LOG_FILE" >> "$DEBUG_LOG_FILE"
  echo "" >> "$DEBUG_LOG_FILE"
fi

# --- Pre-check: Fullscreen Spaces ---
# Exit if any display has a native fullscreen space. We don't want to mess with those.
yabai -m query --spaces --display | \
  jq -re 'all(."is-native-fullscreen" | not)' &> /dev/null
if [ $? -ne 0 ]; then
  log_debug "Detected native fullscreen space. Exiting to avoid interference."
  exit 0
fi

# --- Query Yabai Data ---
# Query all windows and spaces once to get a snapshot for analysis.
# This prevents repeated calls and keeps data consistent for debugging.
ALL_WINDOWS_JSON=$(yabai -m query --windows)
ALL_SPACES_JSON=$(yabai -m query --spaces)

log_debug "--- Raw Yabai Windows Data ---"
log_debug "$ALL_WINDOWS_JSON"
log_debug ""

log_debug "--- Raw Yabai Spaces Data ---"
log_debug "$ALL_SPACES_JSON"
log_debug ""

# --- Define 'Allowed' Windows ---
# These are windows that, if they are the ONLY windows in an unfocused space,
# will NOT prevent the space from being destroyed.
#
# Logic: A window is 'allowed' if it is:
#   - hidden
#   - minimized (though minimized windows are usually hidden too, this is explicit)
#   - a scratchpad window
#   - an app like Kando, Alter (excluding 'AXStandardWindow' subrole), Dropover,
#     superwhisper (excluding 'AXStandardWindow' subrole), BetterMouse,
#     or Screen Studio (excluding specific 'Project' titles)
#   - any window with an empty title has been removed... if I want to add it I need to add  `or (.title == "")` <-- notice the "or" at the end of line
#
# The jq query filters the ALL_WINDOWS_JSON to get a list of IDs for these 'allowed' windows.
ALLOWED_WINDOW_IDS=$(echo "$ALL_WINDOWS_JSON" | jq -r '
  map(
    select(
      ."is-hidden" or
      ."is-minimized" or
      .scratchpad != "" or
      (.app == "Kando") or
      (.app == "Alter" and .subrole != "AXStandardWindow") or
      (.app == "Dropover") or
      (.app == "superwhisper" and .subrole != "AXStandardWindow") or
      (.app == "BetterMouse") or
      (.app == "Screen Studio" and (.title | startswith("Project") | not)) or
      (.app == "Bear" and .title == "") or
      (.app == "Anybox" and .title == "") or
      (.app == "ghostty" and .title == "")
    )
  ) | map(."id")
')

log_debug "--- All Allowed Window IDs (these will NOT prevent space destruction) ---"
log_debug "$ALLOWED_WINDOW_IDS"
log_debug ""


# --- Space Destruction Logic ---
# Find unfocused spaces that contain only 'allowed' windows (or no windows at all).
#
# Detailed breakdown of the jq logic:
# 1. `map(select(...))`: Filter the list of all spaces.
# 2. `."has-focus" | not`: Selects spaces that do NOT have focus.
# 3. `(."windows" | ...)`: Processes the array of window IDs within each space.
# 4. `map(select(. as $window | '"$ALLOWED_WINDOW_IDS"' | index($window) | not))`:
#    - This creates a temporary list of window IDs in the current space.
#    - For each window ID (`$window`) in the space, it checks if that ID is *not* present
#      in our `ALLOWED_WINDOW_IDS` list (`index($window) | not`).
#    - The result is a list of "unallowed" window IDs that are in the current space.
# 5. `) == []`: Checks if the list of "unallowed" window IDs is empty.
#    - If it's empty, it means all windows in the space are 'allowed' (or there are no windows).
# 6. `map(index) | reverse | .[]`: Extracts the `index` of these filtered spaces,
#    reverses the order (important for yabai destruction), and outputs each ID on a new line.
#
# The `reverse` is crucial because yabai destroys spaces by ID, and if you destroy
# a lower-indexed space first, it can shift higher-indexed spaces, leading to
# unintended destructions. Destroying in reverse order (highest ID first) is safer.
SPACES_TO_DESTROY=$(echo "$ALL_SPACES_JSON" | jq -re "
  map(
    select(
      (.\"has-focus\" | not) and
      (.\"windows\" | map(select(. as \$window | \$allowed_ids | index(\$window) | not)) | length == 0)
    )
  ) | map(.\"index\") | reverse | .[]
" --argjson allowed_ids "$ALLOWED_WINDOW_IDS")


# --- Debugging Output (Detailed Space Analysis) ---
if [ "$DEBUG" = "true" ]; then
  log_debug "--- Detailed Space Analysis ---"
  echo "$ALL_SPACES_JSON" | jq -r --argjson allowed_ids "$ALLOWED_WINDOW_IDS" '
    .[] |
    "--------------------------------------------------",
    "Space \(.index) (Label: '\''(.label)'\'', Focused: \(.["has-focus"])):",
    if (.windows | length) > 0 then
      "  Windows present in this space:"
    else
      "  No windows detected in this space."
    end,
    (
      .windows | map(
        . as $window_id |
        if ($allowed_ids | index($window_id)) then
          "    - ID: \($window_id), App: \((($all_windows_raw | fromjson) | map(select(.id == $window_id)) | .[0].app)), Title: \((($all_windows_raw | fromjson) | map(select(.id == $window_id)) | .[0].title)) (ALLOWED: This window does NOT prevent destruction)"
        else
          "    - ID: \($window_id), App: \((($all_windows_raw | fromjson) | map(select(.id == $window_id)) | .[0].app)), Title: \((($all_windows_raw | fromjson) | map(select(.id == $window_id)) | .[0].title)) (UNALLOWED: This window PREVENTS destruction)"
        end
      ) | .[]
    ),
    if .["has-focus"] then
      "  >> Reason for not destroying: This space HAS FOCUS."
    elif (.windows | length) == 0 then
      "  >> All windows are ALLOWED (or no windows). CANDIDATE FOR DESTRUCTION."
    elif (.windows | map(select(. as $window | $allowed_ids | index($window) | not)) | length) == 0 then
      "  >> All windows in this space are ALLOWED. CANDIDATE FOR DESTRUCTION."
    else
      "  >> Reason for not destroying: Contains \((.windows | map(select(. as $window | $allowed_ids | index($window) | not)) | length)) UNALLOWED window(s)."
    end,
    "--------------------------------------------------"
  ' --argjson all_windows_raw "$ALL_WINDOWS_JSON" >> "$DEBUG_LOG_FILE"
  log_debug ""

  log_debug "--- SPACES_TO_DESTROY variable content ---"
  log_debug "$SPACES_TO_DESTROY"
  log_debug ""

  log_debug "No spaces will be destroyed because DEBUG mode is active."
  log_debug "--- End of Debugging Output ---"
fi

# --- Execute Destruction or Debug ---
if [ "$DEBUG" = "true" ]; then
  # In debug mode, we just log what would happen.
  if [ -n "$SPACES_TO_DESTROY" ]; then
    log_debug "Debug: The following spaces would have been destroyed: $(echo "$SPACES_TO_DESTROY" | tr '\n' ' ')"
  else
    log_debug "Debug: No eligible spaces found for destruction."
  fi
else
  # In production mode, destroy the identified spaces.
  if [ -n "$SPACES_TO_DESTROY" ]; then
    echo "$SPACES_TO_DESTROY" | xargs -I % sh -c 'yabai -m space % --destroy'
    # Optional: uncomment the following lines if you need to refresh yabai indicator or sleep.
    # sleep 0.1
    # echo \"refresh\" | nc -U /tmp/yabai-indicator.socket
  else
    # echo "No eligible spaces found for destruction." # Uncomment if you want console output
    : # No-op
  fi
fi

# --- Final Debug Message ---
if [ "$DEBUG" = "true" ]; then
  echo "Debugging complete. Check $DEBUG_LOG_FILE for details."
fi