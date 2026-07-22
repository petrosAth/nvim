# lua/themes/ — AGENTS.md

The palette-based theme engine. See the root `AGENTS.md` for global conventions.

## Pipeline

`USER.theme` (env `SYSTEM_THEME`, else `"gruvbox"`) → `init.lua` calls `vim.cmd.colorscheme(USER.theme)` → Neovim finds `colors/<name>.lua` on the `runtimepath`, a one-liner: `require("themes").load("<name>")` → `themes/init.lua` `M.load(name)`:

1. `require("themes.palettes.<name>")` — a module exposing `.base` and `.terminal` tables.
2. `M.loadTerminalColors(palette.terminal)` → `terminal.lua` sets `vim.g.terminal_color_*`.
3. `M.loadHighlightGroups(palette.base)` → `highlightGroups.lua` applies all `nvim_set_hl` groups from the palette.

Supporting modules: `utilities.lua` (HSL adjust/blend helpers) and `hsluv.lua` (HSLuv color-space math) — used by palettes/highlight groups, not entry points.

The full list of selectable themes is the `themes` table at the top of the repo's `init.lua`.

## Recipe — add a theme

**Companion skill:** `/nvim-theme` applies this recipe and runs `/nvim-verify`.

1. Create `lua/themes/palettes/<name>.lua` returning a module with `.base` (the highlight palette) and `.terminal` (16 terminal colors). Copy an existing palette such as `palettes/gruvbox.lua` and recolor it.
2. Create `colors/<name>.lua` containing exactly:
   ```lua
   require("themes").load("<name>")
   ```
3. Add `"<name>"` to the `themes` list in the repo-root `init.lua` so it's selectable.
4. Test: `:colorscheme <name>` (or set `SYSTEM_THEME=<name>` and restart).
