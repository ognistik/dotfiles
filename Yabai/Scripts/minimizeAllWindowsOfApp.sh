#!/bin/zsh

# Get the currently focused window ID and its app name
app_name="$1"

# Get all window IDs of the same application as the focused window.
windows_of_app=$(/opt/homebrew/bin/yabai -m query --windows | /opt/homebrew/bin/jq -r --arg app "$app_name" '.[] | select(.app == $app) | .id')

# Minimize each window individually except for the currently focused one.
echo "$windows_of_app" | while read -r window_id; do
    /opt/homebrew/bin/yabai -m window "$window_id" --minimize
done