# lua/plugins/ — AGENTS.md

Local guidance for plugin specs. See the root `AGENTS.md` for global conventions
and the startup/load order.

## What lives here

One **lazy.nvim spec per file**, auto-discovered via `{ import = "plugins" }` in
`lua/plugin-manager.lua` (recursive). File names are kebab-case after the plugin
(`nvim-surround.lua`, `todo-comments.lua`).

**Complex plugins get a subdirectory** whose `init.lua` is the spec and whose
siblings are helper modules: `lsp/`, `heirline/`, `fzf-lua/`, `tabby/`,
`which-key/`, `mini/`. The spec's `config` function `require()`s those modules
(e.g. `require("plugins.heirline.status-line")`) to keep each concern small.
Some carry their own nested `AGENTS.md` — see `lsp/AGENTS.md` (LSP ecosystem)
and `heirline/AGENTS.md` (statusline + winbar).

## Spec idiom

Load defensively, delegate to a local `setup`. Modeled on `comment.lua`:

```lua
local function setup(plugin)
    plugin.setup({ ... })
end

return {
    {
        -- <plugin's GitHub "About" tagline>
        "owner/repo",
        -- lazy-load triggers: event / cmd / keys / ft / lazy=false / priority
        config = function()
            local loaded, plugin = pcall(require, "plugin-module")
            if not loaded then
                USER.loading_error_msg("plugin-module")
                return
            end
            setup(plugin)
        end,
    },
}
```

## Naming & comment conventions

- **Descriptive comment:** the first line inside the spec is a comment with the
  plugin's GitHub "About" tagline (e.g. `flash.lua`'s
  `-- Navigate your code with search labels...`). Wrap at ~120 columns, with
  continuation lines starting `-- ` (see `comment.lua`).
- **File name:** take the repo (the part after `/`), drop a trailing `.nvim`,
  replace any remaining `.` with `-`, lowercase, add `.lua` — e.g.
  `folke/flash.nvim` → `flash.lua`, `lambdalisue/suda.vim` → `suda-vim.lua`,
  `numToStr/Comment.nvim` → `comment.lua`.
- **`require` module name and the `USER.loading_error_msg("<repo>")` name come
  from the plugin's docs/repo, not the file name** — e.g. `Comment.nvim` loads
  as `require("Comment")` (capital C) with
  `USER.loading_error_msg("Comment.nvim")`.

## Recipe — add a plugin

**Companion skill:** `/nvim-add-plugin` applies this recipe and runs
`/nvim-verify`.

1. Create `lua/plugins/<name>.lua` returning a table of specs as above.
   lazy.nvim discovers it automatically; no registration needed.
2. If it's elaborate (multiple modules, statusline-style components), make a
   `lua/plugins/<name>/` dir with `init.lua` (the spec) + helper modules.
3. Launch Neovim; lazy installs it and updates `lazy-lock.json`. **Bundle that
   lockfile change into the same commit** as the new spec file (see the root
   `AGENTS.md` lockfile policy).
4. Check the plugin's current docs via Context7 before wiring options (resolve
   its repo with `resolve-library-id`).

## Where a plugin's config is scattered

A plugin is **more than its spec file** — its settings are spread across the
config. When **replacing or removing** a plugin (see the `/nvim-add-plugin`
skill), check every touchpoint below. Derive the plugin's handles first — its
`<repo>` name, `require` **module**, its **command** names (`FzfLua`, `Neotree`,
`UndotreeToggle`, …), its **highlight-group prefix** (`GitSigns`, `FzfLua`, …),
and its **filetype** — then sweep:

```sh
grep -rn '<module>\|<Command>\|<HlPrefix>\|<filetype>' lua plugin after colors
grep -rn '"<author>/<repo>"' lua/plugins   # reverse-dependency check
```

| Location                                                                                                  | Plugin-specific content                                                                                                                                                                                                                                                                                                                    | How to find it                                    |
| --------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------- |
| `lua/plugins/<name>.lua`                                                                                  | the spec, **and inline keymaps/toggles** some plugins define in `setup` (snacks `:map`, treesitter incremental/textobjects `vim.keymap.set`, `hydra({…})`, cmp `mapping`)                                                                                                                                                                  | the file                                          |
| `plugin/mappings.lua`                                                                                     | keymaps that invoke the plugin — **command strings** (`<CMD>…>`) and `require("<module>")` calls (no `-- plugin` comments here). which-key auto-reads `USER.mappings`, so editing here is enough.                                                                                                                                          | grep command + module                             |
| `after/ftplugin/<ft>.lua`                                                                                 | per-plugin-filetype overrides — plugin-named files (`aerial`, `alpha`, `lazy`, `trouble`, `undotree`, `yeet-cache`); `help`/`man`/`qf`/`diff` are builtins.                                                                                                                                                                                | filename = filetype                               |
| `lua/styling.lua`                                                                                         | plugin icons/separators (`icons.git.signs.*`, `icons.git.signs.satellite.*`, `icons.lazy.*`, `icons.fzf`, `icons.undoTree`, `icons.diffview`, `icons.alphaCursor`, `separators.hlslens.*`)                                                                                                                                                 | grep name / icon key                              |
| `lua/themes/highlightGroups.lua`                                                                          | dedicated highlight groups for 35+ plugins, each under a `-- <plugin>.nvim` marker                                                                                                                                                                                                                                                         | grep the marker **and** the group prefix          |
| `lua/ui/utilities.lua`                                                                                    | buffer/window labels keyed by plugin filetype/buftype (`aerial`, `Glance`, `trouble`, `undotree`, `Outline`, `fzf`, `neo-tree …`)                                                                                                                                                                                                          | grep the filetype string                          |
| `lua/ui/side-panels.lua`                                                                                  | shared side-panel behavior used by the plugin ftplugin files (indirect)                                                                                                                                                                                                                                                                    | referenced from `after/ftplugin/*`                |
| sessions — `after/plugin/sessions.lua`, `lua/plugins/possession.lua`, `lua/local-config.lua`, `.nvim.lua` | `Possession*` wiring, possession filetype **exclusions** (aerial, Codewindow, neo-tree, Outline, trouble, undotree), `plugins.tabby`, `use_session`/`use_format_on_save`                                                                                                                                                                   | grep `Possession`, the filetype                   |
| other `lua/plugins/**`                                                                                    | **dependency edges** (`dependencies = {}`) and cross-file `require("<module>")` integrations (web-devicons→heirline/tabby/neo-tree; treesitter→rainbow/textobjects/ts-context-commentstring; snacks→neo-tree/lensline/illuminate; null-ls→lsp+heirline; fzf-lua→dressing/tiny-code-action/todo-comments; comment→ts-context-commentstring) | the two greps above                               |
| `init.lua`, `lua/plugin-manager.lua`                                                                      | `USER.theme` fallback colorscheme; lazy `dev` / `install.colorscheme`                                                                                                                                                                                                                                                                      | grep name                                         |
| `lua/plugins/lsp/**`                                                                                      | LSP-ecosystem plugins are orchestrated specially                                                                                                                                                                                                                                                                                           | use `/nvim-lsp` (see `lua/plugins/lsp/AGENTS.md`) |
