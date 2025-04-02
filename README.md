# Neovim config files

My ["personal"](#sources) Neovim configuration. Always a work in progress.

## To-do

- [ ] Migrate to [nvim-ufo](https://github.com/kevinhwang91/nvim-ufo) for folds
      using lsp
- [ ] Break lsp servers' config in separate files.
      [on_attach ref github](https://github.com/pynappo/dotfiles/blob/f0398c969c996a0be2d37f6dcb0ffd3300c8e46d/.config/nvim/lua/pynappo/plugins/lsp.lua#L55-L62)
      [on_attach ref reddit](https://www.reddit.com/r/neovim/comments/10ar5ut/trying_to_extend_each_servers_on_attach_with_a/)
- [ ] Add
      [lsp codelens](https://github.com/tjdevries/config_manager/blob/66d5262e1d142bfde5ebc19ba120ae86cb16d1d9/xdg_config/nvim/lua/tj/lsp/codelens.lua)
- [ ] Add
      [snippet action key binding](https://alpha2phi.medium.com/neovim-for-beginners-snippets-using-lua-11e46c4d417c)
- [ ] Improve code annotation with [neogen](https://github.com/danymat/neogen)
- [ ] Add [refactoring.nvim](https://github.com/ThePrimeagen/refactoring.nvim)
- [ ] Add debugger

## Plugins watch list

- [conform.nvim](https://github.com/stevearc/conform.nvim) Wait for
  [Issue](https://github.com/mfussenegger/nvim-lint/issues/366)
- [nvim-lint](https://github.com/mfussenegger/nvim-lint) Wait for
  [Issue](https://github.com/mfussenegger/nvim-lint/issues/366)
- [edgy.nvim](https://github.com/folke/edgy.nvim) Easily create and manage
  predefined window layouts, bringing a new edge to your workflow
- [persistence.nvim](https://github.com/folke/persistence.nvim) Simple session
  management for Neovim
- [smart-splits.nvim](`https://github.com/mrjones2014/smart-splits.nvim`) Smart,
  seamless, directional navigation and resizing of Neovim + terminal multiplexer
  splits. Supports tmux, Wezterm, and Kitty. Think about splits in terms of
  "up/down/left/right".
- [colorful-winsep](`https://github.com/nvim-zh/colorful-winsep.nvim`) Make your
  nvim window separators colorful
- [obsidian.nvim](https://github.com/epwalsh/obsidian.nvim) Neovim plugin for
  Obsidian, written in Lua
- [vim-dadbod](https://github.com/tpope/vim-dadbod) Modern database interface
  for Vim
- [vim-dadbod-ui](https://github.com/kristijanhusak/vim-dadbod-ui) Simple UI for
  vim-dadbod
- [symbols.nvim](https://github.com/oskarrrrrrr/symbols.nvim) Code navigation
  sidebar for Neovim.
- [codecompanion.nvim](https://github.com/olimorris/codecompanion.nvim)
  AI-powered coding, seamlessly in Neovim

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
