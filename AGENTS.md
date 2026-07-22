# AGENTS.md

Guidance for AI agents (and humans) working in this repository. This is the canonical map; several subdirectories carry their own `AGENTS.md` with local detail and recipes — read the nearest one when working in that area.

This is a personal **Neovim configuration** written in Lua, managed by **lazy.nvim**. Entry point is `init.lua`; almost all logic lives under `lua/`, with the rest in Neovim's standard runtime directories (`plugin/`, `after/`, `colors/`, `ftdetect/`, etc.). It requires **Neovim 0.12+** (uses the treesitter main-branch rewrite and `vim.lsp.config()`).

## Startup & load order

Understanding the boot sequence explains where to put things and why files load without an explicit `require`.

1. **`init.lua` runs first, top to bottom.** It builds the global `USER` table (see below), sets the colorscheme (`vim.cmd.colorscheme(USER.theme)`), then in order:
   - `require("utilities")` — registers `USER` helper functions.
   - `require("local-config").setup()` — defines `USER.load_local_config` **before** `exrc` runs (so project `.nvim.lua` files can call it).
   - `require("plugin-manager").init()` — bootstraps lazy.nvim.
2. **lazy.nvim takes over plugin loading.** It sets `vim.go.loadplugins = false`, so Neovim does **not** run its native plugin-sourcing step — lazy does it, triggered by the `require("plugin-manager").init()` call above. In order, lazy:
   1. runs every plugin's `init()` function;
   2. loads `lazy=false` plugins, sourcing their `plugin/` and `ftdetect/` files;
   3. sources **this config's** `plugin/` and `ftdetect/` files from the `runtimepath` (`plugin/options.lua`, `plugin/mappings.lua` — no explicit require) only _after_ `init.lua` reaches the plugin-manager call;
   4. sources `after/plugin/` **last** — so `after/plugin/*` and `after/ftplugin/*` override plugin defaults.

   Files within a runtime directory are sourced in **alphabetical order**.

3. **`lua/` is the `require()` search root.** `require("x")` resolves to `lua/x.lua` or `lua/x/init.lua`. Plugin specs under `lua/plugins/` are auto-discovered by lazy.nvim (see `lua/plugins/AGENTS.md`).
4. **Filetype config:** `ftplugin/<ft>.lua` loads on filetype detection; `after/ftplugin/<ft>.lua` loads after it, to override.
5. **Project-local config** (`.nvim.lua`, current + parent dirs) is loaded via Neovim's `exrc` and is **trust-gated** through Neovim's trust database (`$XDG_STATE_HOME/nvim/trust`) via `:trust` / `vim.secure.read()`. See `lua/local-config.lua`.

## Directory map

Where things live and where to add them:

