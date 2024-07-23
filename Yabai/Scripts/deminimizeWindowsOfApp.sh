#!/bin/zsh

# Get the currently focused window's app name
app_name="$1"

# Get all minimized window IDs of the same application as the focused window.
minimized_windows_of_app=$(/opt/homebrew/bin/yabai -m query --windows | /opt/homebrew/bin/jq -r --arg app "$app_name" '.[] | select(.app == $app and .["is-minimized"] == true) | .id')

# Deminimize each minimized window individually.
echo "$minimized_windows_of_app" | while read -r window_id; do
  /opt/homebrew/bin/yabai -m window --deminimize "$window_id"
done