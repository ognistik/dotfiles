#!/bin/bash

APP_NAME="$1"

# 1. Check current window
current_window=$(/opt/homebrew/bin/yabai -m query --windows --window)
current_app=$(echo "$current_window" | /opt/homebrew/bin/jq -r '.app')
current_scratchpad=$(echo "$current_window" | /opt/homebrew/bin/jq -r '.scratchpad // empty')

if [ "$current_app" = "$APP_NAME" ] && [ -n "$current_scratchpad" ]; then
    echo "onlyScratchpadHasFocus"
    exit 0
fi

# 2. Query all windows of the app
windows=$(/opt/homebrew/bin/yabai -m query --windows | /opt/homebrew/bin/jq "map(select(.app == \"$APP_NAME\"))")

window_count=$(echo "$windows" | /opt/homebrew/bin/jq 'length')

if [ "$window_count" -eq 0 ]; then
    echo "noWindows"
    exit 0
fi

has_non_scratchpad=false
has_scratchpad=false
last_moved_wid=""

while IFS= read -r window; do
    wid=$(echo "$window" | /opt/homebrew/bin/jq -r '.id')
    scratchpad=$(echo "$window" | /opt/homebrew/bin/jq -r '.scratchpad // empty')
    # echo "Window ID: $wid, Scratchpad: '$scratchpad'"
    if [ -z "$scratchpad" ]; then
        has_non_scratchpad=true
    else
        has_scratchpad=true
    fi
done < <(echo "$windows" | /opt/homebrew/bin/jq -c '.[]')

if [ "$has_non_scratchpad" = false ] && [ "$has_scratchpad" = true ]; then
    echo "onlyScratchpadNoFocus"
    exit 0
fi

# 3. Move windows without scratchpad to current space
while IFS= read -r window; do
    wid=$(echo "$window" | /opt/homebrew/bin/jq -r '.id')
    scratchpad=$(echo "$window" | /opt/homebrew/bin/jq -r '.scratchpad // empty')
    if [ -z "$scratchpad" ]; then
        /opt/homebrew/bin/yabai -m window $wid --space mouse
        last_moved_wid=$wid
    fi
done < <(echo "$windows" | /opt/homebrew/bin/jq -c '.[]')

# 4. Focus on the last moved window and echo if there was a scratchpad
if [ -n "$last_moved_wid" ]; then
    /opt/homebrew/bin/yabai -m window --focus $last_moved_wid
    if [ "$has_scratchpad" = true ]; then
        echo "hasScratchpad"
    fi
fi