# Features in detail

Full descriptions and screenshots for every feature listed in the
[README](README.md#what-does-it-add). See the README for install/uninstall
instructions and the general overview.

Quick jump:

  * [GM QoL Toolbox Options](#gm-qol-toolbox-options)
  * [Plugins → Advanced Search](#advanced-search)
  * [IDE main toolbar — quick-access buttons](#toolbar-buttons)
  * [Plugins → Check Object Usage](#check-object-usage)
  * [Object Editor — Usage button](#object-editor-usage-button)
  * [Inspector — Usage section (objects)](#inspector-usage-section)
  * [Object Editor — green section icons](#object-editor-green-icons)
  * [Object Editor — opening the collision object](#object-editor-events-open-collision)
  * [Object Editor — `Collision (Select)...`](#object-editor-collision-select)
  * [Plugins → Check Sprite Usage](#check-sprite-usage)
  * [Sprite Editor — Usage button](#sprite-editor-usage-button)
  * [Inspector — Usage section (sprites)](#inspector-usage-section-sprites)
  * [Image Editor — `Convert to Frames` Auto checkbox](#image-editor-convert-to-frames-auto)
  * [`F11` — collapsing/expanding the bottom dock](#f11-bottom-dock)
  * [Resource editors — `Find in Resource Tree`](#find-in-resource-tree)
  * [Workspace — `Rearrange Windows` / `Close All Windows`](#rearrange-close-windows)
  * [`Shift+F4` — Recent Resources](#shift-f4-recent-resources)
  * [Room Editor — Move Assets](#room-editor-move-assets)
  * [Room Editor — Room Assets Palette](#room-editor-assets-palette)
  * [Room Editor — highlighting instances with overrides (`I`)](#room-editor-highlight-overrides)
  * [Room Editor / Inspector — Width/Height in pixels ("Scale in px")](#room-editor-width-height)
  * [Font Editor — `Copy Range as Text`](#font-editor-copy-range)

### <a id="gm-qol-toolbox-options"></a>GM QoL Toolbox Options

- Open it from `File > Preferences > GM QoL Toolbox` or from `Plugins →
  GM QoL Toolbox Options...` — both land on the same page.
- One checkbox per feature in this list (except "Convert to Frames: Auto",
  a per-use dialog checkbox rather than a standing feature), grouped under
  headers matching the sections below, plus a number field for how many
  entries `Shift+F4`'s Recent Resources list remembers (5–40, default 30).
- Changes apply the instant you click/type — there's no OK/Apply/Cancel
  step for this page.
- Settings live in their own file, `plugins_settings.json`, right next to
  GameMaker's own `local_settings.json` in the same per-user profile
  folder — but never written into `local_settings.json` itself, so
  uninstalling the plugin never leaves anything behind in a file GameMaker
  itself manages.
- The first time you open a project after installing, a small window
  explains the plugin is independent of YoYo Games (see Disclaimer below)
  and links straight to this page. If a later update adds new options, a
  one-time notification (top-right corner) points here too.
  > [!IMPORTANT]
  > **By default, all (new) features are enabled.**

![GM QoL Toolbox Preferences window](images/preferences.png)

### <a id="advanced-search"></a>`Plugins → Advanced Search`

- A project-wide search built on top of GameMaker's own search engine, with
  exclusion options the native `Search & Replace` doesn't offer:
  - **Case sensitive / Whole word / Ignore comments** — same options as
    the native dialog.
  - **Regex** — search with a regular expression instead of plain text.
    A pattern that takes too long to match (catastrophic backtracking) is
    aborted for that file after a couple of seconds rather than freezing
    the search.
  - **Exclude from search** — checkboxes for whole categories: Objects,
    Scripts, Sequences, Rooms, Notes, Timelines, Shaders.
  - **Exclude group named** — skip every Asset Browser group with a given
    name (comma-separated for more than one), anywhere in the tree,
    including its subgroups — e.g. a vendored "Extensions" or "GMLive"
    folder full of generated code you never want showing up in results.
- A small history dropdown (▾) next to the search field remembers your
  last 10 searches for the current project.
- Every result opens the exact matching line, same as the native dialog.
- Support for tags will be added in the future.

![GM QoL Toolbox Advanced Search window](images/advanced-search.png)

### <a id="toolbar-buttons"></a>IDE main toolbar — quick-access buttons

- Two new buttons in the IDE's main toolbar, next to the native
  collapse/expand-docks button:
  - **Search and Replace** — opens the native `Search & Replace` window,
    same as `Ctrl+Shift+F`.
  - **Advanced Search** — opens this plugin's own [Advanced
    Search](#advanced-search) window.
- Both just save a trip to the menus for searches you run often; neither
  adds behavior beyond what its menu entry already does.

![GM QoL Toolbox toolbar buttons](images/topbar-buttons.png)

### <a id="check-object-usage"></a>`Plugins → Check Object Usage`

- **Select object...** — the native object picker (the same one used in
  the Object Editor's "Parent" field). Selecting one runs the scan
  immediately.
- Results in four sections:
  - **PARENT OBJECT / CHILD OBJECTS** — the object's inheritance, straight
    from the project model (no scanning involved).
  - **COLLISION EVENTS** — collision events referencing the object, from
    the project model.
  - **ROOM INSTANCES** — every instance of the object in every room,
    grouped by room + layer.
  - **GML CODE / OTHER .yy FILES** — a search of the project's files for
    the object's name (a fallback for references the model doesn't track
    directly).
- Every result row opens the corresponding resource; code hits jump
  straight to the matching line.

![Check Object Usage window](images/check-object-usage.png)

### <a id="object-editor-usage-button"></a>Object Editor — Usage button

- In the compact object edit window (Asset Browser → Edit), a new
  **Usage** button under Variable Definitions opens the full "Check
  Object Usage" report for the object being edited.

![Object Usage button](images/object-usage-object.png)

### <a id="inspector-usage-section"></a>Inspector — Usage section (objects)

- The docked Inspector (the properties panel shown when an object is
  selected in the Asset Browser) shows a collapsible **Usage** category,
  mirroring the SpriteUsage plugin's Usage section for sprites.
- Collapsed by default and computes nothing until expanded — only then
  does it show "Searching..." and the real data: parent/child/collision/
  room counts, code references, and a link to the full report.

![Object Inspector Usage section](images/object-usage-inspector.png)

### <a id="object-editor-green-icons"></a>Object Editor — green section icons

- In the compact object edit window (opened from the Asset Browser), the
  icons next to **Parent** and **Variable Definitions** light up green
  when that section actually has content (a parent/children set, even a
  single variable) — visible without expanding the section.

![Object green icons](images/green-icons.png)

### <a id="object-editor-events-open-collision"></a>Object Editor — "Events" window: opening the collision object

- Right-clicking a **Collision** event in the Events window adds a new
  entry to the existing menu (alongside Add/Cut/Copy/Paste/Duplicate/
  Change/Delete): `Open <object name>`, which opens the editor for the
  object it collides with.
- **Middle mouse button** clicked on such a row does the same thing
  immediately, without opening the menu.
- Also works for Collision events inherited from a parent (greyed-out
  rows).

![Open object context menu](images/open-object-context.png)

### <a id="object-editor-collision-select"></a>Object Editor — "Add Event"/"Change Event": `Collision (Select)...`

- Next to the built-in `Collision` submenu (which lists every object
  alphabetically, ignoring your Asset Tree folder order, and needs
  clicking through nested folders), a new `Collision (Select)...` entry
  opens the same searchable object picker "Check Object Usage" uses.
- Works identically to the built-in `Collision` for both adding a new
  Collision event (Add Event) and retargeting an existing one (Change
  Event) — same Undo grouping, same GML/Visual prompt.

![Collision select](images/collision-select.png)
![Collision select popup](images/collision-select-popup.png)

### <a id="check-sprite-usage"></a>`Plugins → Check Sprite Usage`

- **Select sprite...** — the native sprite picker. Selecting one runs the
  scan immediately.
- **Check usage** — re-runs the scan for the currently selected sprite.
- **Find orphans** — scans every sprite in the project and lists the ones
  with no usage at all (no project reference, no GML/.yy hit).
- Results in three sections:
  - **PROJECT RESOURCES** — every typed reference to the sprite from the
    project model (objects using it as sprite or collision mask, rooms,
    tile sets, particle systems, ...), grouped by resource type.
  - **GML CODE** — a search of the project's `*.gml` files for the
    sprite's name.
  - **OTHER .yy FILES** — other resource files mentioning the sprite's
    name, skipping anything already listed under PROJECT RESOURCES.
- Every result row opens the corresponding resource; code hits jump
  straight to the matching line.
- Only added to the `Plugins` menu if the separate SpriteUsage plugin
  isn't already installed — that plugin already provides this exact
  feature, so this one steps aside instead of duplicating it.

### <a id="sprite-editor-usage-button"></a>Sprite Editor — Usage button

- In the Sprite Editor's properties panel (below Nine Slice/Texture
  Settings), a **Usage** button opens the full Check Sprite Usage report
  for the sprite being edited (matches Object Editor's Usage button).

![Check sprite usage](images/check-sprite-usage.png)

### <a id="inspector-usage-section-sprites"></a>Inspector — Usage section (sprites)

- The docked Inspector shows a collapsible **Sprite Usage** category when
  a sprite is selected, mirroring the Object Editor's Usage section.
- Collapsed by default and computes nothing until expanded — only then
  does it show "Searching..." and the real data: Objects/Rooms/Other
  counts, a Code count (background `*.gml` scan), and a link to the full
  report.
- Toggle in Preferences under **GM QoL Toolbox → Sprite Editor**: "Show
  'Sprite Usage' button in Sprite Editor and Inspector" controls both this
  and the Editor button above; "Disable 'Sprite Usage' section in
  Inspector" hides just this one, independent of the Editor button.

![SpriteUsage Inspector](images/sprite-usage-inspector.png)

### <a id="image-editor-convert-to-frames-auto"></a>Image Editor — `Convert to Frames`: "Auto" checkbox

- In the native strip-import dialog (Image Editor → `Convert to Frames` /
  `Import from Strip`), a new **Auto** checkbox next to "Number of
  Frames".
- Once checked, Number of Frames and Frames per Row are computed
  automatically from Frame Width/Height and the actual image size (the
  fields become non-editable) — no need to work them out by hand.
- The checkbox state persists for the whole IDE session (not saved to
  disk), so subsequent uses of `Convert to Frames` keep whatever state it
  was last left in.

![Convert to Frames](images/convert-frames-before.png)
![Convert to Frames after](images/convert-frames-after.png)

### <a id="f11-bottom-dock"></a>`F11` — collapsing/expanding just the bottom dock

- The native `F12` (`Expand Collapse Docks`) collapses/expands all three
  docks (left, right, bottom) at once. `F11` does the same, but only for
  the bottom dock — where Output, Search Results and similar panels dock
  by default.
- Plain `F11` (no modifier) overlaps with the native debugger shortcut
  `Step Into` — `Shift+F11` (`Step Out`) is not intercepted.
- The bottom dock's collapse bar now shows a "Press F11 to hide" hint on
  the right (in a smaller font than the rest of the UI), so the shortcut
  is discoverable without reading the README.

![F11](images/press-f11.png)

### <a id="find-in-resource-tree"></a>Resource editors — `Find in Resource Tree`

- Right-click on the title bar/tab of any open resource editor → `Find in
  Resource Tree` selects and scrolls to that resource in every open Asset
  Browser (expanding parent folders along the way). If no Asset Browser
  is open, the option does nothing.
- Works for all 15 resource types in the New Asset menu: Object, Sprite,
  Sound, Script, Note, Shader, Animation Curve, Extension, Font, Path,
  Tile Set, Timeline, Particle System, Room, Sequence.

![Find in asset browser](images/find-in-asset-browser.png)

### <a id="rearrange-close-windows"></a>Workspace — `Rearrange Windows` / `Close All Windows`

- Right-click on an empty spot on the workspace canvas → next to the
  `Windows` and `Go To...` submenus, two extra top-level entries:
  - `Rearrange Windows` — lines up every open workspace window into a
    single column, one under another, closing the gaps left by closed
    windows.
  - `Close All Windows` — the same as the native `Close All` at the
    bottom of the `Windows` submenu, just higher up in the menu (with
    many open windows, the original entry is practically unreachable
    without scrolling).

![Find in asset browser](images/rearrange-context.png)

### <a id="shift-f4-recent-resources"></a>`Shift+F4` — Recent Resources

- A list of recently used resources, most-recently-used first — a
  resource moves to the top both when opened and when its editor is
  closed. Limited to 30 entries, cleared when the project closes. Windows
  already open when the plugin starts (GameMaker restores them from the
  previous session) are also added, in roughly top-to-bottom order.
- Clicking a row opens the resource and closes the window; up/down arrows
  move the selection and wrap around, `Enter` opens the selected row,
  `Escape` closes without selecting. The window can also be dragged
  freely.
- Closes automatically on losing focus — like `Go To` (`Ctrl+T`) and
  Workspace Overview (`Ctrl+Tab`), built on the same base class
  (`PopupWindow`).
- Unlike the native `Recent Windows`, it never mixes in events — it's a
  plain list of resources.
- Rows for a resource still open elsewhere are tinted green; the rest stay
  white/default, so you can tell at a glance which ones are already open.

![Recent resources](images/recent-resources.png)

### <a id="room-editor-move-assets"></a>Room Editor — "Move Assets"

- In the room editor's floating toolbar (grid/zoom/show views/playback/
  select-from-any-layer), a new button with a 4-directional arrow icon
  (like `Shift Path` in the Path Editor).
- Opens a small window with **X (px)** and **Y (px)** fields (positive or
  negative values — X has autofocus) and a choice of **This layer** /
  **All layers**.
- On **OK**, if X or Y is non-zero, moves by the given amount:
  - every instance/asset on the selected layer (or on every layer in the
    room, including their sub-layers),
  - tile layers are moved as a whole (layer offset, not individual
    tiles).
- The whole move is a single Undo step (`Ctrl+Z` undoes it all at once).
- A plain (unmodified) press of the `M` key opens this window immediately
  for the currently visible room editor — same as clicking the button.

![Move assets](images/move-assets.png)

### <a id="room-editor-assets-palette"></a>Room Editor — "Room Assets Palette"

- In the room editor's floating toolbar (next to "Move Assets"), a new
  button with a diamond icon (like Sequence in the Asset Tree). Opens a
  floating window listing Sprites/Objects/Sequences — with folders, just
  like the Asset Tree — that **doesn't close itself** and dynamically
  filters the list to match the currently selected room layer's type
  (Asset layer → Sprite/Sequence, Instance layer → Object; other layer
  types just show a short hint instead of a list).
- Two ways to insert into the room without using the Asset Tree:
  - **Drag and drop** a row onto the room canvas — identical to dragging
    from the Asset Tree (position preview, red X on an incompatible
    layer), plus it automatically selects the inserted instance on drop
    (which the native Asset Tree drag doesn't do).
  - `ALT`+click in the room — uses the palette's selection instead of the
    Asset Tree, as long as the palette was used most recently; clicking
    anything directly in the real Asset Tree (even the same resource
    again) immediately hands priority back to it.
- It have search window. In future versions it would also support tags.
- The window closes automatically together with the project and on IDE
  exit.

![Recent resources](images/room-palette.png)

### <a id="room-editor-highlight-overrides"></a>Room Editor — highlighting instances with overrides (`I`)

- Holding `I` (as in "Inheritance") in the room editor highlights every
  instance with a red rectangle (50% opacity) that has:
  - anything overridden under **Variables** — a property of the instance
    itself (editable in the Inspector), not of the object it's based on,
  - and/or its own **Creation Code** set.
- Not `M` — `M` opens `Move Assets` (see above).
- In the toolbar, next to `Select from Any Layer` (and before `Move
  Assets`), there's an icon button (like Script in the Asset Tree, with a
  "(Hold I)" tooltip) — works exactly like `Select from Any Layer`:
  **click** turns the highlight on permanently (until clicked again),
  **holding `I`** turns it on temporarily regardless of the button's
  state. Releasing `I` turns the highlight off, unless the button was
  already turned on manually (by clicking) — in which case it stays on.
- Both `I` and `M` work through a registered Hotkey (the same mechanism
  as the native `Hold P`), so they respect modifiers (`Ctrl+I`,
  `Shift+I` etc. don't trigger them) and show up under `Preferences >
  Keyboard`.

![Room inheritance instances](images/room-inheritance-instances.png)

### <a id="room-editor-width-height"></a>Room Editor / Inspector — Width/Height in pixels ("Scale in px")

- For instances and sprite assets in a room: next to the native **Scale
  X**/**Scale Y** fields, a new **Scale in px** row with **W**/**H**
  fields — editable pixel width/height, computed from the sprite's size
  and the current Scale.
- Available in two places, kept in sync with each other and with Scale
  X/Y:
  - the floating properties window (opened by double-clicking an
    instance/sprite asset in the Room Editor) — a new row right under
    Scale X/Scale Y,
  - the docked Inspector's Properties category — one "Scale in px" row
    with W/H fields, right under the native Scale row.
- It's really the same underlying value as Scale X/Y, just in different
  units — editing W/H recomputes and writes Scale X/Y, and editing Scale
  X/Y refreshes W/H back. Arrow-button step: 1 px.
- Only added if the separate SpriteUsage plugin isn't already installed —
  that plugin already provides this, so this one steps aside instead of
  duplicating it.

![Room item size window](images/room-item-size.png)
![Room item size inspector](images/room-item-size-inspector.png)

### <a id="font-editor-copy-range"></a>Font Editor — `Copy Range as Text`

- In the Font Editor, below `Regenerate`, a new **Copy Range as Text**
  button.
- Builds one continuous string out of every character in every defined
  range (`lower` to `upper` inclusive, no gaps between ranges and no
  truncation — unlike the character preview next to each range, which
  cuts off after a few hundred characters for long ranges) and copies it
  to the system clipboard.
- Useful when designing a pixel font in an external tool (e.g. Photoshop)
  that needs to match the font's actual character set — previously the
  only way to get that list out was retyping it by hand from the range
  list, where each range sits on its own line.
- The button briefly shows "Copied!" after a click.

![Copy Range](images/copy-range-before.png)
Results in `!"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_``abcdefghijklmnopqrstuvwxyz{|}~ÓóĄąĆćĘęŁłŃńŚśŹźŻż▯`
