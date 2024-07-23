#!/bin/zsh

# Get the currently focused window ID and its app name
focused_window_info=$(/opt/homebrew/bin/yabai -m query --windows --window)
focused_window_id=$(echo "$focused_window_info" | /opt/homebrew/bin/jq -r '.id')
focused_app_name=$(echo "$focused_window_info" | /opt/homebrew/bin/jq -r '.app')

# Get all window IDs of the same application as the focused window.
windows_of_app=$(/opt/homebrew/bin/yabai -m query --windows | /opt/homebrew/bin/jq -r --arg app "$focused_app_name" '.[] | select(.app == $app) | .id')

# Minimize each window individually except for the currently focused one.
echo "$windows_of_app" | while read -r window_id; do
  if [[ "$window_id" != "$focused_window_id" ]]; then
    /opt/homebrew/bin/yabai -m window "$window_id" --minimize 
  fi 
done