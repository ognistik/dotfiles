#!/bin/zsh

# Get the focused app and window IDs
focused_app=$(/opt/homebrew/bin/yabai -m query --windows --window | /opt/homebrew/bin/jq -r '.app')
focused_window_id=$(/opt/homebrew/bin/yabai -m query --windows --window | /opt/homebrew/bin/jq -r '.id')

all_shortcuts_window_id=""

# Get all window IDs of the currently focused application
windows=$(/opt/homebrew/bin/yabai -m query --windows | /opt/homebrew/bin/jq -r --arg app "$focused_app" '.[] | select(.app == $app) | .id,.title')

# Iterate over each window to identify "All Shortcuts" window and close other windows, except the focused one
echo "$windows" | while read -r window_id; do
  read -r title
  
  if [[ "$window_id" == "$focused_window_id" ]]; then
    continue
  fi
  
  if [[ "$title" == "All Shortcuts" ]]; then
    all_shortcuts_window_id="$window_id"
  else
    /opt/homebrew/bin/yabai -m window "$window_id" --close
  fi 
done

# Close "All Shortcuts" window at the end, if it exists and is not the focused one 
if [[ -n "$all_shortcuts_window_id" && "${all_shortcuts_window_id}" != "${focused_window_id}" ]]; then 
  /opt/homebrew/bin/yabai -m window "$all_shortcuts_window_id" --close 
fi 