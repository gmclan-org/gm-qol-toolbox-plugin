# Changelog

Versions below without a `v` prefix are internal development builds that
came before the first public release (`v0.15.0`) — never separately
published here, listed only so the release history makes sense.

## v0.17.0 — 2026-08-24

- **New: Advanced Search** (`Plugins` menu) — project-wide text/regex search
  that can exclude whole resource categories (Objects, Scripts, Sequences,
  Rooms, Notes, Timelines, Shaders) or a named Asset Browser group (and its
  subgroups) from the results — e.g. skip a vendored "Extensions"/"GMLive"
  folder full of generated code. Also searches Extension code, which the
  native Search & Replace never does. Includes a Regex mode (with a
  timeout guard against runaway patterns) and a small recent-searches
  dropdown.
- Fixed: `Find in Resource Tree` silently did nothing if the Asset Browser
  had an active search/filter hiding the target, or if its window wasn't
  the one on top.
- Fixed: clicking a room-instance row in Check Object/Sprite Usage only
  opened the room, without switching to the right layer or selecting the
  instance.
- Sprite Editor's "Usage" is now a one-click button in the same spot,
  matching how Object Editor already works, instead of a collapsible
  section.
- The Inspector's "Sprite Usage" section is now truly lazy — it no longer
  computes anything until you actually expand it, matching Object Usage's
  existing behaviour.
- New Preferences options to hide just the docked Inspector's "Sprite
  Usage"/"Object Usage" section, independent of the Editor's own button.

## v0.16.0 — 2026-08-23

- Check Sprite Usage — find where a sprite is used (objects, rooms, code),
  plus an orphan-sprite finder, and Usage sections in the Sprite Editor and
  docked Inspector
- Width/Height in pixels ("Scale in px") for room instances and sprite
  assets — editable pixel size next to Scale X/Scale Y, in the properties
  window and the Inspector, kept in sync with it
- `Copy Range as Text` (Font Editor) — copy every character across every
  defined range to the clipboard as one string
- Fixed: `Move Assets` opened a new window every time instead of reusing
  the one already open for that room, and could stay open after its room
  tab closed
- Fixed: `Move Assets` (`M`) and instance-override highlighting (`I`)
  triggering while typing in a text field elsewhere in the IDE

## v0.15.0 — 2026-08-23

First public release.

- Check Object Usage — find where an object is used across objects, rooms, parents and code
- GM QoL Toolbox Options page in `File > Preferences` to toggle every feature individually
- Usage button (Object Editor) and Usage section (Inspector) for quick, in-place usage lookups
- `Collision (Select)...` searchable object picker for Add/Change Event
- `Convert to Frames` Auto checkbox in the Image Editor's strip-import dialog
- `F11` to collapse/expand just the bottom dock
- `Find in Resource Tree`, `Rearrange Windows` / `Close All Windows` on the workspace
- `Shift+F4` Recent Resources list
- Room Editor: Move Assets, Room Assets Palette, highlighting instances with overrides (`I`)

See the [README](README.md) for the full feature list and details.

## 0.14.0 — 2026-08-23

- Renamed to **GM QoL Toolbox**.
- New **GM QoL Toolbox Options** page in `File > Preferences` (also from
  the `Plugins` menu) — a checkbox per feature, plus a setting for how
  many Recent Resources to remember.
- `Collision (Select)...` — searchable object picker for Add/Change
  Event, next to the built-in `Collision` submenu.
- First-run and update notices pointing to the new Options page.

## 0.0.13 — 2026-08-23

- `F11` — collapse/expand just the bottom dock.
- Open the collision object — right-click or middle-click a Collision
  event in the Events window.
- `Convert to Frames`: Auto checkbox — computes frame count
  automatically in the Image Editor's strip-import dialog.
- Highlighting instances with overrides — hold `I` in the Room Editor.
- `M` — quick-open Move Assets.

## 0.0.11 — 2026-08-21

- Stability fix: plugin windows now close properly when switching
  projects, preventing a crash.

## 0.0.10 — 2026-08-21

- Room Assets Palette — insert objects, sprites and sequences into a
  room without the Asset Tree, by drag-and-drop or `ALT`+click.

## 0.0.9 — 2026-08-20

- Move Assets — shift a room layer's contents by an X/Y offset, from the
  Room Editor toolbar.

## 0.0.8 — 2026-08-20

- Bug fixes and polish for Check Object Usage and the Inspector Usage
  section.

## 0.0.7 — 2026-08-20

- Usage button (Object Editor) and Usage section (Inspector) for quick,
  in-place object-usage lookups.

## 0.0.6 — 2026-08-20

- `Shift+F4` — quick list of recently used resources.

## 0.0.5 — 2026-08-20

- `Rearrange Windows` — line up open workspace windows into a column.

## 0.0.4 — 2026-08-20

- `Close All Windows` moved higher up in the workspace right-click menu.

## 0.0.3 — 2026-08-20

- `Find in Resource Tree` — right-click a resource tab to locate it in
  the Asset Tree.

## 0.0.2 — 2026-08-20

- Green Parent/Variable Definitions section icons in the Object Editor.

## 0.0.1 — 2026-08-20

- Check Object Usage — the first real feature: find where an object is
  used (parent/child, collision events, room instances, code) with a
  native object picker.
