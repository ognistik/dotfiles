#!/bin/bash

# Toggle specific for apps that have a scratchpad by default (set in Yabairc)
toggle() {
  /opt/homebrew/bin/yabai -m window --toggle "$NAME" 2>/dev/null || osascript -e "tell application \"Keyboard Maestro Engine\" to do script \"rcmd: $NAME\"" > /dev/null 2>&1
}

# Notification for debugging
# osascript -e "display notification \"So far ok.\" with title \"YES\""

# This will handle toggling or setting scratchpads not set in Yabairc, including Bear, Arc, or my Solo Scratchpad.
toggleSpecial() { 
  # First let's deal with the Bear scratchpad case.
  if [[ $NAME == "bearScratchpad" ]]; then

    # Check if window has no title and close it if so. Seems to be a bug that only happens with Bear and this is a workaround...
    if [ "$YABAI_WINDOW_ID" != "" ]; then
        windowTitle=$(/opt/homebrew/bin/yabai -m query --windows --window $YABAI_WINDOW_ID | /opt/homebrew/bin/jq -r '.title')
        if [ "$windowTitle" = "" ]; then
            /opt/homebrew/bin/yabai -m window $YABAI_WINDOW_ID --close
            exit 0  # This will stop the entire script
        fi
    fi

    # If there is a Yabai Window ID it means this action was triggered by the signal in Yabairc for any new non-main windows.
    theWindow=$YABAI_WINDOW_ID

    # If we do not have a Yabai Window ID it means this action was triggered by manually floating or unfloating an existing window. We need its ID.
    if [ "$theWindow" = "" ]; then
      theWindow=$(/opt/homebrew/bin/yabai -m query --windows --window | /opt/homebrew/bin/jq -r '.id')
    fi

    # First we look for any existing Bear Scratchpads
    bearScratchpadId=$(/opt/homebrew/bin/yabai -m query --windows | /opt/homebrew/bin/jq -r '.[] | select(.scratchpad == "bearScratchpad") | .id')

    # There is already a Bear Scratchpad so...
    if [ "$bearScratchpadId" != "" ]; then
      # If we are focused on the Bear Scratchpad we want to toggle/remove it.
      if [ "$bearScratchpadId" = "$theWindow" ]; then
      /opt/homebrew/bin/yabai -m window $theWindow --scratchpad ""
      
      # If we are not on the Bear Scratchpad, this means we want it on our current window. Which means we have to remove it from whichever window has it and give it to the one in front of the user.
      else
      /opt/homebrew/bin/yabai -m window $bearScratchpadId --scratchpad ""
      /opt/homebrew/bin/yabai -m window $theWindow --scratchpad bearScratchpad --grid 8:8:3:1:2:6 --opacity 1.0
      fi

    # There are no existing Bear Scratchpads... We simply assign the Bear Scratchpad to the window.
    else
      /opt/homebrew/bin/yabai -m window $theWindow --scratchpad bearScratchpad --grid 8:8:3:1:2:6 --opacity 1.0
    fi

  elif [[ $NAME == "Safari" ]]; then
    # If there is a Yabai Window ID it means this action was triggered by the signal in Yabairc... or clicking a link.
    theWindow=$YABAI_WINDOW_ID

    # If we do not have a Yabai Window ID it means this action was triggered by manually floating or unfloating an existing window. We need its ID.
    if [ "$theWindow" = "" ]; then
      theWindow=$(/opt/homebrew/bin/yabai -m query --windows --window | /opt/homebrew/bin/jq -r '.id')
    fi

    # First we look for any existing Safari Scratchpads
    safariScratchpadId=$(/opt/homebrew/bin/yabai -m query --windows | /opt/homebrew/bin/jq -r '.[] | select(.scratchpad == "Safari") | .id')

    # There is already a Safari Scratchpad so...
    if [ "$safariScratchpadId" != "" ]; then
      # If we are focused on the Safari Scratchpad we want to toggle/remove it.
      if [ "$safariScratchpadId" = "$theWindow" ]; then
      /opt/homebrew/bin/yabai -m window $theWindow --scratchpad ""
      
      # If we are not on the Safari Scratchpad, this means we want it on our current window. Which means we have to remove it from whichever window has it and give it to the one in front of the user.
      else
      /opt/homebrew/bin/yabai -m window $safariScratchpadId --scratchpad ""
      /opt/homebrew/bin/yabai -m window $theWindow --scratchpad Safari --grid 11:11:1:1:9:9
      fi

    # There are no existing Safari Scratchpads... We simply assign the Safari Scratchpad to the window.
    else
      /opt/homebrew/bin/yabai -m window $theWindow --scratchpad Safari --grid 11:11:1:1:9:9
    fi
  elif [[ $ACTION == "nextNew" ]]; then
    # This is for the case in which I plan to open a window that I want directly to have the Solo Scratchpad property.
    # First it finds the existing scratchpad
    scratchpadId=$(/opt/homebrew/bin/yabai -m query --windows | /opt/homebrew/bin/jq -r '.[] | select(.scratchpad == "scratchpad") | .id')

    # If it got to this point, it means that there is already an existing scratchpad... so let's do the switch.
    /opt/homebrew/bin/yabai -m window $scratchpadId --scratchpad ""
    /opt/homebrew/bin/yabai -m window $YABAI_WINDOW_ID --scratchpad "scratchpad" --grid 11:11:1:1:9:9
    osascript -e "display notification \"Your Solo Scratchpad has been updated!\" with title \"SOLO SCRATCHPAD SWITCH\""
  else
   # This action is basically for Arc, which is the only other toggleSpecial aside from Bear or an upcoming insert stratchpad window.
   # If there is a Yabai Window ID it means this action was triggered by the signal (new little arc or clicking a link) set for Arc in Keyboard Maestro.
   theWindow=$YABAI_WINDOW_ID
    # If we do not have a Yabai Window ID it means this action was triggered by manually floating or unfloating an existing window. We need its ID.
    if [ "$theWindow" = "" ]; then
      theWindow=$(/opt/homebrew/bin/yabai -m query --windows --window | /opt/homebrew/bin/jq -r '.id')
    fi
    # First we look for any existing Arc Scratchpads
    arcScratchpadId=$(/opt/homebrew/bin/yabai -m query --windows | /opt/homebrew/bin/jq -r '.[] | select(.scratchpad == "arcScratchpad") | .id')
    # There is already an Arc Scratchpad so...
    if [ "$arcScratchpadId" != "" ]; then
      # If we are focused on the Arc Scratchpad we want to toggle/remove it.
      if [ "$arcScratchpadId" = "$theWindow" ]; then
      /opt/homebrew/bin/yabai -m window $theWindow --scratchpad ""
      # -> aparently this was needed at some point /opt/homebrew/bin/yabai -m window $theWindow --toggle float
      else
      # If we are not on the Arc Scratchpad, this means we want it on our current window. Which means we have to remove it from whichever window has it and give it to the one in front of the user.
          /opt/homebrew/bin/yabai -m window $arcScratchpadId --scratchpad ""
          # Query the window's floating status
           isFloating=$(/opt/homebrew/bin/yabai -m query --windows --window $arcScratchpadId | /opt/homebrew/bin/jq '.["is-floating"]')
          # If the window is floating, unfloat it (tile it)
           if [ "$isFloating" = "true" ]; then
              /opt/homebrew/bin/yabai -m window $arcScratchpadId --toggle float
          fi
      # The stupid auto act resizing needs this extra delay when clicking links directly. Not necessary with litle arc shortcut.
      if [ "$ARCDELAY" != "" ]; then
      sleep 0.2
      fi
      /opt/homebrew/bin/yabai -m window $theWindow --scratchpad arcScratchpad --grid 11:11:1:1:9:9
      fi
    # There are no existing Arc Scratchpads... We simply assign the Arc Scratchpad to the window.
    else
      # The stupid auto act resizing needs this extra delay when clicking links directly. Not necessary with litle arc shortcut.
      if [ "$ARCDELAY" != "" ]; then
      sleep 0.3
      fi
      /opt/homebrew/bin/yabai -m window $theWindow --scratchpad arcScratchpad --grid 11:11:1:1:9:9
    fi
  fi
}

