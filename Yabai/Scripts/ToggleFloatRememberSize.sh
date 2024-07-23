#!/bin/bash

window_is_floating() {
    /opt/homebrew/bin/yabai -m query --windows --window | /opt/homebrew/bin/jq -re '."is-floating"' 2>/dev/null
}

toggle_float() {
    window_id=$(/opt/homebrew/bin/yabai -m query --windows --window | /opt/homebrew/bin/jq -r '.id')
    cache_dir="/tmp/yabai/float_cache"
    cache_file="$cache_dir/$window_id"
    
    mkdir -p "$cache_dir"
    
    if window_is_floating; then
        # Save current floating window position and size to cache
        /opt/homebrew/bin/yabai -m query --windows --window | /opt/homebrew/bin/jq -r '.frame | "\(.x) \(.y) \(.w) \(.h)"' > "$cache_file"
        # Toggle window to tiling mode
        /opt/homebrew/bin/yabai -m window --toggle float
    else
        # Toggle window to floating mode
        /opt/homebrew/bin/yabai -m window --toggle float
        if [ -f "$cache_file" ]; then
            # Restore the window's position and size from cache
            read -r x y w h < "$cache_file"
            /opt/homebrew/bin/yabai -m window --move abs:$x:$y
            /opt/homebrew/bin/yabai -m window --resize abs:$w:$h
        else
            # Center the window on the screen using --grid
            /opt/homebrew/bin/yabai -m window --grid 11:11:1:1:9:9
        fi
    fi
}

toggle_float