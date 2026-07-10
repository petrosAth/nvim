# nvim-statusline

Adds or edits the statusline / winbar in the `heirline.nvim` setup (the tabline is tabby's, not here).

## Invocation

```
/nvim-statusline
```

Also auto-triggers when you ask Claude to edit files under `lua/plugins/heirline/`. The skill reads
`lua/plugins/heirline/AGENTS.md` for the component idiom and layout "zone grammar", applies changes, and runs
`/nvim-verify`.

## Examples

**Add a component:**

```
/nvim-statusline
Add a word-count component to the right side of the statusline, hidden on narrow windows.
```

**Change show/hide rules:**

```
/nvim-statusline
Stop showing the winbar in neo-tree buffers.
```

**Reorder a section:**

```
/nvim-statusline
Move the git branch block to the left of the LSP block in the statusline.
```

## What it touches

- `lua/plugins/heirline/components.lua` — the reusable component definitions
- `lua/plugins/heirline/status-line.lua` / `winbar.lua` — the layout variants
- `lua/plugins/heirline/properties.lua` — width thresholds + buf/filetype exclusions
- `lua/themes/highlightGroups.lua` (`g.bars`) for colors — via `/nvim-theme`
- Runs `/nvim-verify` after changes
