---
name: nvim-add-plugin
description: Adds a plugin to this lazy.nvim Neovim config from a GitHub `author/repo` argument (e.g. folke/flash.nvim). Fetches the repo's About tagline for the spec comment, pulls recommended setup from the plugin's docs, generates the spec file in the repo's convention, and handles the lazy-lock.json commit policy. Also covers replacing and removing a plugin.
argument-hint: <author/repo>
allowed-tools: mcp__plugin_github_github__search_repositories mcp__plugin_github_github__get_file_contents mcp__plugin_context7_context7__resolve-library-id mcp__plugin_context7_context7__query-docs
---

# Add a plugin from `author/repo`

Input: `$ARGUMENTS` is a GitHub slug `author/repo` (e.g. `folke/flash.nvim`, taken from `https://github.com/folke/flash.nvim`). If empty, ask the user for it.

## 1. Read the canonical convention

Read **`lua/plugins/AGENTS.md`** (spec idiom, descriptive-comment convention, file-name rule). It is the source of truth; the steps below are the procedure.

## 2. Derive the four identifiers

Four distinct identifiers derive from `<author>/<repo>`: the **spec string** (the arg verbatim), the **file name**, the **error name** (for `USER.loading_error_msg`), and the **require module** (from the docs — NOT the repo name). The derivation rules and edge-case examples are canonical in `lua/plugins/AGENTS.md` → "Naming & comment conventions" (read in step 1); this naming differs from the local-clone dir rule in `nvim-plugin-docs` (repo verbatim, no strip/fold).

## 3. Fetch the description comment (GitHub About tagline)

Use the GitHub MCP `search_repositories` with `query: repo:<author>/<repo>` and `minimal_output: false`; read `items[0].description`. That string is the comment. Fallback if unavailable: WebFetch `https://github.com/<author>/<repo>` and take the "About" line. Wrap it at ~120 columns; continuation lines start with `-- ` (see `lua/plugins/comment.lua` for a wrapped two-line comment).

## 4. Fetch recommended config from the plugin's docs

Run the `nvim-plugin-docs` skill with `<author>/<repo>` to get the module name, setup defaults, and lazy-load trigger. The skill runs the full 3-tier lookup — Context7 first, then the local lazy clone, then the GitHub repo — so no manual fallback is needed here.

## 5. Generate `lua/plugins/<name>.lua`

Match `lua/plugins/flash.lua` exactly — a local `setup` populated with the docs-recommended defaults, then the spec table:

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

If the plugin has **no** `setup()`, drop the `setup` function and the `setup(<module>)` call; keep the `pcall` guard (or, for a config-less plugin, just the spec entry with its comment + lazy trigger).

## 6. Lockfile

After Neovim installs the plugin, `lazy-lock.json` gains the new SHA. **Bundle that change into the same commit** as the new spec file — this is a config-driven change, not a pure bump (see the lockfile policy in the root `AGENTS.md`).

## 7. Verify

Run the `nvim-verify` skill.

---

## Replace a plugin

A plugin's config is **scattered** beyond its spec file; replacing means **re-pointing every touchpoint** to the new plugin. The full map is **"Where a plugin's config is scattered"** in `lua/plugins/AGENTS.md` — work it top to bottom. Derive the old plugin's handles (`<repo>`, `require` module, command names, highlight-group prefix, filetype) and sweep:

```sh
grep -rn '<module>\|<Command>\|<HlPrefix>\|<filetype>' lua plugin after colors
```

Re-point each hit. Beyond the mapped touchpoints, the **spec file** itself needs: swap the spec string, replace the comment with the new About tagline (step 3), update the `require` module + `setup` defaults from the new docs (step 4), update `USER.loading_error_msg("<repo>")`, and recreate any inline keymaps/toggles the old spec defined if still needed. Then bundle the `lazy-lock.json` change and run the `nvim-verify` skill.

## Remove a plugin

Same touchpoint map — but **delete** each hit instead of re-pointing. Two steps specific to removal:

1. **Reverse-dependency check first:** `grep -rn '"<author>/<repo>"' lua/plugins`. If another spec lists it under `dependencies`, **don't remove** it (or update that dependent too). Note any private deps now orphaned.
2. **Leave no dangling `require("<module>")`** in cross-file integrations (heirline/tabby/neo-tree/snacks/comment/dressing/fzf-lua/lsp) — the grep sweep above confirms nothing is left; a dangling `require` surfaces as a load error.

Bundle the `lazy-lock.json` removal; run the `nvim-verify` skill.

LSP-ecosystem plugins (`lua/plugins/lsp/**`) are orchestrated specially — use the `nvim-lsp` skill / `lua/plugins/lsp/AGENTS.md` instead.
