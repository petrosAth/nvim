# lua/plugins/heirline/ — AGENTS.md

The **statusline + winbar**, built with `rebelot/heirline.nvim`. See the root
`AGENTS.md` for global conventions. **The tabline is _not_ here** — it belongs
to `tabby.nvim` (`lua/plugins/tabby/`); never conflate the three.

heirline renders Vim's statusline and winbar from nested Lua tables ("status
objects"). Each object is a list of child components plus optional keys:
`condition`, `init` (sets `self.*`), `provider` (the text), `hl`, `update`,
`flexible`, `static`, `on_click`. This config splits the work across six files.

## File map

| File              | Role                                                                                                                 |
| ----------------- | -------------------------------------------------------------------------------------------------------------------- |
| `init.lua`        | lazy spec + `setup()`; deps `nvim-web-devicons`, `nvim-lspconfig`, `gitsigns.nvim`; the `disable_winbar_cb` hook.    |
| `properties.lua`  | tuning constants: `Hide` (width thresholds), `Disable` (excluded buf/filetypes), `ModeNames`, `ModeHighlightGroups`. |
| `components.lua`  | the ~22 reusable components — the `M.*` registry every layout draws from.                                            |
| `status-line.lua` | the `border_*` separators + 5 statusline layout variants; returns a `fallthrough = false` list.                      |
| `winbar.lua`      | the `border()` helper + 4 winbar layout variants; returns a `fallthrough = false` list.                              |
| `utilities.lua`   | `get_vim_mode_color(mode)` — maps mode → `ModeHighlightGroups` → highlight → `{ fg, bg, bold }`.                     |

`init.lua` wires it together:

```lua
heirline.setup({
    statusline = require("plugins.heirline.status-line"),
    winbar = require("plugins.heirline.winbar"),
    opts = { disable_winbar_cb = function(args) ... end },
})
```

`plugin/options.lua` sets `laststatus = 3` (one global statusline). `winbar` is
**not** set globally — heirline owns it per-window, and `disable_winbar_cb`
blanks `vim.opt_local.winbar` for excluded buffers (see below).

## Component idiom (`components.lua`)

A component is a base table whose `condition`/`init` stash data on `self`,
composed with responsive children via `utils.insert`. `Null = { provider = "" }`
is the universal "render nothing" fallback. Example:

```lua
local FileTypeBlock = {
    condition = function() return vim.bo.filetype ~= "" end,
    init = function(self) self.fileType = vim.bo.filetype ... end,
}
M.FileTypeBlock = utils.insert(
    FileTypeBlock,
    { flexible = props.Hide.FileTypeBlock.icon, FileIcon, Null },  -- shown vs. hidden
    { flexible = props.Hide.FileTypeBlock.value, FileType, Null }
)
```

- **`{ flexible = N, shown, fallback }`** — heirline drops to `fallback`
  (usually `Null`, or a compact form) when the window is narrower than threshold
  `N`. **All thresholds live in `properties.Hide`** — never inline a magic
  number.
- **`hl`** is a group name (`"BarUpdates"`), a table (`{ fg = ... }`), or a
  function returning one. Pull colors with `utils.get_highlight("<group>")`;
  pull mode-reactive colors with `get_vim_mode_color(self.mode)`.
- **`update`** limits re-evaluation to events (e.g. `"CursorMoved"`, or
  `{ "ModeChanged", pattern = "*:*", callback = vim.schedule_wrap(...) }`).
- Providers may use **statusline format codes** (`%l`, `%c`, `%L`, `%=`, `%<`,
  `%2(...%)`) — these are Vim `:h statusline` items, not Lua.

### Component registry

`ViMode`, `SearchResults`, `Paste`, `Wrap`, `GitStatus`, `GitBlame`, `LspBlock`
(LSP clients + conform formatters + nvim-lint linters + diagnostics),
`PluginUpdates`, `Spell`, `Treesitter`, `FileEncoding`, `FileFormatBlock`,
`FileTypeBlock`, `FileSize`, `FileNameBlock`, `FileReadOnly`, `FileModified`,
`CustomTitle`, `LspSymbol` (navic breadcrumb), `CursorPosition`, `CursorLine`,
`LinesTotal`, `WindowNumber`, `CloseButton` (clickable, winbar-only),
`TerminalName`.

## Layout & the border "zone grammar"

Both `status-line.lua` and `winbar.lua` return a `fallthrough = false` list:
heirline renders the **first child whose `condition` passes**, so **order is the
dispatch logic**. The trailing `hl` function picks the base group by active
state.

- **statusline variants** (in order): `StatusLineInactive` →
  `StatusLineTerminal` → `StatusLineSpecial` (qf/Outline/trouble) →
  `StatusLineMinimal` (disabled buf/filetypes or labelled special buffers) →
  `StatusLine` (default).
- **winbar variants** (in order): `WinBarSpecialNC` → `WinBarNC` →
  `WinBarSpecial` → `WinBar`. "Special" = a buffer with a `get_buf_label`
  (renders `CustomTitle` instead of `FileNameBlock`); `NC` = not the active
  window. The commented-out `DisableWinBar` is superseded by `init.lua`'s
  `disable_winbar_cb`.

