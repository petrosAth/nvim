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
   file `servers/<name>.lua`, auto-discovered by `setup_language_servers()` in
   `config.lua`; `install.lua` auto-derives the mason package).
2. **Verify the server's options** against `/neovim/nvim-lspconfig` before
   adding a custom config — names and defaults change. Run the
   `nvim-plugin-docs` skill for the full 3-tier lookup (Context7 → local
   clone → GitHub repo) if coverage is thin.
3. **Apply** the change: add the lspconfig name to `servers`; create
   `servers/<name>.lua` returning `function(shared) return { ... } end` only if
   it needs non-default settings (keep `on_attach = shared.on_attach`,
   `capabilities = shared.capabilities()`, `handlers = shared.handlers`). Touch
   `install.lua` only if the mason package name differs (extend
   `null_ls_to_mason`).
4. **Verify:** run the `nvim-verify` skill. (mason installs run on next start;
   `:Mason` / `:checkhealth lsp` confirm interactively.)

The binaries are **Mason-provisioned, never system-installed** — a new server,
formatter, or linter installs on the next Neovim start via `mason-tool-installer`
(`run_on_start`); don't `brew`/`npm -g` it. See `lua/plugins/lsp/AGENTS.md` →
"Tool provisioning — Mason, not the system", and `/nvim-verify` for the `PATH`
snippet when a tool must run from a shell.
