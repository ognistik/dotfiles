#!/bin/bash

clear_float_cache() {
    cache_dir="/tmp/yabai/float_cache"
    # Check if the cache directory exists
    if [ -d "$cache_dir" ]; then
        # Remove all files within the cache directory
        rm -f "$cache_dir"/*
        echo "All cached window sizes and positions have been cleared."
    else
        echo "Cache directory does not exist. No action taken."
    fi
}

clear_float_cache