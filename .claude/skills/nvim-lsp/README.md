# nvim-lsp

Adds or configures a language server (or conform formatter / nvim-lint linter)
in the LSP setup.

## Invocation

```
/nvim-lsp
```

Also auto-triggers when you ask Claude to edit files under `lua/plugins/lsp/`.
The skill reads `lua/plugins/lsp/AGENTS.md` for the orchestration map, makes the
necessary edits, and runs `/nvim-verify`.

## Examples

**Add a new language server:**

```
/nvim-lsp
Add rust-analyzer for Rust development.
```

**Add a formatter via conform:**

```
/nvim-lsp
Add prettierd as a conform formatter for TypeScript and JavaScript.
```

**Add a linter via nvim-lint:**

```
/nvim-lsp
Add eslint_d as an nvim-lint linter for TypeScript and JavaScript.
```

**Configure per-server options:**

```
/nvim-lsp
Configure lua-ls to suppress the missing-fields warning.
```

## What it touches

- `lua/plugins/lsp/init.lua` — adds the server name to the `servers` list
- `lua/plugins/lsp/config.lua` — adds a custom branch only if non-default
  settings are needed
- `lua/plugins/lsp/conform.lua` / `nvim-lint.lua` — adds a formatter / linter to
  the filetype map
- `lua/plugins/lsp/install.lua` — extends the mason name mapping
  (`tool_to_mason`) if it differs from the tool name
- Runs `/nvim-verify` after changes
- Verify interactively with `:Mason` and `:checkhealth lsp` inside Neovim
