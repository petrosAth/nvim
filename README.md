# Neovim config

My ["personal"](#sources) Neovim configuration. Always a work in progress.

## Requirements

**Neovim 0.12+** is required (the config uses the treesitter main-branch
rewrite).

The following tools must be available on your `PATH`:

| Dependency                                | Purpose                             |
| ----------------------------------------- | ----------------------------------- |
| `git`                                     | Plugin installation via lazy.nvim   |
| `make`                                    | Build step for telescope-fzf-native |
| `ripgrep` (`rg`)                          | Live grep inside Telescope          |
| `fd`                                      | File finding inside Telescope       |
| A [Nerd Font](https://www.nerdfonts.com/) | Icons and UI symbols throughout     |

**Optional** — only needed for specific language support. Mason handles LSP
server installation automatically.

| Dependency | Used for                        |
| ---------- | ------------------------------- |
| Node.js    | JS/TS/JSON/CSS/HTML LSP servers |
| Python     | `pyright`, `ruff`               |
| PHP tools  | `intelephense`, `phpcs`, etc.   |

## Installation

1. Clone this repo:
   ```sh
   git clone https://github.com/<your-username>/nvim ~/.config/nvim
   ```
2. Launch Neovim. _lazy.nvim_ will bootstrap itself and install all plugins
   automatically.
3. Restart Neovim. _mason.nvim_ will install LSP servers and tools
   automatically.
4. Install a [Nerd Font](https://www.nerdfonts.com/) and configure your terminal
   to use it (required for icons to render correctly).

## To-do

- [ ] Migrate to [nvim-ufo](https://github.com/kevinhwang91/nvim-ufo) for folds
      using LSP
- [ ] Migrate to [fzf-lua](https://github.com/ibhagwan/fzf-lua) as a telescope
      replacement
- [ ] Migrate to [persistence.nvim](https://github.com/folke/persistence.nvim)
      over [possession.nvim](https://github.com/jedrzejboczar/possession.nvim)
- [ ] Migrate to [conform.nvim](https://github.com/stevearc/conform.nvim) /
      [nvim-lint](https://github.com/mfussenegger/nvim-lint) from
      [none-ls](https://github.com/nvimtools/none-ls.nvim)
- [ ] Break LSP server configs into separate files
      ([on_attach ref — GitHub](https://github.com/pynappo/dotfiles/blob/f0398c969c996a0be2d37f6dcb0ffd3300c8e46d/.config/nvim/lua/pynappo/plugins/lsp.lua#L55-L62),
      [on_attach ref — Reddit](https://www.reddit.com/r/neovim/comments/10ar5ut/trying_to_extend_each_servers_on_attach_with_a/))
- [ ] Add debugger: [nvim-dap](https://github.com/mfussenegger/nvim-dap),
      [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui),
      [nvim-dap-virtual-text](https://github.com/theHamsta/nvim-dap-virtual-text)

## Plugins watch list

- [persistence.nvim](https://github.com/folke/persistence.nvim) — Simple session
  management
- [obsidian.nvim](https://github.com/epwalsh/obsidian.nvim) — Obsidian
  integration
- [codecompanion.nvim](https://github.com/olimorris/codecompanion.nvim) —
  AI-powered coding
- [overseer.nvim](https://github.com/stevearc/overseer.nvim) — Task runner and
  job management

## Plugins collections

- [awesome-neovim](https://github.com/rockerBOO/awesome-neovim)
- [neovimcraft.com](https://neovimcraft.com/)

## <a name="sources"></a>Sources

- Heavily inspired by [Neelfrost](https://github.com/Neelfrost/dotfiles) — often
  mercilessly copy-pasting, especially at the beginning.
- [Neil Sabde](https://github.com/VapourNvim/VapourNvim) and his
  [Neovim Lua From Scratch](https://www.youtube.com/playlist?list=PLPDVgSbOnt7LXQ8DTzu37UwCpA0elyD0V)
  series were invaluable when I first dove into Vim/Neovim customization.
- [Getting started using Lua in Neovim](https://github.com/nanotee/nvim-lua-guide)
- [tjdevries](https://github.com/tjdevries/config_manager/tree/master/xdg_config/nvim),
  [NvChad](https://github.com/NvChad/NvChad),
  [williamboman](https://github.com/williamboman/nvim-config),
  [folke](https://github.com/folke/dot/tree/master/config/nvim),
  [LunarVim](https://github.com/LunarVim/LunarVim),
  [doom-nvim](https://github.com/NTBBloodbath/doom-nvim)
