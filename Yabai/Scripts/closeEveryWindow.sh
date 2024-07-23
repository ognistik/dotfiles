#!/bin/zsh

all_shortcuts_window_id=""

# Get all window IDs and their titles for all open windows.
windows=$(/opt/homebrew/bin/yabai -m query --windows | /opt/homebrew/bin/jq -r '.[] | .id,.title')

# Iterate over each window to identify "All Shortcuts" window and close other windows.
echo "$windows" | while read -r window_id; do
  read -r title
  
  if [[ "$title" == "All Shortcuts" ]]; then
    all_shortcuts_window_id="$window_id"
    continue # Skip closing "All Shortcuts" for now, we'll handle it later.
  fi
  
  /opt/homebrew/bin/yabai -m window "$window_id" --close 
done

# Close "All Shortcuts" window at the end, if it exists.
if [[ -n "$all_shortcuts_window_id" ]]; then 
  /opt/homebrew/bin/yabai -m window "$all_shortcuts_window_id" --close 
fi 