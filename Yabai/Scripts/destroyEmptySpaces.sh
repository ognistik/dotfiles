#!/usr/bin/env bash

# Check if there's any fullscreen space and exit if there is
yabai -m query --spaces --display | \
jq -re 'all(."is-native-fullscreen" | not)' &> /dev/null || exit;

# Get a list of hidden, minimized, or scratchpad windows
# hidden_minimized=$(yabai -m query --windows | jq 'map(select(."is-hidden" or ."is-minimized" or .scratchpad != "")) | map(."id")');

# To treat minimized as existent (exceptions to destroy spaces)
hidden_minimized=$(yabai -m query --windows | jq 'map(select(."is-hidden" or .scratchpad != "")) | map(."id")');

# Get a list of Kando window IDs
kando_windows=$(yabai -m query --windows | jq -r 'map(select(.app == "Kando")) | map(."id")')

# Get a list of Kando window IDs
alter_windows=$(yabai -m query --windows | jq -r 'map(select(.app == "Alter" and .subrole == "AXSystemDialog")) | map(."id")')

# Get a list of BetterMouse window IDs
bettermouse_windows=$(yabai -m query --windows | jq -r 'map(select(.app == "BetterMouse")) | map(."id")')

# Get a list of ScreenStudio window IDs
screenstudio_windows=$(yabai -m query --windows | jq -r 'map(select(.app == "Screen Studio" and (.title | startswith("Project") | not))) | map(."id")')

# Find and destroy empty, unfocused spaces
yabai -m query --spaces | \
jq -re "map(select((.\"has-focus\" | not) and (\
  .\"windows\" | map(select(. as \$window | $hidden_minimized + $kando_windows + $bettermouse_windows + $screenstudio_windows + $alter_windows | index(\$window) | not))\
  ) == []).index) | reverse | .[]" | \
xargs -I % sh -c 'yabai -m space % --destroy' 

# sleep 0.1
# echo \"refresh\" | nc -U /tmp/yabai-indicator.socket

