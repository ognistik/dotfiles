#!/bin/bash

win=$(/opt/homebrew/bin/yabai -m query --windows --window first | /opt/homebrew/bin/jq '.id')

while : ; do
    /opt/homebrew/bin/yabai -m window $win --swap next &> /dev/null
    if [[ $? -eq 1 ]]; then
        break
    fi
done