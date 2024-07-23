#!/bin/zsh

# Get all non-minimized window IDs of all applications.
non_minimized_windows=$(/opt/homebrew/bin/yabai -m query --windows | /opt/homebrew/bin/jq -r '.[] | select(.["is-minimized"] == false) | .id')

# Minimize each non-minimized window individually.
echo "$non_minimized_windows" | while read -r window_id; do
  /opt/homebrew/bin/yabai -m window --minimize "$window_id"
done
