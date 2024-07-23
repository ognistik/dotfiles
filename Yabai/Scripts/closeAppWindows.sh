#!/bin/zsh

app_name="$1"
all_shortcuts_window_id=""

# Get all window IDs of the given application
windows=$(/opt/homebrew/bin/yabai -m query --windows | /opt/homebrew/bin/jq -r --arg app "$app_name" '.[] | select(.app == $app) | .id,.title')

# Iterate over each window to identify "All Shortcuts" window and close other windows
echo "$windows" | while read -r window_id; do
  read -r title
  
  if [[ "$title" == "All Shortcuts" ]]; then
    all_shortcuts_window_id="$window_id"
  else
    /opt/homebrew/bin/yabai -m window "$window_id" --close
  fi
done

# Close "All Shortcuts" window at the end, if it exists 
if [[ -n "$all_shortcuts_window_id" ]]; then 
  /opt/homebrew/bin/yabai -m window "$all_shortcuts_window_id" --close 
fi 