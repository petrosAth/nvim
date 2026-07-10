# nvim-theme

Adds or edits a colorscheme using the palette-based theme engine.

## Invocation

```
/nvim-theme
```

Also auto-triggers when you ask Claude to edit files under `lua/themes/` or `colors/`. The skill reads
`lua/themes/AGENTS.md` for the theme pipeline, makes the necessary edits, and runs `/nvim-verify`.

## Examples

**Add a new colorscheme:**

```
/nvim-theme
Add a Gruvbox theme using the warm amber and earthy palette colors.
```

**Edit an existing palette:**

```
/nvim-theme
Make the nord theme's background slightly warmer — shift the base bg from #2E3440 to #2F3340.
```

**Test a theme before committing:**

Run `:colorscheme <name>` in Neovim, or start with `SYSTEM_THEME=<name> nvim`.

## What it touches

- `lua/themes/palettes/<name>.lua` — the palette definition (`.base` + `.terminal`)
- `colors/<name>.lua` — the one-line colorscheme entry point
- `lua/themes/init.lua` — registers the theme in the themes list
- Runs `/nvim-verify` after changes
