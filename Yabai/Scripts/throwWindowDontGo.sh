#!/bin/bash

YABAI="/opt/homebrew/bin/yabai"
JQ="/opt/homebrew/bin/jq"

get_current_space() {
    $YABAI -m query --spaces --space | $JQ '.index'
}

get_last_space() {
    $YABAI -m query --spaces | $JQ 'map(.index) | max'
}

create_space_and_move_window() {
    $YABAI -m space --create
    $YABAI -m window --space last
}

case "$1" in
    "lastSpace")
        current_space=$(get_current_space)
        last_space=$(get_last_space)
        if [ "$current_space" -eq "$last_space" ]; then
            create_space_and_move_window
        else
            $YABAI -m window --space last
        fi
        ;;
    "firstSpace")
        if [ "$(get_current_space)" -eq 1 ]; then
            create_space_and_move_window
        else
            $YABAI -m window --space first
        fi
        ;;
    "leftSpace")
        if [ "$(get_current_space)" -eq 1 ]; then
            create_space_and_move_window
        else
            $YABAI -m window --space prev
        fi
        ;;
    "rightSpace")
        current_space=$(get_current_space)
        last_space=$(get_last_space)
        if [ "$current_space" -eq "$last_space" ]; then
            create_space_and_move_window
        else
            $YABAI -m window --space next
        fi
        ;;
esac