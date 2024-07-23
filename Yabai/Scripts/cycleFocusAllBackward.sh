#!/usr/bin/env sh

# https://github.com/koekeishiya/yabai/issues/203#issuecomment-700527407

#/opt/homebrew/bin/yabai -m query --spaces --space \
#  | /opt/homebrew/bin/jq -re ".index" \
#  | xargs -I{} /opt/homebrew/bin/yabai -m query --windows --space {} \
#  | /opt/homebrew/bin/jq -sre "add | map(select(.minimized != 1)) | sort_by(.display, .frame.y, .frame.y, .id) | nth(index(map(select(.\"has-focus\" == true))) - 1).id" \
#  | xargs -I{} /opt/homebrew/bin/yabai -m window --focus {}

[ $(/opt/homebrew/bin/yabai -m query --windows --space | /opt/homebrew/bin/jq -re "map(select(.\"has-focus\" == true)) | length != 0") = true ] && /opt/homebrew/bin/yabai -m window --focus "$(/opt/homebrew/bin/yabai -m query --windows --space | /opt/homebrew/bin/jq -re "[sort_by(.id, .frame) | .[] | select(.role == \"AXWindow\" and .subrole == \"AXStandardWindow\") | .id] | nth(index($(/opt/homebrew/bin/yabai -m query --windows --window | /opt/homebrew/bin/jq -re ".id")) - 1)")" ||  /opt/homebrew/bin/yabai -m window --focus "$(/opt/homebrew/bin/yabai -m query --spaces --space | /opt/homebrew/bin/jq -re ".windows[0]?")" &> /dev/null