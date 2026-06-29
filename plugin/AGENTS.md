# plugin/ — AGENTS.md

Core editor config. Both files here are sourced by **lazy.nvim** (not Neovim's
native loader) during `require("plugin-manager").init()` — see the root
`AGENTS.md` startup/load order. No explicit `require` needed.

## Files

- **`options.lua`** — all `vim.opt.*` / `vim.o` settings (indentation, folds via
  treesitter, `undofile`, `exrc`, list/fill chars from `USER.styling`, GUI
  options for Neovide). Global editor behavior goes here.
- **`mappings.lua`** — populates the global `USER.mappings` table. It is keyed
  **by mode** (`n`, `i`, `x`, `o`, `c`, `t`, `s`), then by key/prefix. A leaf is
  `{ <rhs>, desc = "..." }`; a nested table with `group = "..."` defines a
  which-key prefix group. `which-key/utils.lua`'s `get_maps_add_descriptions`
  walks `USER.mappings` and registers the descriptions, so a single table drives
  both the keymaps and the which-key menu.

## Mapping model (Vim-aligned)

- **Leaders:** `<Leader>` = `<Space>` (primary: act on code/project),
  `<LocalLeader>` = `\` (secondary: manage the workspace — buffer, color, tab,
  project, utilities). Both are set in `init.lua` **before**
  `require("plugin-manager").init()` — they must precede `mappings.lua`, which
  lazy sources before `options.lua` (alphabetical), and `mapleader` is captured
  at map-definition time.
- **Visual vs Select:** Visual-only maps live under `x`; Select-mode maps (e.g.
  snippet placeholder edits) live under `s`. Don't use `v` (it is Visual **+**
  Select — see `:help map-modes`).
- **`<Cmd>` over `:`** for non-interactive maps (no mode change, no `<C-U>`).
  Keep `:` only for interactive maps (`silent = false` / trailing space) and
  Visual range maps that rely on `:` injecting `'<,'>` (e.g.
  `:Gitsigns stage_hunk`).
- **Toggles** live in a single `<F4>` hub registered in `lua/plugins/snacks.lua`
  (multi-mode `{ "n", "i", "v" }`); the `<F4>` "Toggle" which-key group label is
  declared here in the `n`/`i`/`x` tables.

## Recipe — add a keymap

**Companion skill:** `/nvim-keymaps` applies this recipe and runs
`/nvim-verify`.

1. In `mappings.lua`, find (or create) the mode subtable and prefix group.
2. Add a leaf:
   ```lua
   ["<lhs>"] = { <rhs>, desc = "Human readable description" },
   ```
   where `<rhs>` is a command string (`"<CMD>FzfLua resume<CR>"`) or a Lua
   function. For a new prefix, nest a table with `group = "..."`.
3. which-key picks up the `desc`/`group` automatically — no separate
   registration. Restart Neovim (or re-source) and verify with `:WhichKey`.
4. Keep mappings aligned with the **Mapping model** above (leader split, `x`/`s`
   over `v`, `<Cmd>` over `:`, the `<F4>` toggle hub); check `:help map` /
   Context7 (`/neovim/neovim`) when unsure about a built-in.
