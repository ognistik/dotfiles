#!/bin/bash

ACTION="$1"

window_info=$(/opt/homebrew/bin/yabai -m query --windows --window)
scratchpad=$(echo "$window_info" | /opt/homebrew/bin/jq -r '.scratchpad')
app=$(echo "$window_info" | /opt/homebrew/bin/jq -r '.app')
id=$(echo "$window_info" | /opt/homebrew/bin/jq -r '.id')

if [[ -n "$scratchpad" ]]; then
  if [[ $ACTION == "toggle" ]]; then
    if [[ $app == "Arc" ]]; then
      sleep 0.2
    fi
    /opt/homebrew/bin/yabai -m window --toggle "$scratchpad"
  elif [[ $ACTION == "remove" ]]; then
    /opt/homebrew/bin/yabai -m window "$id" --scratchpad ""
    if [[ $app == "Arc" ]]; then
      /opt/homebrew/bin/yabai -m window "$id" --toggle float
    fi
    osascript -e "display notification \"Scratchpad $id has been removed.\" with title \"SCRATCHPAD CLEAR\""
  fi
fi