#!/bin/bash

app_name="$1"

# Query the current window
current_window=$(/opt/homebrew/bin/yabai -m query --windows --window)
current_app=$(echo "$current_window" | /opt/homebrew/bin/jq -r '.app')
current_scratchpad=$(echo "$current_window" | /opt/homebrew/bin/jq -r '.scratchpad')

if [ "$current_app" == "$app_name" ]; then
	if [ "$current_scratchpad" != "" ]; then
    		echo "onWindowWithScratchpad"
	else
		echo "onWindowNoScratchpad"
	fi
else
    # Query all windows
    all_windows=$(/opt/homebrew/bin/yabai -m query --windows)
    
    # Check if there are any App (incoming app) windows
    app_windows=$(echo "$all_windows" | /opt/homebrew/bin/jq "[.[] | select(.app == \"$app_name\")]")

    if [ $(echo "$app_windows" | /opt/homebrew/bin/jq 'length') -eq 0 ]; then
        echo "noWindows"
    else 
        # Check for any App windows without scratchpad property that has something
        non_scratchpad_window=$(echo "$app_windows" | /opt/homebrew/bin/jq -r '.[] | select(.scratchpad == "") | .id')
        
        if [ "$non_scratchpad_window" = "" ]; then
            echo "onlyScratchpadWindows"
        else 
            # Focus on the most recently used non-scratchpad App window (assuming first in list is most recent)
            # /opt/homebrew/bin/yabai -m window --focus $(echo $non_scratchpad_window | awk '{print $1}')
            # Actually, I'll just echo the window ID to focus and do this back in KM
            echo $non_scratchpad_window | awk '{print $1}'
        fi 
    fi 
fi 