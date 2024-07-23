# KARABINER - Config
---
## ToC
- [KARABINER - Config](#karabiner---config)
  - [ToC](#toc)
  - [Simple Modifications](#simple-modifications)
  - [CLEAN BASE LAYER](#clean-base-layer)
  - [DELETE MODS](#delete-mods)
  - [W MODE (YABAI WINDOWS)](#w-mode-yabai-windows)
    - [W BASE Layer - No Modifiers](#w-base-layer---no-modifiers)
    - [W CMD (Misc and go to space)](#w-cmd-misc-and-go-to-space)
    - [W D (Insert, Stack, Throw \& Don’t Go)](#w-d-insert-stack-throw--dont-go)
    - [W F (Focus)](#w-f-focus)
    - [W G (Swap \& Throw \& Go)](#w-g-swap--throw--go)
    - [W R (Rotate \& Resize)](#w-r-rotate--resize)
    - [W C (Send to Space \& Don’t Go)](#w-c-send-to-space--dont-go)
    - [W V (Send to Space \& Go)](#w-v-send-to-space--go)
  - [E MODE (NUMPAD)](#e-mode-numpad)
  - [T MODE (MARKDOWN \& TEXT TRANSFORMS)](#t-mode-markdown--text-transforms)
    - [Base Layer](#base-layer)
    - [Spacebar Sublayer](#spacebar-sublayer)
  - [CAPS MODE \& F19](#caps-mode--f19)
    - [CAPS MODE](#caps-mode)
      - [Numbers for Media Keys](#numbers-for-media-keys)
      - [Base Layer](#base-layer-1)
      - [(E) Arc Extension Commands](#e-arc-extension-commands)
      - [(S) Arc Popups and Macros](#s-arc-popups-and-macros)
      - [(D) Dropover \& Clop Commands](#d-dropover--clop-commands)
      - [(C) CleanShot](#c-cleanshot)
    - [F19 MODE](#f19-mode)
      - [Base Layer](#base-layer-2)
      - [Spacebar Sublayer](#spacebar-sublayer-1)
  - [A MODE (KIKI AI)](#a-mode-kiki-ai)
    - [Base Layer](#base-layer-3)
    - [CMD Sublayer](#cmd-sublayer)
    - [Selected Text Actions](#selected-text-actions)
      - [Replace (R)](#replace-r)
      - [Place Below (B)](#place-below-b)
      - [Dialog Response (D)](#dialog-response-d)
  - [SD MODE (TEXT, WINDOW, AND TAB NAVIGATION)](#sd-mode-text-window-and-tab-navigation)
    - [Arrows](#arrows)
    - [Modifiers](#modifiers)
    - [Deletes](#deletes)
    - [Window/Tab Switchers | Excluding Arc](#windowtab-switchers--excluding-arc)
    - [Arc Tab Navigation](#arc-tab-navigation)
    - [App Switchers](#app-switchers)
    - [Possible Combinations for Text Navigation](#possible-combinations-for-text-navigation)
  - [F MODE (POINTER MOVEMENT)](#f-mode-pointer-movement)
    - [Movement Speed 1](#movement-speed-1)
    - [Movement Speed 2](#movement-speed-2)
    - [Movement Speed 3](#movement-speed-3)
    - [Movement Speed 4](#movement-speed-4)

--- 
## Simple Modifications
* Non US Backlash to Grave Accent & Tile
* Right Control to FN

## CLEAN BASE LAYER
* FCPX *(For keyboarding)*<!-- {"fold":true} -->
  * Cmd + Shift + m = Ctrl 1
  * Cmd + Shift + comma = Ctrl 2
  * Cmd + Shift + period = Ctrl 3
  * Cmd + Shift + j = Ctrl 4
  * Cmd + Shift + k = Ctrl 5
  * Cmd + Shift + l = Ctrl 6
  * Cmd + Shift + u = Ctrl 7
  * Cmd + Shift + i = Ctrl 8
  * Cmd + Shift + o = Ctrl 9
* FN + Numbers = F Keys

## DELETE MODS
*SD Mode adds a few more deletes.*
* Right Shift = Delete forward on tap, Shift on hold
* Left Shift = Delete backward on tap, Shift of hold
* Right Shift while holding Left Shift = Caps Lock
* "A" while holding Semicolon = Deletes backwards by words

---
## W MODE (YABAI WINDOWS)
### W BASE Layer - No Modifiers
* tab: restart Yabai service
* q: Toggle layer Normal & Below
* e: Mission Control
* t: Toggle gap and padding
* y: Hide every other window
* u: Mirror on Y axis
* I: Mirror on X axis
* o: Hide current window
* caps lock: stop Yabai service
* a: Toggle Sticky
* h: Move west
* j: Move south
* k: Move north
* l: Move east
* semicolon: Create space & Don’t Go
* quote: Create space & Go
* enter: Toggle Fullscreen Zoom
* b: Reset balance
* n: Switch to first space
* m: Switch space to the left space
* comma: Switch to next space
* period: Switch to last space
* right shift: Switch to previous space
* spacebar: Toggle Float

### W CMD (Misc and go to space)
* caps lock: start Yabai service
* e: show Desktop
* t: Toggle split vertical or horizontal 
* **y: Available** 
* u: Go to Space 7
* I: Go to Space 8
* o: Go to Space 9
* j: Go to Space 4
* k: Go to Space 5
* l: Go to Space 6
* semicolon: Destroy current space
* quote: Destroy last space
* enter: Toggle layout as stack or tiles
* ***n: Available***
* m: Go to Space 1 
* comma: Go to Space 2
* period: Go to Space 3
* space: clear float cache

### W D (Insert, Stack, Throw & Don’t Go)
* y: Insert West
* u: Insert South
* I: Insert North
* o: Insert East
* h: Stack West
* j: Stack South
* k: Stack North
* l: Stack East
* semicolon: Create Space, Throw Window, & Don’t Go
* return: Insert as scratchpad
* n: Throw window & DON’T Go to first space
* m: Throw window & DON’T Go to space on LEFT
* comma: Throw window & DON’T Go to space on RIGHT
* period: Throw window & DON’T Go last space
* right shift: Insert as stack
* spacebar: Insert as float

### W F (Focus)
* y: Focus Cycle Backwards (No Stack or Floats).
* u: Focus below in Stack.
* I: Focus above in Stack.
* o: Focus Cycle Forward (No Stack or Floats).
* h: Focus west
* j: Focus south
* k: Focus north
* l: Focus east
* enter: Real Full Screen (BTT)
* n: Focus Cycle Backwards (All)
* m: Lock full opacity
* comma: Reset opacity to default
* period: Focus Cycle Forwards (All)

### W G (Swap & Throw & Go)
* ***y: Available***
* ***u: Available***
* ***I: Available***
* ***o: Available***
* h: Swap west
* j: Swap south
* k: Swap north
* l: Swap east
* Semicolon: Create space, Throw Window & Go
* n: Throw & Go first space
* m: Throw & Go Space on Left
* comma: Throw & Go Space on Right
* period: Throw & Go last space

### W R (Rotate & Resize)
* e: Reveal app windows
* y: Resize West
* u: Resize South
* i: Resize North
* o: Resize East
* h: Rotate Arrangement in reverse
* j: Rotate windows only in reverse
* k: Rotate windows only forward
* l: Rotate Arrangement forward
* enter: Toggle Parent Zoom
* n: Move floating window left
* m: Move floating window down
* comma: Move floating window up
* period: Move floating window right

### W C (Send to Space & Don’t Go)
* u: To Space 7
* I: To Space 8
* o: To Space 9
* h: To Space 4
* j: To Space 5
* k: To Space 6
* m: To Space 1
* comma: To Space 2
* period: To Space 3

### W V (Send to Space & Go)
* u: To Space 7
* I: To Space 8
* o: To Space 9
* h: To Space 4
* j: To Space 5
* k: To Space 6
* m: To Space 1
* comma: To Space 2
* period: To Space 3

---
## E MODE (NUMPAD)
| BS  | 7   | 8   | 9   |     |
|-----|-----|-----|-----|-----|
| .   | 4   | 5   | 6   | -   |
| 0   | 1   | 2   | 3   | =   |
* y = Delete or Backspace
* u = 7
* i = 8
* o = 9
* h = period
* j = 4
* k = 5
* l = 6
* semicolon = minus (hyphen)
* n = 0
* m = 1
* comma = Two
* period = Three
* right shift = Equal sign

*F and S sublayers access symbols*

---
## T MODE (MARKDOWN & TEXT TRANSFORMS)
### Base Layer
* r: Search and Replace
* y: Sentence Case
* u: Uppercase
* i: Italics
* o: Title Case
* p: Parenthesis
* open bracket: Enclose in Brackets
* h: Highlight
* j: Underline
* k: Block Quote
* l: Add Link
* semicolon: Strikethrough
* quote: Single Quotes
* b: Bold
* n: Lowercase
* m: Between Lines
* comma: Code Line
* period: Code Block

### Spacebar Sublayer
* i: Bold & Italics
* open bracket: Enclose in Curly Brackets
* h: TextSoap Cleaners
* j: Custom TextSoap Cleaners
* k: Case Cleaners
* l: Remove links
* quote: Double Quotes
* n: Enclose Cleaners
* m: Markdown Cleaners

---
## CAPS MODE & F19
***CAPS LOCK:** Quick tap = escape | quick tap + key = caps mode | tap + hold = F19 mode*

### CAPS MODE
*Caps Mode has to be quickly locked before f19 kicks in.* 

#### Numbers for Media Keys
* Equal sign = Volume Up
* CMD + Equal Sign = Switch Audio to Airpods
* Hyphen = Volume Down
* CMD + Hyphen = Switch Audio to Speakers
* 0 = Mute
* CMD + 0 = With Audio to Laptop
* 9 = Fast forward
* CMD + 9 = External Headphones
* 8 = Play or pause
* 7 = Rewind
* 6 = NOTHING
* 5 = Night Mode
* 4 = Launchpad
* 3 = Mission Control
* 2 = Increase display brightness
* CMD + 2 = Increase keyboard illumination
* 1 = Decrease display brightness
* CMD + 1 = Decrease keyboard illumination

#### Base Layer
* w = Delete Bear Note
* r = Readwise to Bear Shortcut
* i = Answer iMessage notification
* o = Day One master shortcut.
* p = Update Plex Server
* a = Caffeinate workflow Alfred
* cmd + d = Finder on Dropbox
* f= Finder window on Desktop
* cmd + f = Finder window on DropOver folder
* g = Favorites Alfred workflow
* h = Homerow scroll 
* j = Homerow hints *(space = rotating labels | shift = right click | cmd = cmd click | double enter = double click)*.
* k = Superkey Seek static
* l = Alfred get link from front window
* semicolon = Spanish ñ
* quote = Spanish tilde
* b = Bartender search menu bar
* n = Close notifications with BTT
* m = Menu bar search Alfred workflow
* cmd + m = Menu bar of current window
* comma = screen saver.
* period single tap = sleeps display
* period double tap = sleeps system
* Right shift = New floating Little Arc (Scratchpad)
* Cmd + right shift = New tiled Little Arc
* Spacebar = New floating bear note
* Caps + spacebar = New tiled bear note (Scratchpad)

#### (E) Arc Extension Commands
* **Sublayer E**
  * r: Readwise Add
  * y: Activate Bitwarden Extension
  * u: Autofill with Bitwarden
  * p: PiP for videos
  * d: Raindrop Add
  * H: Arc Media - Slower
  * j: Arc Media - Rewind 15 Secs
  * k: Arc Media - Forward 15 Secs
  * l: Arc Media - Faster
  * M: Arc Media - Rewind a Bit
  * comma: Arc Media - Forward a Bit
  * period: Arc Media - Reset Speed
  * spacebar: Close Overlay Extension

#### (S) Arc Popups and Macros
* **Sublayer S**
  * right_shift: Open current page in OpenIn
  * CMD + right_shift: Open link under mouse in OpenIn
  * spacebar: Open Clipboard URL in OpenIn
  * y: Google selection as unpinned and see
  * u: Google selection as float
  * I: Google selection as tile
  * o: Google selection as unpinned in BG
  * h: Open current page as unpinned and see
  * j: Open current page as float
  * k: Open current page as tile
  * l: Open current page as unpinned in BG
  * return: Arc history Alfred workflow
  * n: Open link under mouse as unpinned and see
  * m: Open link under mouse as float
  * comma: Open link under mouse as tile
  * period: Open link under mouse as unpinned in BG

#### (D) Dropover & Clop Commands
* **Sublayer D**
  * r: Reveal location
  * y: Dropover move to Desktop
  * u: Dropover Optimize quick
  * i: Dropover Optimize Aggressive
  * o: Clop Optimize  Clipboard
  * p: Clop Optimize Clipboard Aggressive
  * open bracket: Workflow on Clipboard
  * s: Pin Files on Shelf
  * f: Open Shelf with OpenIn
  * g: Video to Gif
  * h: previous shelf
  * j: move here (front finder window)
  * k: airdrop
  * l: close shelf
  * semicolon: Dock Shelf
  * quote: Alfred Actions on Shelf
  * c: Send to CleanShot
  * n: Drop delete
  * m: Clop Simple Optimize on Finder File
  * comma: Clop Aggressive Optimization on Finder File
  * period: Clop Workflow on Finder Selection
  * right shift: Clop Workflow on Dropover Selection
  * enter: Shelf Command or Search Bar
  * Spacebar: Shelf from Clipboard
  * left command: Dropover from selected file, through Clipboard

#### (C) CleanShot
* **Sublayer C**
  * y: OCR with Linebreaks
  * u: OCR without Linebreaks
  * i: Scrolling Capture
  * o: Fullscreen Capture
  * s: Pin Selection on Finder
  * d: All in One Bar
  * h: Capture Area and Pin
  * j: Capture area
  * k: Capture area to Clipboard
  * l: Capture Area and Annotate
  * Semicolon: Toggle Desktop icons
  * Quote: Toggle Pins Visibility
  * Return: Annotate Finder Selection
  * right shift: Capture History
  * spacebar: Annotate from Clipboard

### F19 MODE
*F19 is mapped to Superkey Seek*

#### Base Layer
* Left Command = Delete backward
* Right Command = Acts as tab, to switch between different Seek options.
* a = letter A on tap, Control on hold
* s = letter S on tap, Option on hold
* d = letter C on tap, Command on hold

#### Spacebar Sublayer
* Spacebar + E = Escape from F19 mode and locks Caps Mode
* Spacebar + Semicolon = Ñ character
* Spacebar + Quote = Spanish tilde

---
## A MODE (KIKI AI)
### Base Layer
* f: Reveal Kiki Data Path
* CMD f: Reveal Kiki Workflow Editor
* h: Copy Last Response
* j: Copy Context File to Specified Path
* return: Trigger Markdown Chat in Bear
* m: Presets Menu
* spacebar: Quick Chat

### CMD Sublayer
* t: Translate to English - Response in Dialog
* s: Simplify - Paste in Frontmost App

### Selected Text Actions
#### Replace (R)
* spacebar: Add a Custom Prompt
* p: Use as Prompt
* m: Send to Presets Menu

#### Place Below (B)
* spacebar: Add a Custom Prompt
* p: Use as Prompt
* m: Send to Presets Menu

#### Dialog Response (D)
* spacebar: Add a Custom Prompt
* p: Use as Prompt
* m: Send to Presets Menu

---
## SD MODE (TEXT, WINDOW, AND TAB NAVIGATION)
### Arrows
* H = Left arrow
* J = Down arrow
* K = Up arrow
* L = Right arrow

### Modifiers
* Left Command = VS Code Selection Shortcut
* Caps Lock = Escape App or Window Switchers
* Spacebar = Shift
* f = Left Command
* a = Left OPT
* z = Left Control

### Deletes
* n = Delete or backspace
* period = Delete forward

### Window/Tab Switchers | Excluding Arc
* y = Window Switcher - Below
* u = Tab Switcher - Below
* i = Tab Switcher - Above
* o = Window Switcher - Above

### Arc Tab Navigation
* y = Open Tabs Switcher - Previous
* u = Tab Below
* i = Tab Above
* o = Open Tabs Switcher - Next
* 7 = Close Selected Tab in Tabs Switcher

### App Switchers
* m = Previous App
* comma = Toggle Off Any Scratchpad

### Possible Combinations for Text Navigation
* h & l = Left / Right moves by character
* spacebar + h & spacebar + l = Left / Right selection by character
* n & period = Delete Backwards & Forward by character
* a + h & a + l = Left / Right moves by word
* a + spacebar + h & a + spacebar + l = Left / Right selection by word
* a + n & a + period = Delete Backwards & Forward by word
* f + h & f + l = Move to beginning or end of line
* f + spacebar + h & f + spacebar + l = Select to the beginning or end of line
* f + n & f + period = Delete to the beginning or end of line

---
## F MODE (POINTER MOVEMENT)
* y = Left Mouse Button
* u = Middle Mouse Button
* i = Right Mouse Button
* o = Drag from Dropover to Current Position
* s = focus window under cursor
* d = Left Mouse Button

### Movement Speed 1
* h = Left
* j = Bottom
* k = Top
* l = Right

### Movement Speed 2
* Spacebar + h = Left
* Spacebar + j = Bottom
* Spacebar + k = Top
* Spacebar + l = Right

### Movement Speed 3
* n = Left
* m = Bottom
* comma = Top
* period = Right

### Movement Speed 4
* Spacebar + n = Left
* Spacebar + m = Bottom
* Spacebar + comma = Top
* Spacebar + period = Right
