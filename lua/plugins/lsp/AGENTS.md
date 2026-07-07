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
  `eslint`/`lua_ls`). For settings that must be resolved dynamically per
  project root (e.g. querying a host tool's version) rather than hardcoded,
  use `before_init(params, config)` — fires once per client start, after
  `root_dir` resolves but before `initialize`; mutating `config.settings`
  there is read by Neovim's default `workspace/configuration` handler (see
  `intelephense`, which shells out with `cwd = config.root_dir`).
- **`install.lua`** — auto-derives the mason install list from `servers` plus
  the configured conform formatters and nvim-lint linters, then drives
  `mason-tool-installer`. The `tool_to_mason` table maps tool names whose mason
  package differs (or `false` to skip). New servers usually need **no** edit
  here.
- **`mason.lua` / `mason-lspconfig.lua`** — mason UI + the mason↔lspconfig
  bridge.
- **`conform.lua`** — [conform.nvim](https://github.com/stevearc/conform.nvim)
  formatters (`formatters_by_ft`, `lsp_format = "fallback"`).
- **`nvim-lint.lua`** — [nvim-lint](https://github.com/mfussenegger/nvim-lint)
  linters (`linters_by_ft` + the `try_lint` autocmd).
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
  from the `servers` list (lspconfig→mason via `mason-lspconfig.mappings`)
  **plus** the tools configured in `conform.lua` (`formatters_by_ft`) and
  `nvim-lint.lua` (`linters_by_ft`), then drives `mason-tool-installer` with
  `run_on_start = true`. So adding a server to `servers` (in `init.lua`) or a
  formatter/linter to those two files is all it takes — the install follows on
  the next Neovim start. Interactive: `:Mason`, `:MasonToolsUpdate`
  (`<space>ul`), `:ConformInfo` (`<space>sn`).
- **Name mismatches:** a mason package name can differ from the lspconfig /
  conform / nvim-lint tool name → mapped in `tool_to_mason` in `install.lua`
  (e.g. `php_cs_fixer` → `php-cs-fixer`).
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
   `tool_to_mason` (shared with conform/nvim-lint tools) or adjust the mapping
   logic.
4. **Discover the valid server name** (the `lsp/<name>.lua` basename) from the
   full catalog — in-editor `:help lspconfig-all`, or
   [`doc/configs.md`](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md).
   Then confirm that server's settings against `/neovim/nvim-lspconfig`; run the
   `nvim-plugin-docs` skill if coverage is thin.

## Recipe — add a formatter or linter

1. **Formatter:** add the conform builtin to the right filetype in
   `conform.lua`'s `formatters_by_ft` (custom args go in the `formatters`
   override table, like `shfmt`).
2. **Linter:** add the nvim-lint builtin to the right filetype in
   `nvim-lint.lua`'s `linters_by_ft`.
3. `install.lua` installs the tool automatically. Only edit it if the mason
   package name differs from the conform/nvim-lint tool name — extend
   `tool_to_mason` (map to `false` to skip a tool with no mason package, like
   `zsh`). The statusline picks the active formatters/linters up automatically
   via `LspBlock` (`require("conform").list_formatters_to_run` /
   `require("lint").linters_by_ft`).
4. **Discover the builtin name** from the full lists — formatters: in-editor
   `:help conform-formatters` or conform's README "Formatters"
   ([`doc/`](https://github.com/stevearc/conform.nvim/tree/master/doc), the
   `lua/conform/formatters/<name>.lua` basename); linters: nvim-lint's
   [README "Available Linters"](https://github.com/mfussenegger/nvim-lint/blob/master/README.md)
   table (the `lua/lint/linters/<name>.lua` basename). Then confirm the options
   against `/stevearc/conform.nvim` or `/mfussenegger/nvim-lint`; run the
   `nvim-plugin-docs` skill if coverage is thin.
