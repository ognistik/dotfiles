#!/bin/bash

sameWindow=$1

# Get the current date and time in the specified format
formatted_date=$(date "+%y%m%d - %I:%M %p")

# URL encode the formatted date using Python for more reliable encoding across different systems
encoded_date=$(python3 -c "import urllib.parse; print(urllib.parse.quote('''$formatted_date'''))")

# Construct the callback URL with the encoded date
if [[ -z "$sameWindow" ]]; then
callback_url="bear://x-callback-url/create?text=%23%20${encoded_date}%0A---%0A%230-inbox%0A---%0A&new_window=yes&open_note=yes&edit=yes"
else
callback_url="bear://x-callback-url/create?text=%23%20${encoded_date}%0A---%0A${sameWindow}%0A---%0A&new_window=no&open_note=yes&edit=yes"
fi

# Use open command to open the URL (works on macOS)
open "$callback_url"