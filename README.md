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
- [x] Migrate to WSL
- [x] Organize my custom highlight groups
- [x] Revisit nvim-cmp menu
- [x] lazyload everything possible
- [ ] Add [dictionaries](https://github.com/echasnovski/nvim/blob/0e185055d4a45f079795a6836a821dc8dbbfcee9/lua/ec/settings.lua#L73-L77)
- [ ] Polish themer's dracula theme
- [ ] Add Solarized theme
- [x] Add Session management
- [ ] Add debugger
- [ ] Replace bufferline with lualine [indicators](https://github.com/nvim-lualine/lualine.nvim/issues/414)
- [ ] Floating status lines [Incline.nvim](https://github.com/b0o/incline.nvim)

## Reminders
- [trouble.nvim zo/zc implementation](https://github.com/folke/trouble.nvim/pull/117)

## Plugins used
*Big list that I will add at some point*

## Plugins watch list
- [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)
Neovim plugin to manage the file system and other tree like structures.
- [persistence.nvim](https://github.com/folke/persistence.nvim)
Simple session management for Neovim.
- [neovim-session-manager](https://github.com/Shatur/neovim-session-manager)
A simple wrapper around :mksession.
- [AutoSave.nvim](https://github.com/Pocco81/AutoSave.nvim)
A NeoVim plugin for saving your work before the world collapses or you type :qa!
- [nvim-neoclip.lua](https://github.com/AckslD/nvim-neoclip.lua)
Clipboard manager neovim plugin with telescope integration.
- [vim-easy-align](https://github.com/junegunn/vim-easy-align)
A Vim alignment plugin.
- [telescope-media-files](https://github.com/nvim-telescope/telescope-media-files.nvim)
Telescope extension to preview media files using Ueberzug.
- [nvim-bqf](https://github.com/kevinhwang91/nvim-bqf)
Better quickfix window in Neovim, polish old quickfix window.
- [diaglist.nvim](https://github.com/onsails/diaglist.nvim)
Live render workspace diagnostics in quickfix with current buf errors on top,
buffer diagnostics in loclist
- [reach.nvim](https://github.com/toppair/reach.nvim)
Buffer, mark, tabpage, colorscheme switcher for Neovim
- [cinnamon.nvim](https://github.com/declancm/cinnamon.nvim)
Smooth scrolling for ANY movement command. A Neovim plugin written in Lua.

### Themes
- [dracula.nvim](https://github.com/Mofiqul/dracula.nvim)
Dracula colorscheme for neovim written in Lua.
- [nvim-solarized-lua](https://github.com/ishan9299/nvim-solarized-lua)
Solarized colorscheme in lua for nvim 0.5.

### Treesitter
- [nvim-tree-docs](https://github.com/nvim-treesitter/nvim-tree-docs)
Code documentation built with treesitter
- [nvim-ts-context-commentstring](https://github.com/JoosepAlviste/nvim-ts-context-commentstring)
Neovim treesitter plugin for setting the commentstring based on the cursor
location in a file. ### Git
- [Neogit](https://github.com/TimUntersberger/neogit)
magit for neovim.
- [lazygit](https://github.com/jesseduffield/lazygit)
simple terminal UI for git commands.

### Debugging
- [nvim-dap](https://github.com/mfussenegger/nvim-dap)
Debug Adapter Protocol client implementation for Neovim.
- [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui)
A UI for nvim-dap.
- [nvim-dap-virtual-text](https://github.com/theHamsta/nvim-dap-virtual-text)
This plugin adds virtual text support to nvim-dap.
- [DAPInstall](https://github.com/Pocco81/DAPInstall.nvim)
A NeoVim plugin for managing several debuggers for Nvim-dap.
- [calltree.nvim](https://github.com/ldelossa/calltree.nvim)
Neovim's missing call-hierarchy UI.
- [vimspector](https://github.com/puremourning/vimspector)
vimspector - A multi-language debugging system for Vim.

### ltex language server
- [LTeX Language Server](https://github.com/valentjn/ltex-ls)
LTeX Language Server for LanguageTool with support for LaTeX , Markdown, and
others.
- [grammar-guard.nvim](https://github.com/brymer-meneses/grammar-guard.nvim)
Grammar Guard is a Neovim plugin that checks your grammar as you write your
LaTeX, Markdown or plain text document.

## Plugins collections
- [awesome-neovim](https://github.com/rockerBOO/awesome-neovim)
Collections of awesome neovim plugins
- [neovimcraft.com](https://neovimcraft.com/)
Website that makes it easy to find neovim plugins

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
