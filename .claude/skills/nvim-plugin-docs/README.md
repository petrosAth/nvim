# nvim-plugin-docs

Investigates a Neovim plugin's documentation through a 3-tier priority chain.

## Invocation

```
/nvim-plugin-docs <author/repo>
```

The `author/repo` argument is required (e.g. `folke/flash.nvim`). Also accepts a bare repo name or `require` module name
when the author is unknown.

## Priority chain

1. **Context7** — `resolve-library-id` + `query-docs`. Fastest; use known-good IDs for `/neovim/neovim`,
   `/folke/lazy.nvim`, `/neovim/nvim-lspconfig`, `/rebelot/heirline.nvim` without resolving.
2. **Local lazy clone** — `~/.local/share/nvim/lazy/<repo>/`. The exact installed version (matches `lazy-lock.json`).
   Reads `doc/*.txt` → `README.md` → `lua/` source in that order. **If the clone exists it is authoritative and stops
   the chain** — it is the same repo as tier 3 checked out at the pinned commit, so going online would only re-fetch
   identical docs.
3. **Online GitHub repo** — GitHub MCP `get_file_contents` / `search_repositories`, WebFetch fallback. Reached **only
   when the plugin is not installed locally** (a new plugin not yet added).

## What it returns

- The answer to your question (setup options, API, keymaps, lazy-load events).
- Which tier the answer came from.
- The exact `require("<module>")` name (module name ≠ repo name — always stated explicitly to avoid load errors).

## Examples

```
/nvim-plugin-docs folke/flash.nvim
```

```
/nvim-plugin-docs numToStr/Comment.nvim
What is the require module name and how do I configure it?
```

```
/nvim-plugin-docs rebelot/heirline.nvim
What lazy-load events does it support?
```
