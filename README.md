# Neovim config files

My ["personal"](#sources) Neovim configuration. Always a work in progress.

## To-do

- [x] Replace packer.nvim with [lazy.nvim](https://github.com/folke/lazy.nvim)
  - [x] Change packer.nvim mappings to lazy.nvim
  - [x] Change packer.nvim to lazy.nvim on dashboard
  - [x] Configure lazy.nvim icons and highlights
  - [x] Add "lazy" filetype in status-bars/tab-line tables
  - [x] Add "lazy.nvim" component in status-line
- [x] Configure statuscolumn
- [ ] Migrate to [nvim-ufo](https://github.com/kevinhwang91/nvim-ufo) for folds
      using lsp
- [ ] Add lsp
      [codelens](https://github.com/tjdevries/config_manager/blob/66d5262e1d142bfde5ebc19ba120ae86cb16d1d9/xdg_config/nvim/lua/tj/lsp/codelens.lua)
- [ ] Add lsp
      [inlay hints](https://github.com/tjdevries/config_manager/blob/66d5262e1d142bfde5ebc19ba120ae86cb16d1d9/xdg_config/nvim/lua/tj/lsp/inlay.lua)
- [ ] Add
      [snippet action key binding](https://alpha2phi.medium.com/neovim-for-beginners-snippets-using-lua-11e46c4d417c)
- [ ] Improve code annotation with [neogen](https://github.com/danymat/neogen)
- [ ] Add [refactoring.nvim](https://github.com/ThePrimeagen/refactoring.nvim)
- [ ] Add debugger
- [ ] Simplify mappings since which-key can pick up "desc" field
- [ ] (Maybe) Rework nord theme based on
      [16base theme](https://alpha2phi.medium.com/neovim-for-beginners-color-scheme-e880762c6cc6)
- [ ] Add Dracula theme
- [ ] Add Solarized theme

## Reminders

- lsp syntax highlighting (:h lsp-semantic_tokens )
- [trouble.nvim zo/zc implementation](https://github.com/folke/trouble.nvim/pull/117)

## Plugins watch list

- [nvim-nonicons](https://github.com/yamatsum/nvim-nonicons) Icon set using
  Nonicons for Neovim plugins and settings.
- [nvim-ufo](https://github.com/kevinhwang91/nvim-ufo) Not UFO in the sky, but
  an ultra fold in Neovim. (Wait for
  [How can I make it look equal to its configuration #4](https://github.com/kevinhwang91/nvim-ufo/issues/4))
- [mini.align](https://github.com/echasnovski/mini.nvim#mini.align) Align text
  interactively (with or without instant preview).
- [obsidian.nvim](https://github.com/epwalsh/obsidian.nvim) Neovim plugin for
  Obsidian, written in Lua
- [vim-dadbod](https://github.com/tpope/vim-dadbod) Modern database interface
  for Vim
- [vim-dadbod-ui](https://github.com/kristijanhusak/vim-dadbod-ui) Simple UI for
  vim-dadbod
- [nvim-ts-context-commentstring](https://github.com/JoosepAlviste/nvim-ts-context-commentstring)
  Neovim nvim-treesitter plugin for setting the comment string based on the
  cursor location in a file.
- [Telescope-media-files](https://github.com/nvim-telescope/telescope-media-files.nvim)
  Telescope extension to preview media files using Ueberzug.
- [Neogit](https://github.com/TimUntersberger/neogit) Magit for Neovim.
- [pantran.nvim](https://github.com/potamides/pantran.nvim) Use your favorite
  machine translation engines without having to leave your favorite editor.

### Themes

- [dracula.nvim](https://github.com/Mofiqul/dracula.nvim) Dracula color scheme
  for Neovim written in Lua.
- [nvim-solarized-lua](https://github.com/ishan9299/nvim-solarized-lua)
  Solarized color scheme in Lua for nvim 0.5.

### Debugging

- [nvim-dap](https://github.com/mfussenegger/nvim-dap) Debug Adapter Protocol
  client implementation for Neovim.
- [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui) A UI for nvim-dap.
- [nvim-dap-virtual-text](https://github.com/theHamsta/nvim-dap-virtual-text)
  This plugin adds virtual text support to nvim-dap.
- [DAPInstall](https://github.com/Pocco81/DAPInstall.nvim) A Neovim plugin for
  managing several debuggers for nvim-dap.
- [calltree.nvim](https://github.com/ldelossa/calltree.nvim) Neovim's missing
  call-hierarchy UI.

## Plugins collections

- [awesome-neovim](https://github.com/rockerBOO/awesome-neovim) Collections of
  awesome Neovim plugins
- [neovimcraft.com](https://neovimcraft.com/) Website that makes it easy to find
  Neovim plugins

## <a name="sources"></a>Sources

- Heavily inspired from [Neelfrost](https://github.com/Neelfrost/dotfiles), a
  lot of times mercilessly copy-pasting especially at the beginning.
- [Neil Sabde](https://github.com/VapourNvim/VapourNvim) was extremely helpful
  when I first dove in Vim/Neovim customization world with his
  [Neovim Lua From Scratch](https://www.youtube.com/playlist?list=PLPDVgSbOnt7LXQ8DTzu37UwCpA0elyD0V)
  YouTube series.
- [Getting started using Lua in Neovim](https://github.com/nanotee/nvim-lua-guide)
- [tjdevries](https://github.com/tjdevries/config_manager/tree/master/xdg_config/nvim)
- [NvChad](https://github.com/NvChad/NvChad)
- [williamboman](https://github.com/williamboman/nvim-config)
- [folke](https://github.com/folke/dot/tree/master/config/nvim)
- [LunarVim](https://github.com/LunarVim/LunarVim)
- [doom-nvim](https://github.com/NTBBloodbath/doom-nvim)
