---
name: nvim-add-plugin
description:
  Adds a plugin to this lazy.nvim Neovim config from a GitHub `author/repo`
  argument (e.g. folke/flash.nvim). Fetches the repo's About tagline for the
  spec comment, pulls recommended setup from the plugin's docs, generates the
  spec file in the repo's convention, and handles the lazy-lock.json commit
  policy. Also covers replacing and removing a plugin.
argument-hint: <author/repo>
allowed-tools:
  mcp__plugin_github_github__search_repositories
  mcp__plugin_github_github__get_file_contents
  mcp__plugin_context7_context7__resolve-library-id
  mcp__plugin_context7_context7__query-docs
---

# Add a plugin from `author/repo`

Input: `$ARGUMENTS` is a GitHub slug `author/repo` (e.g. `folke/flash.nvim`,
taken from `https://github.com/folke/flash.nvim`). If empty, ask the user for
it.

## 1. Read the canonical convention

Read **`lua/plugins/AGENTS.md`** (spec idiom, descriptive-comment convention,
file-name rule). It is the source of truth; the steps below are the procedure.

## 2. Derive the four identifiers

These differ — derive each from `author/repo` (here `<author>/<repo>`):

| Identifier     | Rule                                                                    | Example (`folke/flash.nvim`) |
| -------------- | ----------------------------------------------------------------------- | ---------------------------- |
| spec string    | the arg verbatim                                                        | `"folke/flash.nvim"`         |
| file name      | `<repo>` → drop trailing `.nvim` → replace `.`→`-` → lowercase → `.lua` | `lua/plugins/flash.lua`      |
| error name     | `<repo>` verbatim (for `USER.loading_error_msg`)                        | `"flash.nvim"`               |
| require module | **from the docs — NOT the repo name**                                   | `require("flash")`           |

Edge cases: `lambdalisue/suda.vim` → file `suda-vim.lua`, error `"suda.vim"`;
`numToStr/Comment.nvim` → file `comment.lua`, error `"Comment.nvim"`, but
`require("Comment")` (capital C). Always take the module name from the docs.

## 3. Fetch the description comment (GitHub About tagline)

Use the GitHub MCP `search_repositories` with `query: repo:<author>/<repo>` and
`minimal_output: false`; read `items[0].description`. That string is the
comment. Fallback if unavailable: WebFetch `https://github.com/<author>/<repo>`
and take the "About" line. Wrap it at ~120 columns; continuation lines start
with `-- ` (see `lua/plugins/comment.lua` for a wrapped two-line comment).

## 4. Fetch recommended config from the plugin's docs

Consult the plugin's documentation via Context7: `resolve-library-id`
(libraryName `<author>/<repo>`), then `query-docs` for setup/usage. Determine:

- the exact `require("<module>")` name and whether it exposes `.setup()`;
- recommended **default options** (and keymaps if it ships them) — you will
  pre-fill `setup()` with these;
- a sensible lazy-load trigger. If Context7 is thin, use the GitHub MCP
  `get_file_contents` to look for a `docs/` directory (or similar: `doc/`,
  `documentation/`, `wiki/`) in the repo and read relevant files there. If no
  dedicated docs directory exists, fall back to the repo's README via the GitHub
  MCP / WebFetch.

## 5. Generate `lua/plugins/<name>.lua`

Match `lua/plugins/flash.lua` exactly — a local `setup` populated with the
docs-recommended defaults, then the spec table:

```lua
local function setup(<module>)
    <module>.setup({
        -- recommended defaults from the plugin's docs
    })
end

return {
    {
        -- <GitHub About tagline, wrapped ~120 cols>
        "<author>/<repo>",
        <lazy-load trigger>, -- event/cmd/keys/ft from docs; default: event = "VeryLazy"
        config = function()
            local loaded, <module> = pcall(require, "<module>")
            if not loaded then
                USER.loading_error_msg("<repo>")
                return
            end

            setup(<module>)
        end,
    },
}
```

