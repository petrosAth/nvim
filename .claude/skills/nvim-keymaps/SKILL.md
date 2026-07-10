---
name: nvim-keymaps
description: Adds or edits keybindings in this Neovim config. Use when the user wants to bind a key, add a mapping, change a shortcut, or add a which-key group. Auto-applies when editing plugin/mappings.lua.
paths:
  - plugin/mappings.lua
---

# Add / edit a keymap

Thin orchestrator — read the canonical steps, don't duplicate them.

1. **Read `plugin/AGENTS.md`** for the `USER.mappings` structure and the "add a keymap" recipe (keyed by mode, then key/prefix; leaf is `{ <rhs>, desc = "..." }`; nested `group = "..."` defines a which-key group).
2. **Apply** the change in `plugin/mappings.lua`. which-key picks up `desc`/`group` automatically — no separate registration.
3. **Verify:** run the `nvim-verify` skill, then check interactively with `:WhichKey`. Consult Context7 `/neovim/neovim` (`:help map`) for built-in mapping semantics if unsure.
