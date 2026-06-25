# lua/plugins/lsp/ — AGENTS.md

The LSP ecosystem. The spec is `init.lua` (`neovim/nvim-lspconfig` + 8
dependencies); everything else is a helper module returning `M` with a `setup`
or `init` function. See the root `AGENTS.md` for global conventions.

## Orchestration map

- **`init.lua`** — the spec. Holds the `servers` list, the `root_files` list,
  and the dependency list. Its `config` runs, in order:
  `require("plugins.lsp.config").setup(...)` → `install.setup(servers)` → the UI
  helpers' `init()` (`inc-rename`, `glance`, `nvim-lightbulb`,
  `tiny-code-action`).
- **`config.lua`** — client setup. `M.setup()` wires mason + mason-lspconfig,
  configures diagnostics, then `setup_language_servers()` registers each server
  via `vim.lsp.config(name, {...})`. Most servers use a shared default branch;
  servers needing special settings (`bashls`, `emmet_language_server`, `eslint`,
  `intelephense`, `lua_ls`, `ruff`, `ts_ls`) have their own `if`/`elseif`
  branch. Also defines the shared `on_attach` (navic, semantic-token gating,
  formatexpr, inlay hints) and `capabilities`.
- **`install.lua`** — auto-derives the mason install list from `servers` plus
  the active null-ls sources, then drives `mason-tool-installer`. The
  `null_ls_to_mason` table maps source names whose mason package differs (or
  `false` to skip). New servers usually need **no** edit here.
- **`mason.lua` / `mason-lspconfig.lua`** — mason UI + the mason↔lspconfig
  bridge.
- **`null-ls.lua`** — none-ls formatters/linters/diagnostics.
- **UI helpers** — `glance.lua`, `inc-rename.lua`, `nvim-lightbulb.lua`,
  `tiny-code-action.lua`, `nvim-navic.lua`.

## Recipe — add an LSP server

**Companion skill:** `/nvim-lsp` applies this recipe and runs `/nvim-verify`.

1. Add the **lspconfig server name** to the `servers` list in `init.lua`.
2. If it needs non-default settings, add an `elseif name == "<server>"` branch
   in `setup_language_servers()` in `config.lua` (copy an existing branch; keep
   `on_attach`, `capabilities()`, `handlers`). Otherwise the shared default
   branch covers it.
3. `install.lua` installs it automatically via mason-tool-installer. Only touch
   it if the mason package name differs from the lspconfig name — then extend
   `null_ls_to_mason` (for null-ls sources) or adjust the mapping logic.
4. Confirm the server's settings against `/neovim/nvim-lspconfig` on Context7.