| Path                     | What it holds                                                                                       |
| ------------------------ | --------------------------------------------------------------------------------------------------- |
| `init.lua`               | `USER` table, theme selection, top-level load order.                                                |
| `lua/plugins/`           | One lazy.nvim spec per file; auto-discovered. See `lua/plugins/AGENTS.md`.                          |
| `lua/plugins/<dir>/`     | Complex plugins: `init.lua` is the spec, siblings are helper modules — see `lua/plugins/AGENTS.md`. |
| `lua/plugins/lsp/`       | LSP ecosystem (servers, mason, conform, nvim-lint, UI helpers). See `lua/plugins/lsp/AGENTS.md`.    |
| `lua/plugins/heirline/`  | Statusline + winbar (tabline is tabby's). See `lua/plugins/heirline/AGENTS.md`.                     |
| `lua/themes/`            | Palette-based theme engine. See `lua/themes/AGENTS.md`.                                             |
| `lua/ui/`                | UI helpers: side-panel options, buffer labels.                                                      |
| `lua/styling.lua`        | Design system: icons, borders, separators, fillchars/listchars, styling variables.                  |
| `lua/utilities.lua`      | Core `USER` helpers (`loading_error_msg`, `is_git_repo`).                                           |
| `lua/local-config.lua`   | `.nvim.lua` loader + `:Project*` scaffolding commands.                                              |
| `lua/plugin-manager.lua` | lazy.nvim bootstrap + `setup()` options.                                                            |
| `plugin/options.lua`     | All `vim.opt.*` settings. See `plugin/AGENTS.md`.                                                   |
| `plugin/mappings.lua`    | The `USER.mappings` table (all keybindings). See `plugin/AGENTS.md`.                                |
| `after/plugin/`          | Final-word autocommands (`autocommands.lua`), user commands (`utilities.lua`), sessions.            |
| `after/ftplugin/`        | Per-filetype option overrides (one file per filetype).                                              |
| `colors/`                | One-line colorscheme entry points (`require("themes").load("<name>")`).                             |
| `ftdetect/`              | Custom filetype detection.                                                                          |
| `templates/`             | File templates copied by the `:Project*` commands.                                                  |
| `spell/`                 | Custom spell dictionary.                                                                            |

## Global conventions

### The `USER` global table

Defined in `init.lua`; the single global namespace (no other globals). Fields:

- `USER.styling` — `require("styling")`: icons, borders, separators, variables.
- `USER.theme` — active theme name (env `SYSTEM_THEME`, else `"gruvbox"`).
- `USER.transparent_bg` — transparency toggle.
- `USER.mappings` — the keybinding table (populated in `plugin/mappings.lua`).
- `USER.local_config` — project-local config paths/state.
- `USER.lsp` — `{ show_inlay_hints, enable_semantic_tokens }`.

Helper methods (attached by their modules): `USER.loading_error_msg(name)`, `USER.is_git_repo()`, `USER.load_local_config(opts)`.

### Plugin & submodule idioms

A plugin file returns a **table of specs** that loads the plugin defensively; helper modules (non-spec files in plugin subdirs) return a module table (`local M = {}; … return M`). Full code shapes: `lua/plugins/AGENTS.md → Spec idiom`.

### Other conventions

- **File names** are kebab-case (`nvim-surround.lua`, `inc-rename.lua`).
- **`<Space>`** is the primary mapping prefix; `<Leader>` is also used.
- **No test suite.** Verification means running the **`/nvim-verify`** skill (`stylua --check`, `selene`, headless smoke-load) after any change.

## Tooling

Config-only, no build:

- `stylua.toml` — Lua formatter (120 col, 4-space, double quotes). Run `stylua`.
- `selene.toml` / `selene-neovim.yml` — Lua linter. Run `selene`.
- `.prettierrc` — JS/YAML/markdown formatting (single quotes, prose wrap).
- `.luarc.json`, `.editorconfig` — language-server and editor settings.

These files only **configure** the tools; the binaries themselves — `stylua`, `selene`, `prettierd`, and every LSP server / formatter / linter — are **provisioned by Mason, not installed on the system `PATH`**. See `lua/plugins/lsp/AGENTS.md` → "Tool provisioning — Mason, not the system" for the full story, including how to run them from a shell.

**Claude Code skills** (`.claude/skills/`) wrap the recipes documented here — the docs stay the source of truth: `/nvim-add-plugin`, `/nvim-lsp`, `/nvim-theme`, `/nvim-keymaps`, `/nvim-statusline` (the last four auto-activate when you edit their area), `/nvim-verify` (the check loop), and `/nvim-plugin-docs` (the 3-tier plugin-doc lookup, wrapped for broad investigations by the `.claude/agents/nvim-plugin-doc-investigator` subagent).

## Consulting documentation

Neovim 0.12+ moves fast (e.g. `vim.lsp.config()`, the treesitter main-branch rewrite). **Verify behavior against current docs rather than training data** before relying on startup/load-order, runtime-directory, `exrc`/trust, LSP, or treesitter behavior, and before adding or upgrading a plugin.

For any third-party plugin's docs (setup options, require-module name, API, keymaps, lazy-load triggers), use the **`/nvim-plugin-docs` skill** — or the **`nvim-plugin-doc-investigator`** subagent for broad investigations. The skill owns the priority chain, the short-circuit rules, and the known-good Context7 IDs (Neovim runtime, lazy.nvim, nvim-lspconfig, conform, nvim-lint, heirline); this file does not restate them.

**For Neovim-core / CLI tools:** Context7 (`/neovim/neovim`) directly; also `:help <topic>`, `:Lazy help`, and `man <cmd>`. In-editor help remains authoritative. WebSearch as final fallback when Context7 coverage is thin.

## Commit conventions

This repo uses **Conventional Commits with scopes**. **No gitmoji.**

```
<type>(<scope>): <short summary>
```

- Types in use: `feat`, `fix`, `refactor`, `chore`, `docs`.
- Scopes seen in history: `lsp`, `diff`, `ui`, `treesitter`, `ftdetect`, `highlightGroups`, `templates`, and similar feature/area names. Pick the scope that matches the area you touched; omit the scope for repo-wide changes.

Examples:

```
feat(lsp): add lensline.nvim with focused toggle via snacks
docs: add AGENTS.md with lockfile handling and commit conventions
```

## Lockfile handling (`lazy-lock.json`) — important

`lazy-lock.json` is lazy.nvim's lockfile. It pins **every plugin to an exact commit SHA** and is **tracked in git** (intentionally — it makes plugin versions reproducible across machines). Treat it like `package-lock.json`. Decide how to commit it by **what caused the change**:

- **Pure version bump** — `:Lazy update` / `:Lazy sync` / `:Lazy restore` and **only `lazy-lock.json` changed** (no `.lua`/config edits) → commit it on its own as `chore(deps): bump lazy-lock.json`. These standalone commits are your **checkpoints**: each is a reproducible, known-good plugin snapshot you can `git revert`, `git bisect`, or `:Lazy restore` back to.
- **Consequence of a config change** — a plugin was added, removed, replaced, or pinned, so both a `lua/plugins/*.lua` file **and** `lazy-lock.json` changed → **bundle the lockfile into the same commit** as the config change, so the config and the locked versions never disagree at any point in history (e.g. `refactor(diff): replace diffview.nvim with codediff.nvim` includes its lockfile change).

Rule of thumb: **the lockfile travels with the manifest change that produced it; pure bumps stand alone.**

To roll back a bad update: `git checkout <good-commit> -- lazy-lock.json`, then `:Lazy restore` in Neovim — every plugin resets to the SHA recorded in the lockfile. A committed lockfile is a restore point for plugin **versions**, not for config.

**Never hand-edit `lazy-lock.json`.** Always regenerate it via lazy.nvim commands (`:Lazy update`, `:Lazy sync`, `:Lazy restore`).

The same bundle-with-its-manifest-change / standalone-pure-bump / never-hand-edit policy applies to any lockfile in any ecosystem. **Compiled/generated artifacts are NOT lockfiles** — they stay git-ignored (e.g. `plugin/packer_compiled.lua` in `.gitignore`), not committed.
