#!/usr/bin/env bash

YABAI="/opt/homebrew/bin/yabai"
JQ="/opt/homebrew/bin/jq"

APP_NAME="$1"

if [ -z "$APP_NAME" ]; then
  echo "Usage: $0 \"App Name\""
  exit 2
fi

existing_window="$("$YABAI" -m query --windows | "$JQ" -r --arg app "$APP_NAME" '
  .[]
  | select(.app == $app and ."is-minimized" == false and ."has-ax-reference" == true)
  | .id
' | head -n 1)"

if [ -n "$existing_window" ]; then
  exit 0
fi

open -g -a "$APP_NAME"

osascript <<APPLESCRIPT
tell application "$APP_NAME"
    reopen
end tell
APPLESCRIPT

app_window=""

for i in {1..100}; do
  app_window="$("$YABAI" -m query --windows | "$JQ" -r --arg app "$APP_NAME" '
    .[]
    | select(
        .app == $app
        and ."is-minimized" == false
        and ."has-ax-reference" == true
      )
    | .id
  ' | head -n 1)"

  [ -n "$app_window" ] && break
  sleep 0.1
done

[ -n "$app_window" ] || exit 1

"$YABAI" -m window "$app_window" --space mouse
sleep 0.2
"$YABAI" -m window "$app_window" --focus