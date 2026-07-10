---
name: nvim-theme
description: Adds or edits a colorscheme/theme in this Neovim config's palette-based theme engine. Use when the user wants a new colorscheme, a new palette, or tweaks to theme colors/highlight groups. Auto-applies when editing files under lua/themes/ or colors/.
paths:
  - lua/themes/**
  - colors/**
---

# Add / edit a theme

Thin orchestrator — read the canonical steps, don't duplicate them.

1. **Read `lua/themes/AGENTS.md`** for the theme pipeline and the "add a theme" recipe (`palettes/<name>.lua` exposing `.base` + `.terminal` → `colors/<name>.lua` one-liner → entry in the `themes` list in `init.lua`).
2. **Apply** the change, copying an existing palette such as `lua/themes/palettes/nord.lua` as the shape.
3. **Test** with `:colorscheme <name>` (or `SYSTEM_THEME=<name>` then restart).
4. **Verify:** run the `nvim-verify` skill.
