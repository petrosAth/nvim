# Neovim config files

My ["personal"](#sources) Neovim configuration for Windows.
Still a work in progress.

## TODO

- [x] lualine root folder (.)
- [x] Add window number in lualine
- [x] Add gitsigns in lualine
- [x] Try treesitter folding - reddit [post](https://www.reddit.com/r/neovim/comments/psl8rq/sexy_folds/)
- [x] Revisit FileType and BufEnter autocommands
- [x] Add comment string snippets and telescope finder
- [x] :h mark-motions
- [x] Migrate to WSL under windows
- [x] Organize my custom highlight groups
- [x] Revisit nvim-cmp menu
- [x] lazyload everything possible
- [x] Add Session management
- [x] Replace [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) with [tabby.nvim](https://github.com/nanozuki/tabby.nvim)
- [x] Floating status lines [Incline.nvim](https://github.com/b0o/incline.nvim)
- [x] Command preview for lsp rename [inc-rename.nvim](https://github.com/smjonas/inc-rename.nvim)
- [ ] Add debugger
- [ ] Add dracula theme
- [ ] Add Solarized theme

## Reminders

- [trouble.nvim zo/zc implementation](https://github.com/folke/trouble.nvim/pull/117)

## Plugins watch list

- [nvim-ufo](https://github.com/kevinhwang91/nvim-ufo) Not UFO in the sky, but
  an ultra fold in Neovim. (Wait for [How can I make it look equal to its
  configuration #4](https://github.com/kevinhwang91/nvim-ufo/issues/4)
- [telescope-media-files](https://github.com/nvim-telescope/telescope-media-files.nvim)
  Telescope extension to preview media files using Ueberzug.
- [nvim-gomove](https://github.com/booperlv/nvim-gomove) A complete plugin for
  moving and duplicating blocks and lines, with complete fold handling,
  reindenting, and undoing in one go.
- [mini.align](https://github.com/echasnovski/mini.nvim#mini.align) Align text
  interactively (with or without instant preview).
- [pantran.nvim](https://github.com/potamides/pantran.nvim) Use your favorite
  machine translation engines without having to leave your favorite editor.
- [obsidian.nvim](https://github.com/epwalsh/obsidian.nvim) Neovim plugin for
  Obsidian, written in Lua
- [Neogit](https://github.com/TimUntersberger/neogit) magit for neovim.
- [vim-dadbod](https://github.com/tpope/vim-dadbod) Modern database interface
  for Vim
- [vim-dadbod-ui](https://github.com/kristijanhusak/vim-dadbod-ui) Simple UI for
  vim-dadbod

### Themes

- [dracula.nvim](https://github.com/Mofiqul/dracula.nvim) Dracula colorscheme
  for neovim written in Lua.
- [nvim-solarized-lua](https://github.com/ishan9299/nvim-solarized-lua)
  Solarized colorscheme in lua for nvim 0.5.

### Treesitter

- [nvim-tree-docs](https://github.com/nvim-treesitter/nvim-tree-docs) Code
  documentation built with treesitter
- [nvim-ts-context-commentstring](https://github.com/JoosepAlviste/nvim-ts-context-commentstring)
  Neovim treesitter plugin for setting the commentstring based on the cursor
  location in a file. ### Git

### Debugging

- [nvim-dap](https://github.com/mfussenegger/nvim-dap) Debug Adapter Protocol
  client implementation for Neovim.
- [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui) A UI for nvim-dap.
- [nvim-dap-virtual-text](https://github.com/theHamsta/nvim-dap-virtual-text)
  This plugin adds virtual text support to nvim-dap.
- [DAPInstall](https://github.com/Pocco81/DAPInstall.nvim) A NeoVim plugin for
  managing several debuggers for Nvim-dap.
- [calltree.nvim](https://github.com/ldelossa/calltree.nvim) Neovim's missing
  call-hierarchy UI.
- [vimspector](https://github.com/puremourning/vimspector) vimspector - A
  multi-language debugging system for Vim.

### ltex language server

- [LTeX Language Server](https://github.com/valentjn/ltex-ls) LTeX Language
  Server for LanguageTool with support for LaTeX , Markdown, and others.
- [grammar-guard.nvim](https://github.com/brymer-meneses/grammar-guard.nvim)
  Grammar Guard is a Neovim plugin that checks your grammar as you write your
  LaTeX, Markdown or plain text document.

## Plugins collections

- [awesome-neovim](https://github.com/rockerBOO/awesome-neovim) Collections of
  awesome neovim plugins
- [neovimcraft.com](https://neovimcraft.com/) Website that makes it easy to find
  neovim plugins

## <a name="sources"></a>Sources

- Heavily inspired from [Neelfrost](https://github.com/Neelfrost/dotfiles), a
  lot of times mercilessly copy pasting especially at the beggining.
- [Neil Sabde](https://github.com/VapourNvim/VapourNvim) was extremely helpful
  when I first dove in Vim/Neovim customization world with his [Neovim Lua From
  Scratch](https://www.youtube.com/playlist?list=PLPDVgSbOnt7LXQ8DTzu37UwCpA0elyD0V)
  Youtube series.
- [Getting started using Lua in Neovim](https://github.com/nanotee/nvim-lua-guide)
- [tjdevries](https://github.com/tjdevries/config_manager/tree/master/xdg_config/nvim)
- [NvChad](https://github.com/NvChad/NvChad)
- [williamboman](https://github.com/williamboman/nvim-config)
- [folke](https://github.com/folke/dot/tree/master/config/nvim)
- [LunarVim](https://github.com/LunarVim/LunarVim)
- [doom-nvim](https://github.com/NTBBloodbath/doom-nvim)
