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
  configuration #4](https://github.com/kevinhwang91/nvim-ufo/issues/4))
- [possession.nvim](https://github.com/jedrzejboczar/possession.nvim) Flexible
  session management for Neovim.
- [telescope-media-files](https://github.com/nvim-telescope/telescope-media-files.nvim)
  Telescope extension to preview media files using Ueberzug.
- [nvim-gomove](https://github.com/booperlv/nvim-gomove) A complete plugin for
  moving and duplicating blocks and lines, with complete fold handling,
  reindenting, and undoing in one go.
- [pantran.nvim](https://github.com/potamides/pantran.nvim) Use your favorite
  machine translation engines without having to leave your favorite editor.
- [Neogit](https://github.com/TimUntersberger/neogit) magit for neovim.

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

## Plugins installed
### Package manager
- [packer.nvim](https://github.com/wbthomason/packer.nvim), A use-package
  inspired plugin manager for Neovim. Uses native packages, supports Luarocks
  dependencies, written in Lua, allows for expressive config

### Cosmetic
- [Dressing.nvim](https://github.com/stevearc/dressing.nvim), Neovim plugin to
  improve the default vim.ui interfaces

- [nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons), Lua
  `fork` of vim-web-devicons for neovim

- [neoscroll.nvim](https://github.com/karb94/neoscroll.nvim), Smooth scrolling
  neovim plugin written in lua

- [alpha-nvim](https://github.com/goolord/alpha-nvim), A fast and highly
  customizable greeter for neovim

- [nvim-notify](https://github.com/rcarriga/nvim-notify), A fancy, configurable,
  notification manager for NeoVim

- [satellite.nvim](https://github.com/lewis6991/satellite.nvim), Decorate
  scrollbar for Neovim

- [pretty-fold.nvim](https://github.com/anuvyklack/pretty-fold.nvim), Foldtext
  customization and folded region preview in Neovim

- [incline.nvim](https://github.com/b0o/incline.nvim), Floating winbar
  statuslines for Neovim

### Autocompletion and Syntax highlighting
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig), Neovim's built-in
  language server client.
- [lsp-status.nvim](https://github.com/nvim-lua/lsp-status.nvim), Utility
  functions for getting diagnostic status and progress messages from LSP servers
- [nvim-lsp-installer](https://github.com/williamboman/nvim-lsp-installer),
  Seamlessly manage LSP servers locally with :LspInstall
- [lsp_signature](https://github.com/ray-x/lsp_signature.nvim), LSP signature
  hint as you type
- [lspkind.nvim](https://github.com/onsails/lspkind-nvim), This tiny plugin adds
  vscode-like pictograms to neovim built-in lsp
- [null-ls.nvim](https://github.com/jose-elias-alvarez/null-ls.nvim), Use Neovim
  as a language server to inject LSP diagnostics, code actions, and more via Lua
- [inc-rename.nvim](https://github.com/smjonas/inc-rename.nvim), Incremental LSP
  rename command based on Neovim's command-preview feature

- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp), A completion engine plugin
  for neovim written in Lua
- [cmp-nvim-lua](https://github.com/hrsh7th/cmp-nvim-lua), nvim-cmp source for
  neovim Lua API
- [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp), A completion engine
  plugin for neovim written in Lua
- [cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip), luasnip completion
  source for nvim-cmp
- [cmp-buffer](https://github.com/hrsh7th/cmp-buffer), nvim-cmp source for
  buffer words
- [cmp-spell](https://github.com/f3fora/cmp-spell), spell source for nvim-cmp
  based on vim's spellsuggest
- [cmp-path](https://github.com/hrsh7th/cmp-path), nvim-cmp source for
  filesystem paths
- [cmp-cmdline](https://github.com/hrsh7th/cmp-cmdline), nvim-cmp source for
  vim's cmdline

- [LuaSnip](https://github.com/L3MON4D3/LuaSnip), Snippet Engine for Neovim
  written in Lua
- [friendly-snippets](https://github.com/rafamadriz/friendly-snippets), Set of
  preconfigured snippets for different languages

- [Comment.nvim](https://github.com/numToStr/Comment.nvim), Smart and powerful
  comment plugin for neovim

- [nvim-autopairs](https://github.com/windwp/nvim-autopairs), A super powerful
  autopair for Neovim. It supports multiple characters

- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter), The
  goal of nvim-treesitter is both to provide a simple and easy way to use the
  interface for tree-sitter in Neovim and to provide some basic functionality
  such as highlighting based on it
- [nvim-ts-rainbow](https://github.com/p00f/nvim-ts-rainbow), Rainbow
  parentheses for neovim using tree-sitter
- [nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag), Use treesitter
  to autoclose and autorename html tagSupport

- [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim),
  This plugin adds indentation guides to all lines

- [mini.nvim](https://github.com/echasnovski/mini.nvim), Neovim plugin with
  collection of minimal, independent, and fast Lua modules

- [trim.nvim](https://github.com/cappyzawa/trim.nvim), This plugin trims
  trailing whitespace and lines

- [vim-hexokinase](https://github.com/RRethy/vim-hexokinase), (Neo)Vim plugin
  for asynchronously displaying the colours in the file

- [nvim-surround](https://github.com/kylechui/nvim-surround), Add/change/delete
  surrounding delimiter pairs with ease. Written with love in Lua

- [Tabular](https://github.com/godlygeek/tabular), Vim script for text filtering
  and alignment

### Project and file navigation
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim), Gaze
  deeply into unknown regions using the power of the moon
- [plenary.nvim](https://github.com/nvim-lua/plenary.nvim), All the lua
  functions I don't want to write twice
- [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim),
  fzf-native is a c port of fzf, a general-purpose command-line fuzzy finder
- [telescope-frecency.nvim](https://github.com/nvim-telescope/telescope-frecency.nvim),A
  telescope.nvim extension that offers intelligent prioritization when selecting
  files from your editing history
- [sqlite.lua](https://github.com/tami5/sqlite.lua), SQLite/LuaJIT binding for
  lua and neovim
- [telescope-hop.nvim](https://github.com/nvim-telescope/telescope-hop.nvim), An
  extension for telescope.nvim. It helps you navigate, select, and perform
  actions on results buffer with motions inspired by hop.nvim.

- [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim), Neovim plugin
  to manage the file system and other tree like structures
- [nui.nvim](https://github.com/MunifTanjim/nui.nvim), UI Component Library for
  Neovim.

- [hop.nvim](https://github.com/phaazon/hop.nvim), Hop allows you to jump
  anywhere in a document with as few keystrokes as possible

- [aerial.nvim](https://github.com/stevearc/aerial.nvim), Neovim plugin for a
  code outline window

- [trouble.nvim](https://github.com/folke/trouble.nvim), A pretty diagnostics,
  references, telescope results, quickfix and location list

- [nvim-hlslens](https://github.com/kevinhwang91/nvim-hlslens), Hlsearch Lens
  for Neovim

- [diffview.nvim](https://github.com/sindrets/diffview.nvim), Single tabpage
  interface for easily cycling through diffs for all modified files for any git
  rev

- [auto-session](https://github.com/rmagatti/auto-session), A small automated
  session manager for Neovim
- [session-lens](https://github.com/rmagatti/session-lens), A session-switcher
  extension for rmagatti/auto-session using Telescope.nvim

### Miscellaneous
- [tabby.nvim](https://github.com/nanozuki/tabby.nvim), A minimal, configurable,
  neovim style tabline. Use your nvim tabs as workspace multiplexer.

- [lualine](https://github.com/nvim-lualine/lualine.nvim), A blazing fast and
  easy to configure Neovim statusline written in Lua

- [bufdelete.nvim](https://github.com/famiu/bufdelete.nvim), Allows you to
  delete a buffer without messing up your window layout

- [FixCursorHold.nvim](https://github.com/antoinemadec/FixCursorHold.nvim), Fix
  CursorHold performance

- [todo-comments.nvim](https://github.com/folke/todo-comments.nvim), Highlight,
  list and search todo comments in your projects

- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim), Git integration
  for buffers

- [which-key.nvim](https://github.com/folke/which-key.nvim), WhichKey displays a
  popup with possible key bindings of the command you started typing

- [Hydra.nvim](https://github.com/anuvyklack/hydra.nvim), Bind a bunch of key
  bindings together

- [undotree](https://github.com/mbbill/undotree), The undo history visualizer
  for VIM

- [quick-scope](https://github.com/unblevable/quick-scope), Lightning fast
  left-right movement in Vim

- [stabilize.nvim](https://github.com/luukvbaal/stabilize.nvim), Neovim plugin
  to stabilize window open/close events

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