Sections are stitched by **separator/border glyphs** from
`USER.styling.separators.bars` (`edgeLeft`, `edgeRight`, `left`, `right`, `gap`,
`sep`). The statusline chains mode-colored borders that hand fg/bg between
zones:

```
border_edge_2 → ViMode → border_2_1 → [StatusLine1 zone] → border_1_0
   → [StatusLine zone] → Align(%=) ... border_0_1 → border_1_2 → border_2_edge
```

Each border's `fg` is the glyph color, its `bg` is the _next_ zone's background
— e.g. `border_2_1` draws `Sep.right` with `fg = mode color`,
`bg = StatusLine1.bg`. **Borders are directional and must stay paired** (every
"into a zone" needs its matching "out of a zone") or the colors smear. The
winbar uses a small helper for the same idea:

```lua
local border = function(position, fg, bg)
    return { provider = Sep[position], hl = {
        fg = fg and utils.get_highlight(fg.hl)[fg.layer] or "",
        bg = bg and utils.get_highlight(bg.hl)[bg.layer] or "" } }
end
-- border("edgeLeft", { hl = "WinBar1", layer = "bg" }, { hl = "WinBar", layer = "bg" })
```

`Align = { provider = "%=" }` is a spring; the default `StatusLine` uses **two**
to center `GitBlame` between the left and right groups.

## Hiding & disabling

- **Responsive collapse** — width-driven, per component, via `flexible` +
  `properties.Hide`. Smaller threshold = survives longer as the window narrows.
- **Whole-bar exclusion** — `properties.Disable.{winBar, statusLine}` list
  `buftype`/`filetype` to skip. The statusline reads these in its `Minimal`
  variant condition; the winbar enforces them through `init.lua`'s
  `disable_winbar_cb`, which also calls `ui.utilities.get_buf_label` so labelled
  special buffers still keep a winbar.

## Colors — ownership boundary

Statusline/winbar **highlight groups are defined in
`lua/themes/highlightGroups.lua`, not here.** The base groups `StatusLine`,
`StatusLineNC`, `WinBar`, `WinBarNC` sit in the `g.editor` block; the heirline
extras live in the **`g.bars`** block: `Mode*` (mode colors), `Bar*`
(`BarModified`, `BarReadOnly`, `BarUpdates`, `BarWindowNumber`,
`BarCloseButton`, …), and the layered `StatusLine1/2`, `WinBar1`, `WinBar1NC`.
Components only **read** them via `utils.get_highlight(...)`.

**Rule: never hardcode a hex color in a component.** To recolor the bars, add or
edit a group in the palette pipeline (`g.bars`) — see `lua/themes/AGENTS.md` and
the `/nvim-theme` skill. To change which palette color a mode shows, edit
`g.bars` (the group) and/or `properties.ModeHighlightGroups` (the mode→group
map).

## Dependencies

| Source                                                 | Used for                                                                  |
| ------------------------------------------------------ | ------------------------------------------------------------------------- |
| `USER.styling.icons`                                   | every glyph (`icons.line`, `icons.git.*`, `icons.lsp.*`, `icons.OS.*`, …) |
| `USER.styling.separators.bars`                         | the border/separator glyphs                                               |
| `lua/themes/highlightGroups.lua`                       | all `g.bars` + base statusline/winbar groups                              |
| `ui.utilities.get_buf_label`                           | special-buffer detection + `CustomTitle` text                             |
| `nvim-web-devicons`                                    | file icon + color in `FileTypeBlock` / `FileNameBlock`                    |
| `gitsigns.nvim`                                        | `vim.b.gitsigns_status_dict` / `gitsigns_blame_line`                      |
| `nvim-navic`                                           | `LspSymbol` breadcrumb                                                    |
| `conform` / `nvim-lint` / `vim.lsp` / `vim.diagnostic` | `LspBlock` clients, formatters, linters, diagnostic counts                |
| `lazy.manage.checker`                                  | `PluginUpdates` count                                                     |

## Recipes

**Companion skill:** `/nvim-statusline` applies these and runs `/nvim-verify`.
For component/condition/util API, run the `nvim-plugin-docs` skill — heirline is
in its known-good Context7 IDs table.

1. **Add a component** — define it in `components.lua` as `M.X` using the
   `init`/`provider`/`flexible` idiom; add any width threshold to
   `properties.Hide`; reference colors via `utils.get_highlight`/a `g.bars`
   group. Then slot `c.X` into the chosen layout in
   `status-line.lua`/`winbar.lua` **between the correct borders**.
2. **Reorder / add a layout section** — edit the variant list; keep each zone
   wrapped by its paired borders and watch the `bg` handoffs so colors stay
   continuous. Use `Align` to push groups left/right.
3. **Change when a bar shows/hides** — edit `properties.Disable.*` lists, or the
   `fallthrough = false` variant **ordering** (first match wins). Winbar
   exclusions also flow through `disable_winbar_cb` in `init.lua`.
4. **Add an icon or separator** — add it to `USER.styling.icons` /
   `separators.bars` and reference it; never inline a literal glyph.
5. **Recolor** — edit `g.bars` in `lua/themes/highlightGroups.lua` (→
   `/nvim-theme`).
6. **Verify** — run the `/nvim-verify` skill, then eyeball the bars live
   (active/inactive split, narrow window, terminal, a special buffer like
   trouble/Outline).
