#!/bin/zsh

# Get the currently focused window's app name
focused_app_name=$(/opt/homebrew/bin/yabai -m query --windows --window | /opt/homebrew/bin/jq -r '.app')

# Get all minimized window IDs of the same application as the focused window.
minimized_windows_of_app=$(/opt/homebrew/bin/yabai -m query --windows | /opt/homebrew/bin/jq -r --arg app "$focused_app_name" '.[] | select(.app == $app and .["is-minimized"] == true) | .id')

# Deminimize each minimized window individually.
echo "$minimized_windows_of_app" | while read -r window_id; do
  /opt/homebrew/bin/yabai -m window --deminimize "$window_id"
done