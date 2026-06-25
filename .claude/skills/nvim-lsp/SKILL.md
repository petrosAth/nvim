---
name: nvim-lsp
description:
  Adds or configures a language server (or null-ls source) in this Neovim
  config's LSP setup. Use when the user wants a new LSP server, per-server
  settings, or null-ls/none-ls formatter/linter changes. Auto-applies when
  editing files under lua/plugins/lsp/.
paths: lua/plugins/lsp/**
---

# Add / configure an LSP server

Thin orchestrator — read the canonical steps, don't duplicate them.

1. **Read `lua/plugins/lsp/AGENTS.md`** for the orchestration map and the "add
   an LSP server" recipe (`servers` list in `init.lua`; optional per-server
   branch in `setup_language_servers()` in `config.lua`; `install.lua`
   auto-derives the mason package).
2. **Verify the server's options against Context7** `/neovim/nvim-lspconfig`
   before adding a custom branch — names and defaults change.
3. **Apply** the change: add the lspconfig name to `servers`; add an
   `elseif name == "<server>"` branch only if it needs non-default settings
   (keep `on_attach`, `capabilities()`, `handlers`). Touch `install.lua` only if
   the mason package name differs (extend `null_ls_to_mason`).
4. **Verify:** run the `nvim-verify` skill. (mason installs run on next start;
   `:Mason` / `:checkhealth lsp` confirm interactively.)
