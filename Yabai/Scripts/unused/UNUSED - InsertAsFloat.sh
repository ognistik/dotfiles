#!/bin/bash

# Path to Yabai
YABAI_PATH="/opt/homebrew/bin/yabai"

# Add a signal to Yabai that will float and center the next created window
$YABAI_PATH -m signal --add label=float_next event=window_created action="
  $YABAI_PATH -m window \$YABAI_WINDOW_ID --toggle float --layer below;
  window=\$($YABAI_PATH -m query --windows --window \$YABAI_WINDOW_ID);
  display=\$($YABAI_PATH -m query --displays --display \$(jq -nr \"\$window.display\"));
  coords=\$(jq -nr --argjson window \"\$window\" --argjson display \"\$display\" \
    \"((\\\$display.frame.x + \\\$display.frame.w / 2) - (\\\$window.frame.w / 2) | tostring) + \\\":\\\" + ((\\\$display.frame.y + \\\$display.frame.h / 2) - (\\\$window.frame.h / 2) | tostring)\");
  $YABAI_PATH -m window \$YABAI_WINDOW_ID --move abs:\$coords;
  $YABAI_PATH -m signal --remove float_next;
"

# Make sure to save this script to a file and make it executable with `chmod +x filename.sh`.
# Then bind this script to a key combination using your hotkey daemon (like skhd).
