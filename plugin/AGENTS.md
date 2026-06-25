# plugin/ — AGENTS.md

Core editor config. Both files here are sourced by **lazy.nvim** (not Neovim's
native loader) during `require("plugin-manager").init()` — see the root
`AGENTS.md` startup/load order. No explicit `require` needed.

## Files

- **`options.lua`** — all `vim.opt.*` / `vim.o` settings (indentation, folds via
  treesitter, `undofile`, `exrc`, list/fill chars from `USER.styling`, GUI
  options for Neovide). Global editor behavior goes here.
- **`mappings.lua`** — populates the global `USER.mappings` table. It is keyed
  **by mode** (`n`, `i`, `x`, `o`, `c`, `t`, …), then by key/prefix. A leaf is
  `{ <rhs>, desc = "..." }`; a nested table with `group = "..."` defines a
  which-key prefix group. `which-key/utils.lua`'s `get_maps_add_descriptions`
  walks `USER.mappings` and registers the descriptions, so a single table drives
  both the keymaps and the which-key menu.

## Recipe — add a keymap

**Companion skill:** `/nvim-keymaps` applies this recipe and runs
`/nvim-verify`.

1. In `mappings.lua`, find (or create) the mode subtable and prefix group.
2. Add a leaf:
   ```lua
   ["<lhs>"] = { <rhs>, desc = "Human readable description" },
   ```
   where `<rhs>` is a command string (`"<CMD>Telescope resume<CR>"`) or a Lua
   function. For a new prefix, nest a table with `group = "..."`.
3. which-key picks up the `desc`/`group` automatically — no separate
   registration. Restart Neovim (or re-source) and verify with `:WhichKey`.
4. Per the repo's to-do, keep mappings aligned with Vim's mapping philosophy;
   check `:help map` / Context7 (`/neovim/neovim`) when unsure about a built-in.
