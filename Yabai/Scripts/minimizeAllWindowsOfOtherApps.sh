#!/bin/zsh

# Get the app name of the currently focused window.
current_app_name=$(/opt/homebrew/bin/yabai -m query --windows --window | /opt/homebrew/bin/jq -r '.app')

# Get all non-minimized window IDs of all applications except the current app.
non_minimized_windows=$(/opt/homebrew/bin/yabai -m query --windows | /opt/homebrew/bin/jq -r --arg current_app "$current_app_name" '.[] | select(.["is-minimized"] == false and .app != $current_app) | .id')

# Minimize each non-minimized window individually, except those from the current app.
echo "$non_minimized_windows" | while read -r window_id; do
  /opt/homebrew/bin/yabai -m window --minimize "$window_id"
done