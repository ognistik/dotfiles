#!/bin/zsh

app_name=$(/opt/homebrew/bin/yabai -m query --windows --window | /opt/homebrew/bin/jq -r '.app')
all_shortcuts_window_id=""
exclude_all_shortcuts=false

if [[ "$app_name" == "Shortcuts" ]]; then
  exclude_all_shortcuts=true
fi

# Get all window IDs and their app names, and titles for all open windows.
windows=$(/opt/homebrew/bin/yabai -m query --windows | /opt/homebrew/bin/jq -r '.[] | .id,.app,.title')

# Iterate over each window to identify "All Shortcuts" window and close other windows except those belonging to the specified app.
echo "$windows" | while read -r window_id; do
  read -r app
  read -r title
  
  if [[ "$app" == "$app_name" ]]; then
    if [[ "$title" == "All Shortcuts" && $exclude_all_shortcuts != true ]]; then
      all_shortcuts_window_id="$window_id"
    fi 
    continue # Skip closing windows of the specified app.
  else 
    /opt/homebrew/bin/yabai -m window "$window_id" --close 
  fi 
done

# Close "All Shortcuts" window at the end, if it exists and should not be excluded.
if [[ -n "$all_shortcuts_window_id" && $exclude_all_shortcuts != true ]]; then 
  /opt/homebrew/bin/yabai -m window "$all_shortcuts_window_id" --close 
fi 