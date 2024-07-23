#!/usr/bin/env bash

# Check if there's any fullscreen space and exit if there is
yabai -m query --spaces --display | \
jq -re 'all(."is-native-fullscreen" | not)' &> /dev/null || exit;

# Get a list of hidden, minimized, or scratchpad windows
hidden_minimized=$(yabai -m query --windows | jq 'map(select(."is-hidden" or ."is-minimized" or .scratchpad != "")) | map(."id")');

# To treat scratchpads as existent
# hidden_minimized=$(yabai -m query --windows | jq 'map(select(."is-hidden" or ."is-minimized")) | map(."id")');

# Get a list of Kando window IDs
kando_windows=$(yabai -m query --windows | jq -r 'map(select(.app == "Kando")) | map(."id")')
# echo "$kando_windows" > "/Users/ognistik/Desktop/testo.txt"

# Find and destroy empty, unfocused spaces
yabai -m query --spaces | \
jq -re "map(select((.\"has-focus\" | not) and (\
  .\"windows\" | map(select(. as \$window | $hidden_minimized + $kando_windows  | index(\$window) | not))\
  ) == []).index) | reverse | .[]" | \
xargs -I % sh -c 'yabai -m space % --destroy' 

# sleep 0.1
# echo \"refresh\" | nc -U /tmp/yabai-indicator.socket