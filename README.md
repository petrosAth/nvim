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
- [ ] Research the folder structure
- [ ] Revisit nvim-cmp menu
- [ ] lazyload everything possible
- [ ] Organize my custom highlight groups
- [ ] Play with [LunarVim transparent window config](https://github.com/LunarVim/LunarVim/blob/a79de08d40f08e9a3b753175df11283ed737067c/lua/lvim/config/settings.lua#L62-L78)
- [ ] Add debugger
- [ ] Revisit Cokeline when side offset gets introduced
- [ ] Use pcalls in LSP configs
- [ ] Enable treesitter in autopairs
- [ ] Session management [persistence.nvim](#sm1) [neovim-session-manager](#sm2)

## Reminders
- [trouble.nvim zo/zc implementation](https://github.com/folke/trouble.nvim/pull/117)

## Plugins
### Plugins used
*Big list that I will add at some point*

### Plugins for installation
| Plugin                                                                                          | Description |
| ----------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [null-ls.nvim](https://github.com/jose-elias-alvarez/null-ls.nvim)                              | Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.                                                                        |
| Themes                                                                                          |
| [dracula.nvim](https://github.com/Mofiqul/dracula.nvim)                                         | Dracula colorscheme for neovim written in Lua.                                                                                                                    |
| [tokyonight.nvim](https://github.com/folke/tokyonight.nvim)                                     | A clean, dark Neovim theme written in Lua, with support for lsp, treesitter and lots of plugins. Includes additional themes for Kitty, Alacritty, iTerm and Fish. |
| [nightfox.nvim](https://github.com/edeneast/nightfox.nvim)                                      | A soft dark, fully customizable (Neo)Vim theme, with support for lsp, treesitter and a variety of plugins.                                                        |
| [nord.nvim](https://github.com/shaunsingh/nord.nvim)                                            | Neovim theme based off of the Nord Color Palette, written in lua with tree sitter support.                                                                        |
| [nvim-solarized-lua](https://github.com/ishan9299/nvim-solarized-lua)                           | solarized colorscheme in lua for nvim 0.5.                                                                                                                        |

### Plugins watch list
| Plugin                                                                                          | Description                                                                                                                                                       |
| ----------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [formatter.nvim](https://github.com/mhartington/formatter.nvim)                                 | A format runner for neovim, written in lua.                                                                                                                       |
| [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)                                 | Neovim plugin to manage the file system and other tree like structures.                                                                                           |
| <a name=sm1></a>[persistence.nvim](https://github.com/folke/persistence.nvim)                   | Simple session management for Neovim.                                                                                                                             |
| <a name=sm2></a>[neovim-session-manager](https://github.com/Shatur/neovim-session-manager)      | A simple wrapper around :mksession                                                                                                                                |
| [AutoSave.nvim](https://github.com/Pocco81/AutoSave.nvim)                                       | 🦴 A NeoVim plugin for saving your work before the world collapses or you type :qa!                                                                               |
| [nvim-neoclip.lua](https://github.com/AckslD/nvim-neoclip.lua)                                  | Clipboard manager neovim plugin with telescope integration.                                                                                                       |
| [vim-easy-align](https://github.com/junegunn/vim-easy-align)                                    | A Vim alignment plugin.                                                                                                                                           |
| [telescope-media-files](https://github.com/nvim-telescope/telescope-media-files.nvim)           | Telescope extension to preview media files using Ueberzug.                                                                                                        |
| [nvim-bqf](https://github.com/kevinhwang91/nvim-bqf)                                            | Better quickfix window in Neovim, polish old quickfix window.                                                                                                     |
| [diaglist.nvim](https://github.com/onsails/diaglist.nvim)                                       | Live render workspace diagnostics in quickfix with current buf errors on top, buffer diagnostics in loclist                                                       |
| Aesthetics                                                                                      |
| [dressing](https://github.com/stevearc/dressing.nvim)                                           | Neovim plugin to improve the default vim.ui interfaces                                                                                                            |
| Treesitter                                                                                      |
| [nvim-tree-docs](https://github.com/nvim-treesitter/nvim-tree-docs)                             | Code documentation built with treesitter                                                                                                                          |
| [nvim-ts-context-commentstring](https://github.com/JoosepAlviste/nvim-ts-context-commentstring) | Neovim treesitter plugin for setting the commentstring based on the cursor location in a file.                                                                    |
| Git                                                                                             |
| [Neogit](https://github.com/TimUntersberger/neogit)                                             | magit for neovim.                                                                                                                                                 |
| [lazygit](https://github.com/jesseduffield/lazygit)                                             | simple terminal UI for git commands.                                                                                                                              |
| Debugging                                                                                       |
| [nvim-dap](https://github.com/mfussenegger/nvim-dap)                                            | Debug Adapter Protocol client implementation for Neovim.                                                                                                          |
| [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui)                                          | A UI for nvim-dap.                                                                                                                                                |
| [DAPInstall](https://github.com/Pocco81/DAPInstall.nvim)                                        | A NeoVim plugin for managing several debuggers for Nvim-dap.                                                                                                      |
| [calltree.nvim](https://github.com/ldelossa/calltree.nvim)                                      | Neovim's missing call-hierarchy UI.                                                                                                                               |
| [vimspector](https://github.com/puremourning/vimspector)                                        | vimspector - A multi-language debugging system for Vim.                                                                                                           |
| ltex ls                                                                                         |
| [LTeX Language Server](https://github.com/valentjn/ltex-ls)                                     | LTeX Language Server: LSP language server for LanguageTool with support for LaTeX , Markdown, and others.                                                         |
| [grammar-guard.nvim](https://github.com/brymer-meneses/grammar-guard.nvim)                      | Grammar Guard is a Neovim plugin that checks your grammar as you write your LaTeX, Markdown or plain text document.                                               |

## Plugin collections
[awesome-neovim](https://github.com/rockerBOO/awesome-neovim) - Collections of awesome neovim plugins.
[neovimcraft.com](https://neovimcraft.com/)

## <a name="sources"></a>Sources
- Heavily inspired from [Neelfrost](https://github.com/Neelfrost/dotfiles), a lot of times mercilessly copy pasting especially at the beggining.
- [Neil Sabde](https://github.com/VapourNvim/VapourNvim) was extremely helpful when I first dove in Vim/Neovim customization world with his [Neovim Lua From Scratch](https://www.youtube.com/playlist?list=PLPDVgSbOnt7LXQ8DTzu37UwCpA0elyD0V) Youtube series.
- [Getting started using Lua in Neovim](https://github.com/nanotee/nvim-lua-guide)
- [tjdevries](https://github.com/tjdevries/config_manager/tree/master/xdg_config/nvim)
- [NvChad](https://github.com/NvChad/NvChad)
- [williamboman](https://github.com/williamboman/nvim-config)
- [folke](https://github.com/folke/dot/tree/master/config/nvim)
- [LunarVim](https://github.com/LunarVim/LunarVim)
- [doom-nvim](https://github.com/NTBBloodbath/doom-nvim)
