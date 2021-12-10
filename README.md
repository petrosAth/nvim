# Neovim config files
My ["personal"](#sources) Neovim configuration for Windows.
Still a work in progress.


## TODO
- [ ] Try treesitter folding - reddit [post](https://www.reddit.com/r/neovim/comments/psl8rq/sexy_folds/)
- [ ] Migrate to WSL
- [ ] Rethink/research the folder structure
- [ ] Session management [persistence.nvim](#sm1) [neovim-session-manager](#sm2)
- [ ] Plugin reloading
- [ ] Organize my custom highlight groups
- [ ] Revisit FileType and BufEnter autocommands
- [ ] Setup autosave
- [ ] Add comment string snippets and telescope finder
- [ ] Add ftplugin/
- [ ] Add Spell/


## Reminders
- [trouble.nvim zo/zc implementation](https://github.com/folke/trouble.nvim/pull/117)
- nvim-lspconfig Windows path bugs [1](https://github.com/neovim/nvim-lspconfig/issues/1168), [2](https://github.com/neovim/nvim-lspconfig/issues/1266)


## Plugins
### Plugins used
| Plugin | Description |
| --- | --- |
*Big list that I will add at some point*


### Plugins for installation
| Plugin | Description |
| --- | --- |
| [nvim-lightbulb](https://github.com/kosayoda/nvim-lightbulb) | VSCode 💡 for neovim's built-in LSP. |
| [nvim-code-action-menu](https://github.com/weilbith/nvim-code-action-menu) | Pop-up menu for code actions to show meta-information and diff preview. |
| [tele-tabby.nvim](https://github.com/TC72/telescope-tele-tabby.nvim) | A telescope extension to switch tabs. |
| [nvim-hlslens](https://github.com/kevinhwang91/nvim-hlslens) | Hlsearch Lens for Neovim. |
| [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) | ✅ Highlight, list and search todo comments in your projects. |
| [nvim-neoclip.lua](https://github.com/AckslD/nvim-neoclip.lua) | Clipboard manager neovim plugin with telescope integration. |
| [telescope-hop.nvim](https://github.com/nvim-telescope/telescope-hop.nvim) | (Teles-)Hopping to the moon. |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git integration for buffers. |
| [vim-surround](https://github.com/tpope/vim-surround) | Delete/change/add parentheses/quotes/XML-tags/much more with ease. |
| [vim-easy-align](https://github.com/junegunn/vim-easy-align) | 🌻 A Vim alignment plugin. |
| Themes | --- |
| [dracula.nvim](https://github.com/Mofiqul/dracula.nvim) | Dracula colorscheme for neovim written in Lua. |
| [tokyonight.nvim](https://github.com/folke/tokyonight.nvim) | 🏙 A clean, dark Neovim theme written in Lua, with support for lsp, treesitter and lots of plugins. Includes additional themes for Kitty, Alacritty, iTerm and Fish. |
| [nightfox.nvim](https://github.com/edeneast/nightfox.nvim) | 🦊A soft dark, fully customizable (Neo)Vim theme, with support for lsp, treesitter and a variety of plugins. |
| [nord.nvim](https://github.com/shaunsingh/nord.nvim) | Neovim theme based off of the Nord Color Palette, written in lua with tree sitter support. |
| [nvim-solarized-lua](https://github.com/ishan9299/nvim-solarized-lua) | solarized colorscheme in lua for nvim 0.5. |


### Plugins watch list
| Plugin | Description |
| --- | --- |
| [awesome-neovim](https://github.com/rockerBOO/awesome-neovim) |  Collections of awesome neovim plugins. |
| --- | --- |
| [Fern.vim](https://github.com/lambdalisue/fern.vim) | General purpose asynchronous tree viewer written in Pure Vim script. |
| [lir.nvim](https://github.com/tamago324/lir.nvim) | 🚪 A simple file explorer. |
| [formatter.nvim](https://github.com/mhartington/formatter.nvim) | A format runner for neovim, written in lua. |
| <a name=sm1></a>[persistence.nvim](https://github.com/folke/persistence.nvim) | Simple session management for Neovim. |
| <a name=sm2></a>[neovim-session-manager](https://github.com/Shatur/neovim-session-manager) | A simple wrapper around :mksession |
| [vim-choosewin](https://github.com/t9md/vim-choosewin) | Land on window you chose like tmux's 'display-pane'. |
| [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) | A neovim lua plugin to help easily manage multiple terminal windows. |
| Treesitter | --- |
| [nvim-ts-context-commentstring](https://github.com/JoosepAlviste/nvim-ts-context-commentstring) | Neovim treesitter plugin for setting the commentstring based on the cursor location in a file. |
| Git | --- |
| [Neogit](https://github.com/TimUntersberger/neogit) | magit for neovim. |
| [Diffview.nvim](https://github.com/sindrets/diffview.nvim) | Single tabpage interface for easily cycling through diffs for all modified files for any git rev. |
| [lazygit](https://github.com/jesseduffield/lazygit) | simple terminal UI for git commands. |
| Debugging | --- |
| [nvim-dap](https://github.com/mfussenegger/nvim-dap) | Debug Adapter Protocol client implementation for Neovim. |
| [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui) | A UI for nvim-dap. |
| [DAPInstall](https://github.com/Pocco81/DAPInstall.nvim) | A NeoVim plugin for managing several debuggers for Nvim-dap. |
| [calltree.nvim](https://github.com/ldelossa/calltree.nvim) | Neovim's missing call-hierarchy UI. |
| [vimspector](https://github.com/puremourning/vimspector) | vimspector - A multi-language debugging system for Vim. |

## <a name="sources"></a>Sources
- Heavily inspired from [Neelfrost](https://github.com/Neelfrost/dotfiles), a lot of times mercilessly copy pasting especially at the beggining.
- [Neil Sabde](https://github.com/VapourNvim/VapourNvim) was extremely helpful when I first dove in Vim/Neovim customization world especially with his [Neovim Lua From Scratch](https://www.youtube.com/playlist?list=PLPDVgSbOnt7LXQ8DTzu37UwCpA0elyD0V) Youtube series.
- [Getting started using Lua in Neovim](https://github.com/nanotee/nvim-lua-guide)
- [tjdevries](https://github.com/tjdevries/config_manager/tree/master/xdg_config/nvim)
- [NvChad](https://github.com/NvChad/NvChad)
- [williamboman](https://github.com/williamboman/nvim-config)
- [LunarVim](https://github.com/LunarVim/LunarVim)
- [doom-nvim](https://github.com/NTBBloodbath/doom-nvim)
