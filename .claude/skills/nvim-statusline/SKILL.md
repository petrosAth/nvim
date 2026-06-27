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

1. **Read `lua/plugins/heirline/AGENTS.md`** for the file map, the component
   idiom (`init`/`provider`/`flexible` + `utils.insert`, thresholds in
   `properties.Hide`), the layout "zone grammar" (`fallthrough = false` variant
   order + paired mode-colored borders), and the recipes.
2. **Apply** the change:
   - New component → define `M.X` in `components.lua`, register its width
     threshold in `properties.Hide`, then slot `c.X` into the right layout in
     `status-line.lua`/`winbar.lua` **between the correct borders**.
   - Show/hide → edit `properties.Disable.*` or the variant ordering.
   - Keep borders paired and the `bg` handoffs continuous so colors don't smear.
   - Use `USER.styling` icons/separators — never inline a glyph.
   - **Never hardcode colors:** read groups via `utils.get_highlight`, and to
     recolor edit `g.bars` in `lua/themes/highlightGroups.lua` (→ `nvim-theme`).
3. **Consult Context7 `/rebelot/heirline.nvim`** for component/condition/util
   API before relying on heirline behavior.
4. **Verify:** run the `nvim-verify` skill, then eyeball the bars live — active
   vs. inactive window, a narrow window (flexible collapse), a terminal, and a
   special buffer (trouble/Outline).
