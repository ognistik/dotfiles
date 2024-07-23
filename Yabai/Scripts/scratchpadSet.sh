#!/bin/bash

# Get the ID of the currently focused window
window_info=$(/opt/homebrew/bin/yabai -m query --windows --window)

if [ "$window_info" = "" ]; then
  exit 0
fi

focused_window_id=$(echo "$window_info" | /opt/homebrew/bin/jq -r '.id')
focused_title=$(echo "$window_info" | /opt/homebrew/bin/jq -r '.title')
focused_window_scratchpad=$(echo "$window_info" | /opt/homebrew/bin/jq -r '.scratchpad')

# Find the window with the scratchpad property "scratchpad"
myscratchpad_window_id=$(/opt/homebrew/bin/yabai -m query --windows | /opt/homebrew/bin/jq -r '.[] | select(.scratchpad == "scratchpad") | .id')

if [ "$myscratchpad_window_id" = "" ] && [ "$focused_window_scratchpad" = "" ]; then
  # No window with scratchpad "scratchpad" found and scratchpad property is free on current window, assign my scratchpad to the current window
  /opt/homebrew/bin/yabai -m window --scratchpad "scratchpad" --grid 11:11:1:1:9:9
  osascript -e "display notification \"Window '$focused_title' is your new SOLO Scratchpad.\" with title \"SOLO SCRATCHPAD SET\""
elif [ "$myscratchpad_window_id" = "$focused_window_id" ]; then
  # Currently focused window is my scratchpad. Make it available.
  /opt/homebrew/bin/yabai -m window "$myscratchpad_window_id" --scratchpad ""
  osascript -e "display notification \"Your SOLO Scratchpad is now available.\" with title \"SOLO SCRATCHPAD CLEAR\""
elif [ "$focused_window_scratchpad" = "bearScratchpad" ] || [ "$focused_window_scratchpad" = "arcScratchpad" ]; then
  # Special case of Arc or Bear Scratchpad removal
  /opt/homebrew/bin/yabai -m window "$focused_window_scratchpad" --scratchpad ""
  /opt/homebrew/bin/yabai -m window "$focused_window_scratchpad" --scratchpad "scratchpad" --grid 11:11:1:1:9:9
  osascript -e "display notification \"Your SPECIAL Scratchpad is now your SOLO Scratchpad.\" with title \"SPECIAL SCRATCHPAD SWITCH\""
elif [ "$focused_window_scratchpad" != "" ]; then
  # Focused windows is a default scratchpad. Switch it to become a Solo Scratchpad.
    /opt/homebrew/bin/yabai -m window "$focused_window_id" --scratchpad ""
    /opt/homebrew/bin/yabai -m window "$focused_window_id" --scratchpad "scratchpad" --grid 11:11:1:1:9:9
  osascript -e "display notification \"Your YABAIRC Scratchpad with title '$focused_title' is now your SOLO Scratchpad.\" with title \"YABAIRC SCRATCHPAD SWITCH\""
else
  # Remove the scratchpad property from the found window and assign it to the current focused window
  /opt/homebrew/bin/yabai -m window "$myscratchpad_window_id" --scratchpad ""
  /opt/homebrew/bin/yabai -m window "$focused_window_id" --scratchpad "scratchpad" --grid 11:11:1:1:9:9
  /opt/homebrew/bin/yabai -m window --focus "$focused_window_id"
  osascript -e "display notification \"Your SOLO Scratchpad is now '$focused_title'.\" with title \"SOLO SCRATCHPAD SWITCH\""
fi