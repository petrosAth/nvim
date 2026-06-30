---
name: nvim-lsp
description:
  Adds or configures a language server (or conform formatter / nvim-lint linter)
  in this Neovim config's LSP setup. Use when the user wants a new LSP server,
  per-server settings, or formatter/linter changes. Auto-applies when editing
  files under lua/plugins/lsp/.
paths: lua/plugins/lsp/**
---

# Add / configure an LSP server, formatter, or linter

Thin orchestrator — read the canonical steps, don't duplicate them.

1. **Read `lua/plugins/lsp/AGENTS.md`** for the orchestration map and the
   recipes — "add an LSP server" (`servers` list in `init.lua`; optional
   per-server file `servers/<name>.lua`, auto-discovered by
   `setup_language_servers()` in `config.lua`) and "add a formatter or linter"
   (`conform.lua` `formatters_by_ft` / `nvim-lint.lua` `linters_by_ft`).
   `install.lua` auto-derives the mason package from all three.
2. **Verify the options** against the relevant docs before adding a custom
   config — names and defaults change: `/neovim/nvim-lspconfig` for servers,
   `/stevearc/conform.nvim` for formatters, `/mfussenegger/nvim-lint` for
   linters. Run the `nvim-plugin-docs` skill if coverage is thin. (To find a
   valid builtin name, browse the full catalogs — `:help lspconfig-all`,
   `:help conform-formatters`, and nvim-lint's README "Available Linters"; full
   detail in `lua/plugins/lsp/AGENTS.md`.)
3. **Apply** the change per the AGENTS.md recipes — for a server, add the
   lspconfig name to `servers` and add `servers/<name>.lua` only if it needs
   non-default settings; for a formatter/linter, add the builtin to
   `formatters_by_ft` / `linters_by_ft`. Touch `install.lua` only if the mason
   package name differs (extend `tool_to_mason`).
4. **Verify:** run the `nvim-verify` skill. (mason installs run on next start;
   `:Mason` / `:checkhealth lsp` confirm interactively.)

Binaries are **Mason-provisioned, never system-installed** — they install on the
next Neovim start. See `lua/plugins/lsp/AGENTS.md` → "Tool provisioning — Mason,
not the system".
