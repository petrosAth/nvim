# nvim-add-plugin

Adds, replaces, or removes a lazy.nvim plugin spec in this Neovim config.

## Invocation

```
/nvim-add-plugin <author/repo>
```

The `author/repo` argument is required. The skill fetches the plugin's GitHub
description and Context7 docs, generates a spec file at `lua/plugins/<name>.lua`,
updates `lazy-lock.json`, and runs `/nvim-verify`.

## Examples

**Add a new plugin:**

```
/nvim-add-plugin folke/flash.nvim
```

**Replace an existing plugin with a different one:**

```
/nvim-add-plugin stevearc/oil.nvim
Replace nvim-tree with oil.nvim — oil should be the new file explorer.
```

**Remove a plugin:**

```
Remove folke/noice.nvim from the config.
```

(No argument needed for removal — just describe the intent.)

## What it touches

- Creates `lua/plugins/<name>.lua` (add) or removes it (remove)
- Updates `lazy-lock.json` (bundled in the same commit as the spec change)
- Runs `/nvim-verify` to confirm the config loads cleanly after the change
