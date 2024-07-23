#!/bin/zsh

# Get all minimized window IDs of all applications.
minimized_windows=$(/opt/homebrew/bin/yabai -m query --windows | /opt/homebrew/bin/jq -r '.[] | select(.["is-minimized"] == true) | .id')

# Deminimize each minimized window individually.
echo "$minimized_windows" | while read -r window_id; do
  /opt/homebrew/bin/yabai -m window --deminimize "$window_id"
done