If the plugin has **no** `setup()`, drop the `setup` function and the
`setup(<module>)` call; keep the `pcall` guard (or, for a config-less plugin,
just the spec entry with its comment + lazy trigger).

## 6. Lockfile

After Neovim installs the plugin, `lazy-lock.json` gains the new SHA. **Bundle
that change into the same commit** as the new spec file — this is a
config-driven change, not a pure bump (see the lockfile policy in the root
`AGENTS.md`).

## 7. Verify

Run the `nvim-verify` skill.

---

## Replace a plugin

A plugin's config is **scattered** beyond its spec file — see **"Where a
plugin's config is scattered"** in `lua/plugins/AGENTS.md` for the full
touchpoint map. Replacing means **re-pointing every touchpoint** to the new
plugin, not just editing the spec.

First, sweep for the old plugin's touchpoints. Derive its handles — `<repo>`,
`require` **module**, **command** names, **highlight-group prefix**,
**filetype** — then:

```sh
grep -rn '<module>\|<Command>\|<HlPrefix>\|<filetype>' lua plugin after colors
```

Then re-point each hit to the new plugin:

1. **Spec file** — swap the spec string, replace the comment with the new repo's
   About tagline (step 3), update the `require` module + `setup` defaults from
   the new docs (step 4), and update the `USER.loading_error_msg("<repo>")`
   name. **Recreate any inline keymaps/toggles** the old spec defined (snacks
   `:map`, treesitter/hydra/cmp) if the replacement still needs them.
2. **`plugin/mappings.lua`** — update the command strings /
   `require("<module>")` calls to the new plugin (which-key follows
   automatically).
3. **`after/ftplugin/<ft>.lua`** — rename to the new plugin's filetype if it has
   one.
4. **`lua/styling.lua`** (icons/separators), **`highlightGroups.lua`** (the
   plugin's highlight block), **`lua/ui/utilities.lua`** (buffer label) —
   re-point to the new plugin's names/filetype.
5. **Sessions** — update possession filetype exclusions / `sessions.lua` /
   `.nvim.lua` if the old plugin was referenced.
6. **Dependencies** — if the new plugin needs different `dependencies`, update
   them; check the old plugin wasn't a dependency of another spec.

Bundle the `lazy-lock.json` change; run the `nvim-verify` skill.

## Remove a plugin

Same scattered touchpoints (see the map in `lua/plugins/AGENTS.md`) — but you
**delete** each instead of re-pointing. Ordered:

1. **Reverse-dependency check first:**
   `grep -rn '"<author>/<repo>"' lua/plugins`. If another spec lists it under
   `dependencies`, **do not remove** it (or update that dependent too). Note any
   private deps it pulled in that are now orphaned.
2. **Spec file** — delete `lua/plugins/<name>.lua` (or its entry if it shares a
   file). Inline keymaps/toggles defined in it go away with it.
3. **`plugin/mappings.lua`** — remove its `USER.mappings` entries (which-key
   follows automatically).
4. **`after/ftplugin/<ft>.lua`** — delete if plugin-specific.
5. **`lua/styling.lua`** (icons/separators), **`highlightGroups.lua`** (its
   highlight block), **`lua/ui/utilities.lua`** (its label) — remove its
   entries.
6. **Sessions** — clear possession filetype exclusions / `sessions.lua` /
   `.nvim.lua` references.
7. **Cross-file `require("<module>")` integrations** (heirline/tabby/neo-tree/
   snacks/comment/dressing/telescope/lsp) — fix any so none dangle; the grep
   sweep above confirms nothing is left.
8. Bundle the `lazy-lock.json` removal; run the `nvim-verify` skill — a dangling
   `require` surfaces as a load error.

LSP-ecosystem plugins (`lua/plugins/lsp/**`) are orchestrated specially — use
the `nvim-lsp` skill / `lua/plugins/lsp/AGENTS.md` instead.
