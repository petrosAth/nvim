---
name: nvim-plugin-docs
description:
  Investigates a Neovim plugin's documentation through a fixed priority chain —
  Context7 first, then the local clone in ~/.local/share/nvim/lazy/<repo>, then
  the plugin's GitHub repo. Use whenever you need a plugin's setup options,
  require-module name, API, keymaps, or lazy-load triggers before installing or
  configuring it. Also covers Mason-provisioned LSP servers, conform
  formatters, and nvim-lint linters (e.g. intelephense, phpstan) — these
  don't have a local lazy clone, so the chain adapts (see Tier 2).
allowed-tools:
  mcp__plugin_context7_context7__resolve-library-id
  mcp__plugin_context7_context7__query-docs
  mcp__plugin_github_github__search_repositories
  mcp__plugin_github_github__get_file_contents Read Grep Glob WebFetch
---

# Investigate a plugin's docs

Input: `$ARGUMENTS` is a plugin identifier — usually `author/repo` (e.g.
`folke/flash.nvim`), sometimes just a `require` module or repo name.

## Derive the local dir name

Take the **repo** part verbatim as the local directory name under the lazy
store. Examples:

| Input                   | Local dir                                |
| ----------------------- | ---------------------------------------- |
| `folke/flash.nvim`      | `~/.local/share/nvim/lazy/flash.nvim`    |
| `numToStr/Comment.nvim` | `~/.local/share/nvim/lazy/Comment.nvim`  |
| `rebelot/heirline.nvim` | `~/.local/share/nvim/lazy/heirline.nvim` |

Note: this differs from the spec-file naming rule in `nvim-add-plugin` (no
`.nvim` strip, no case-fold). The dir name is the repo verbatim.

## Tier 1 — Context7 (preferred)

1. `resolve-library-id` with `libraryName: <author>/<repo>`.
2. `query-docs` for the specific question (setup options / module name / API /
   keymaps / lazy-load events).

**Known-good IDs** (skip resolve for these):

| Plugin              | Context7 ID               |
| ------------------- | ------------------------- |
| Neovim runtime docs | `/neovim/neovim`          |
| lazy.nvim           | `/folke/lazy.nvim`        |
| nvim-lspconfig      | `/neovim/nvim-lspconfig`  |
| conform.nvim        | `/stevearc/conform.nvim`  |
| nvim-lint           | `/mfussenegger/nvim-lint` |
| heirline.nvim       | `/rebelot/heirline.nvim`  |

If Context7 returns good coverage for the question, report the answer and stop.

## Tier 2 — local lazy clone (exact installed version)

Use this when Context7 is thin, the question is version-specific to the pinned
commit, or the answer needs to match what is actually running (per
`lazy-lock.json`). The local clone is always the exact installed version.

Path: `~/.local/share/nvim/lazy/<repo>/`

Priority within the clone:

1. `doc/*.txt` — Vim help files (most complete, structured).
2. `README.md` — quickstart and usage summary.
3. `lua/` source — for actual `setup()` defaults and option tables not
   documented elsewhere.

Use `Glob` to find files, `Read` to read them, `Grep` to search within them.

**Tier 2 short-circuits Tier 3.** The local clone _is_ the GitHub repo checked
out at the pinned commit, so if the dir exists it is authoritative — answer from
it and stop; never fall through to Tier 3 for a locally-installed plugin (going
online would only re-fetch the same docs).

**Mason-provisioned tools have no local clone.** LSP servers, conform
formatters, and nvim-lint linters (`intelephense`, `phpstan`, `phpcs`, …) are
installed by Mason, not `lua/plugins/` — there is no
`~/.local/share/nvim/lazy/<name>/` for them. Skip straight to Tier 3, and note
the target repo is usually *not* the same as a Tier 1 wrapper ID: Context7's
`/neovim/nvim-lspconfig` (or `/stevearc/conform.nvim` / `/mfussenegger/nvim-lint`)
only documents that wrapper's own defaults (`cmd`, `root_markers`, a minimal
settings snippet) — the tool's *own* full settings schema and behavior lives
in the tool's own docs/website/repo (e.g. intelephense's settings are at
`bmewburn/intelephense-docs` and `intelephense.com/docs`, not
`neovim/nvim-lspconfig`).

## Tier 3 — online repo (only when not installed locally)

Reach this tier **only when the plugin dir is absent** — a new plugin not yet
added, or one you are evaluating before installing.

1. GitHub MCP `get_file_contents` to read `doc/`, `README.md`, `wiki/` from the
   `<author>/<repo>` repo.
2. `search_repositories` (query `repo:<author>/<repo>`) for the About tagline
   and repo metadata.
3. WebFetch `https://github.com/<author>/<repo>` as last resort.

## Output contract

Report the answer with:

- **(a) Which tier it came from** — Tier 1 (Context7), Tier 2 (local clone at
  the path you read), or Tier 3 (GitHub: URL or file cited).
- **(b) The exact `require("<module>")` name** — the module name often differs
  from the repo name. Always call it out explicitly. Example:
  `numToStr/Comment.nvim` → `require("Comment")` (capital C, not the repo slug).
  This mismatch class is common and load errors silently swallow it.

## Cross-links

- To **add** a plugin after investigating its docs, use `/nvim-add-plugin`. This
  skill is its step-4 engine.
- For Neovim-core / LSP / treesitter behavior (not a third-party plugin), the
  known IDs above apply directly — no tier fallback needed.
