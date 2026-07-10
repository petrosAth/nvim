---
name: nvim-statusline
description:
  Adds or edits the statusline / winbar in this Neovim config's heirline setup.
  Use when the user wants a new bar component, a layout/section change,
  different show-hide rules, or recolored bars. Auto-applies when editing files
  under lua/plugins/heirline/.
paths:
  - lua/plugins/heirline/**
---

# Add / edit the statusline or winbar

Thin orchestrator — read the canonical steps, don't duplicate them. (heirline
owns the statusline + winbar only; the tabline is tabby's.)

1. **Read `lua/plugins/heirline/AGENTS.md`** — the file map, component idiom,
   layout "zone grammar", hiding/disabling rules, color ownership boundary, and
   the recipes.
2. **Apply** the change per those recipes, honoring the hard rules stated there:
   keep borders paired, and never hardcode a color or inline a glyph.
3. **Consult heirline's API docs** via the `nvim-plugin-docs` skill (heirline is
   in its known-good Context7 IDs table) before relying on
   component/condition/util behavior.
4. **Verify:** run the `nvim-verify` skill, then eyeball the bars live — active
   vs. inactive window, a narrow window (flexible collapse), a terminal, and a
   special buffer (trouble/Outline).
