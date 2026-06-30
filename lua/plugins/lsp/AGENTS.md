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
  via `vim.lsp.config(name, {...})`. It auto-discovers per-server config files
  under `servers/` (via the runtimepath); a server with a matching
  `servers/<name>.lua` uses that file, all others get a shared default of
  `{ on_attach, capabilities(), handlers }`. Also defines the shared `on_attach`
  (navic, semantic-token gating, formatexpr, inlay hints) and `capabilities`,
  which it hands to each server file through a `shared` context table.
- **`servers/<name>.lua`** — one file per server that needs non-default settings
  (`bashls`, `emmet_language_server`, `eslint`, `intelephense`, `lua_ls`,
  `ruff`, `ts_ls`). Each returns `function(shared) -> config_table`, where
  `shared` is `{ on_attach, capabilities, handlers, lspconfig, root_files }` —
  use `shared.capabilities()` (it's the function, called per server), wrap
  `shared.on_attach` to extend it (see `ruff`/`ts_ls`), and build `root_dir`
  from `shared.lspconfig.util.root_pattern(shared.root_files)` (see
  `eslint`/`lua_ls`).
- **`install.lua`** — auto-derives the mason install list from `servers` plus
  the active null-ls sources, then drives `mason-tool-installer`. The
  `null_ls_to_mason` table maps source names whose mason package differs (or
  `false` to skip). New servers usually need **no** edit here.
- **`mason.lua` / `mason-lspconfig.lua`** — mason UI + the mason↔lspconfig
  bridge.
- **`null-ls.lua`** — none-ls formatters/linters/diagnostics.
- **UI helpers** — `glance.lua`, `inc-rename.lua`, `nvim-lightbulb.lua`,
  `tiny-code-action.lua`, `nvim-navic.lua`.

## Tool provisioning — Mason, not the system

**Every LSP server, formatter, and linter this config uses is installed and
managed by [Mason](https://github.com/mason-org/mason.nvim) — none are expected
on the login-shell `PATH`.** A tool that doesn't resolve is a Mason package that
hasn't installed yet, **not** a reason to `brew`/`apt`/`npm -g` it.

- **Where they live:** binaries in `$HOME/.local/share/nvim/mason/bin`, packages
  under `$HOME/.local/share/nvim/mason/packages/`.
- **How the install list is derived:** `install.lua` builds `ensure_installed`
  from the `servers` list (lspconfig→mason via `mason-lspconfig.mappings`) **plus**
  the live none-ls sources (`require("null-ls").get_sources()`), then drives
  `mason-tool-installer` with `run_on_start = true`. So adding a server to
  `servers` (in `init.lua`) or a source to `null-ls.lua` is all it takes — the
  install follows on the next Neovim start. Interactive: `:Mason`,
  `:MasonToolsUpdate` (`<space>ul`), `:NullLsInfo` (`<space>sn`).
- **Name mismatches:** a mason package name can differ from the lspconfig /
  none-ls source name → mapped in `null_ls_to_mason` in `install.lua`
  (e.g. `phpcsfixer` → `php-cs-fixer`).
- **The one system exception:** `zsh` (mapped `false`; `zsh -n` uses the login
  shell, no mason package).
- **Running a Mason tool from a shell** (verify / CI / manual `stylua`,
  `prettierd`, `shfmt`, `black`, …): prepend Mason's bin to `PATH` —

  ```sh
  export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"
  ```

  The `/nvim-verify` skill relies on exactly this for `stylua`/`selene`.

## Recipe — add an LSP server

**Companion skill:** `/nvim-lsp` applies this recipe and runs `/nvim-verify`.

1. Add the **lspconfig server name** to the `servers` list in `init.lua`.
2. If it needs non-default settings, create `servers/<name>.lua` returning
   `function(shared) return { ... } end` (copy an existing file; keep
   `on_attach = shared.on_attach`, `capabilities = shared.capabilities()`,
   `handlers = shared.handlers`). The file is auto-discovered — no edit to
   `config.lua` needed. Otherwise the shared default covers it with no file.
3. `install.lua` installs it automatically via mason-tool-installer. Only touch
   it if the mason package name differs from the lspconfig name — then extend
   `null_ls_to_mason` (for null-ls sources) or adjust the mapping logic.
4. Confirm the server's settings against `/neovim/nvim-lspconfig`; run the
   `nvim-plugin-docs` skill for the full 3-tier lookup (Context7 → local clone
   → GitHub repo) if coverage is thin.
