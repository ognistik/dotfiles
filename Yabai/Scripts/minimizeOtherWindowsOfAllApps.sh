#!/bin/zsh

# Get the ID of the currently focused window.
current_window_id=$(/opt/homebrew/bin/yabai -m query --windows --window | /opt/homebrew/bin/jq -r '.id')

# Get all non-minimized window IDs of all applications except the current window.
non_minimized_windows=$(/opt/homebrew/bin/yabai -m query --windows | /opt/homebrew/bin/jq -r --arg current_id "$current_window_id" '.[] | select(.["is-minimized"] == false and .id != ($current_id | tonumber)) | .id')

# Minimize each non-minimized window individually, except the current one.
echo "$non_minimized_windows" | while read -r window_id; do
  /opt/homebrew/bin/yabai -m window --minimize "$window_id"
done