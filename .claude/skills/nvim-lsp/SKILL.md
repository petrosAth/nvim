---
name: nvim-lsp
description: Adds or configures a language server (or conform formatter / nvim-lint linter) in this Neovim config's LSP setup. Use when the user wants a new LSP server, per-server settings, or formatter/linter changes. Auto-applies when editing files under lua/plugins/lsp/.
paths:
  - lua/plugins/lsp/**
---

# Add / configure an LSP server, formatter, or linter

Thin orchestrator — read the canonical steps, don't duplicate them.

1. **Read `lua/plugins/lsp/AGENTS.md`** for the orchestration map and the two recipes — "add an LSP server" and "add a formatter or linter".
2. **Verify the options** against the relevant docs before adding a custom config — names and defaults change. Run the `nvim-plugin-docs` skill: its known-good Context7 IDs table covers nvim-lspconfig, conform, and nvim-lint, including where each full builtin catalog lives.
3. **Apply** the change per the AGENTS.md recipes.
4. **Verify:** run the `nvim-verify` skill. (mason installs run on next start; `:Mason` / `:checkhealth lsp` confirm interactively.)

Binaries are **Mason-provisioned, never system-installed** — see `lua/plugins/lsp/AGENTS.md` → "Tool provisioning — Mason, not the system".
