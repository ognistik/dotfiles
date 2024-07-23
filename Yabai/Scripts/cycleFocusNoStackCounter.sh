#!/bin/bash

#https://github.com/koekeishiya/yabai/issues/203#issuecomment-1088641580

if [ "$(/opt/homebrew/bin/yabai -m query --spaces --space | /opt/homebrew/bin/jq -r '.type')" = "stack" ]; then (/opt/homebrew/bin/yabai -m window --focus stack.prev || /opt/homebrew/bin/yabai -m window --focus stack.last); else /opt/homebrew/bin/yabai -m window --focus prev || /opt/homebrew/bin/yabai -m window --focus last; fi