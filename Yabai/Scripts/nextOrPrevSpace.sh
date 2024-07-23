#!/bin/bash

current_space=$(/opt/homebrew/bin/yabai -m query --spaces --space | /opt/homebrew/bin/jq '.index')
first_space=1
last_space=$(/opt/homebrew/bin/yabai -m query --spaces | /opt/homebrew/bin/jq 'map(select(."is-native-fullscreen" == false)) | length')

if [ "$1" = "prev" ]; then
    if [ "$current_space" -eq "$first_space" ]; then
        /opt/homebrew/bin/yabai -m space --create && /opt/homebrew/bin/yabai -m space --focus last
    else
        /opt/homebrew/bin/yabai -m space --focus prev
    fi
else  # $1 = "next"
    if [ "$current_space" -eq "$last_space" ]; then
        if [ "$last_space" -eq 1 ]; then
            /opt/homebrew/bin/yabai -m space --create && /opt/homebrew/bin/yabai -m space --focus last
        else
            visible_windows=$(/opt/homebrew/bin/yabai -m query --windows | /opt/homebrew/bin/jq '[.[] | select(.["is-visible"] == true)] | length')
            if [ "$visible_windows" -eq 0 ]; then
                /opt/homebrew/bin/yabai -m space --focus first
            else
                /opt/homebrew/bin/yabai -m space --create && /opt/homebrew/bin/yabai -m space --focus last
            fi
        fi
    else
        /opt/homebrew/bin/yabai -m space --focus next
    fi
fi

sleep 0.2
echo "refresh" | nc -U /tmp/yabai-indicator.socket