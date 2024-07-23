#!/bin/bash

#https://github.com/koekeishiya/yabai/issues/203#issuecomment-1088641580

if [ "$(/opt/homebrew/bin/yabai -m query --spaces --space | /opt/homebrew/bin/jq -r '.type')" = "stack" ]; then (/opt/homebrew/bin/yabai -m window --focus stack.next || /opt/homebrew/bin/yabai -m window --focus stack.first); else /opt/homebrew/bin/yabai -m window --focus next || /opt/homebrew/bin/yabai -m window --focus first; fi