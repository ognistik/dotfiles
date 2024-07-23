#!/bin/bash

win=$(/opt/homebrew/bin/yabai -m query --windows --window last | /opt/homebrew/bin/jq '.id')

while : ; do
    /opt/homebrew/bin/yabai -m window $win --swap prev &> /dev/null
    if [[ $? -eq 1 ]]; then
        break
    fi
done