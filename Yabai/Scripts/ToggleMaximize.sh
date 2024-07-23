#!/bin/bash

window_is_floating() {
    /opt/homebrew/bin/yabai -m query --windows --window | /opt/homebrew/bin/jq -re '."is-floating"' 2>/dev/null
}

toggle_zoom() {
    if window_is_floating; then
        window_id=$(/opt/homebrew/bin/yabai -m query --windows --window | /opt/homebrew/bin/jq -r '.id')
        cache_dir="/tmp/yabai/zoom_cache"
        cache_file="$cache_dir/$window_id"
        
        mkdir -p "$cache_dir"
        
        if [ -f "$cache_file" ]; then
            read -r x y w h < "$cache_file"
            /opt/homebrew/bin/yabai -m window --resize abs:$w:$h
            /opt/homebrew/bin/yabai -m window --move abs:$x:$y
            rm -f "$cache_file"
        else
            /opt/homebrew/bin/yabai -m query --windows --window | /opt/homebrew/bin/jq -r '.frame | "\(.x) \(.y) \(.w) \(.h)"' > "$cache_file"
            /opt/homebrew/bin/yabai -m window --grid 1:1:0:0:1:1
        fi
    else
        /opt/homebrew/bin/yabai -m window --toggle zoom-fullscreen
    fi
}

toggle_zoom