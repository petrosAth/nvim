# nvim-keymaps

Adds or edits keybindings in `plugin/mappings.lua` (`USER.mappings` table).

## Invocation

```
/nvim-keymaps
```

Also auto-triggers when you ask Claude to edit `plugin/mappings.lua` directly.
The skill reads `plugin/AGENTS.md` for the mapping structure, applies changes,
and runs `/nvim-verify`.

## Examples

**Add a new keymap:**

```
/nvim-keymaps
Add <leader>td to toggle diagnostics virtual text.
```

**Change an existing binding:**

```
/nvim-keymaps
Move the fzf-lua find-files key from <leader>ff to <leader>sf.
```

**Create a which-key group:**

```
/nvim-keymaps
Add a <leader>g group labelled "Git" for all fugitive/gitsigns mappings.
```

## What it touches

- `plugin/mappings.lua` — the single source of truth for all keybindings
- Runs `/nvim-verify` after changes
- Verify interactively with `:WhichKey` inside Neovim
