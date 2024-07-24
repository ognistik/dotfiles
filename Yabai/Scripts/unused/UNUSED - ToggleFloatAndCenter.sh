#!/bin/bash

# Get information about the currently focused window
window_info=$(/opt/homebrew/bin/yabai -m query --windows --window)
is_floating=$(echo $window_info | /opt/homebrew/bin/jq -r '.floating')

# Check if the window is floating
if [ "$is_floating" == "1" ]; then
  # If the window is floating, toggle floating
  /opt/homebrew/bin/yabai -m window --toggle float  --layer below
else
  # If the window is not floating, toggle floating and center the window
  /opt/homebrew/bin/yabai -m window --toggle float  --layer below

  # Retrieve the display information
  display_info=$(/opt/homebrew/bin/yabai -m query --displays --display)

  # Calculate the center position for the window
  coords=$(/opt/homebrew/bin/jq --argjson window "$window_info" --argjson display "$display_info" -nr \
    "((\$display.frame | .x + .w / 2) - (\$window.frame.w / 2) | tostring) + \":\" + ((\$display.frame | .y + .h / 2) - (\$window.frame.h / 2) | tostring)")

  # Move the window to the center of the display
  /opt/homebrew/bin/yabai -m window --move "abs:$coords"
fi
