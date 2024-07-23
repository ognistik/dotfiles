#!/bin/zsh

# Get the currently focused window ID and its title
focused_window_id=$(/opt/homebrew/bin/yabai -m query --windows --window | /opt/homebrew/bin/jq -r '.id')
focused_window_title=$(/opt/homebrew/bin/yabai -m query --windows --window | /opt/homebrew/bin/jq -r '.title')

all_shortcuts_window_id=""

# Get all window IDs, their app names, and titles for all open windows.
windows=$(/opt/homebrew/bin/yabai -m query --windows | /opt/homebrew/bin/jq -r '.[] | .id,.title')

# Iterate over each window to identify "All Shortcuts" window and close other windows except the focused one.
echo "$windows" | while read -r window_id; do
  read -r title
  
  if [[ "$window_id" == "$focused_window_id" ]]; then
    continue # Skip closing the currently focused window.
  fi

  if [[ "$title" == "All Shortcuts" ]]; then
    all_shortcuts_window_id="$window_id"
    continue # Skip closing "All Shortcuts" for now, we'll handle it later.
  fi
  
  /opt/homebrew/bin/yabai -m window "$window_id" --close 
done

# Close "All Shortcuts" window at the end, if it exists and is not the currently focused one.
if [[ -n "$all_shortcuts_window_id" && "$all_shortcuts_window_id" != "$focused_window_id" ]]; then 
  /opt/homebrew/bin/yabai -m window "$all_shortcuts_window_id" --close 
fi 