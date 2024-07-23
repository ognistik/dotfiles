#!/bin/bash

APP_NAME="$1"

for wid in $(/opt/homebrew/bin/yabai -m query --windows | /opt/homebrew/bin/jq ".[] | select(.app == \"$APP_NAME\") | .id"); do
  /opt/homebrew/bin/yabai -m window $wid --space mouse
done