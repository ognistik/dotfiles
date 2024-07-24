#!/bin/bash

# This script is specifically when little arc is triggered with a key binding...
# It's not supposed to replace the functionality of clicking 
# links outside of arc or in arc with modifiers

# Get the window id from the argument
window_id=$YABAI_WINDOW_ID
myaction=$1

desktop_path="$HOME/Desktop/debug.txt"
# echo "works" > "$desktop_path"

# Query Yabai for window information
window_info=$(/opt/homebrew/bin/yabai -m query --windows --window "$window_id")

# Extract the app
app=$(echo "$window_info" | /opt/homebrew/bin/jq -r '.app')

# Check if app is Arc and my action
if [[ "$myaction" == "center" ]]; then
    /opt/homebrew/bin/yabai -m window "$window_id" --grid 11:11:1:1:9:9
    /opt/homebrew/bin/yabai -m signal --remove arcfloater
elif [[ "$myaction" == "tile" ]]; then
    /opt/homebrew/bin/yabai -m window "$window_id" --toggle float
    /opt/homebrew/bin/yabai -m signal --remove arcfloater
fi