toggle_others() {
/opt/homebrew/bin/yabai -m window $(
      /opt/homebrew/bin/yabai -m query --windows |
      /opt/homebrew/bin/jq -r "[.[] | select(.scratchpad != \"\" and .scratchpad != \"$NAME\" and .\"is-visible\"==true) 
          | \"--toggle \" + .scratchpad ] | join(\" \")"
  ) 2>/dev/null
}

ACTION="$1"
NAME="$2"
ARCDELAY="$3"
# The simplest toggle action.
if [[ $ACTION == "toggle" ]]; then
  toggle
# For Bear, basically.
elif [[ $ACTION == "toggleOrNewBear" ]]; then
  # Assigned to my quick note / note toggle shortcut. It will try to toggle bearScratchpad, if it fails it means there are NO floating Bear notes... so it will make a new one.
  /opt/homebrew/bin/yabai -m window --toggle "$NAME" || ~/Documents/GitHubRepos/dotfiles/Karabiner/Scripts/bearNewNote.sh
# For Little Arcs, basically.
elif [[ $ACTION == "toggleOrNewArc" ]]; then
  /opt/homebrew/bin/yabai -m window --toggle "$NAME" || osascript -e "tell application \"Keyboard Maestro Engine\" to do script \"$NAME\""
# Now dealing for a new window scratchpad.
elif [[ $ACTION == "nextNew" ]]; then
    # If it can add the scratchpad without issues then all good, if not we will have to do a scratchpad switch.
    if /opt/homebrew/bin/yabai -m window $YABAI_WINDOW_ID --scratchpad "scratchpad" --grid 11:11:1:1:9:9; then
        osascript -e 'display notification "Your Solo Scratchpad is now set!" with title "SOLO SCRATCHPAD SET"'
    else
        toggleSpecial
    fi
else
  # This one is mainly for Arc and Bear, if no scratchpads to toggle... after a window has been created and needs to loop back through here. Both will go different ways in the toggleSpecial function.
  toggleSpecial
fi
toggle_others

exit 0