vim.cmd([[
    augroup PACKER_CURSORLINE
        autocmd!
        autocmd FileType packer lua vim.opt.cursorline = true
    augroup END
]])

local fn = vim.fn
local install_path = PACKER_PATH .. "/start/packer.nvim"
local i = require("styling").icons
local b = require("styling").borders.default
local bs = require("styling").borders.single

-- Automatically install packer
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    print("Installing packer close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end

-- Use a protected call so we don't error out on first use
local packer_loaded, packer = pcall(require, "packer")
if not packer_loaded then
    return
end

-- Initialize packer
packer.init({
    -- max_jobs = 10, -- Limit the number of simultaneous jobs. nil means no limit
    transitive_disable = true, -- Automatically disable dependencies of disabled plugins
    display = {
        non_interactive = false, -- If true, disable display windows for all operations
        open_fn = function() -- An optional function to open a window for packer's display
            return require("packer.util").float({ border = { b.tl, b.t, b.tr, b.r, b.br, b.b, b.bl, b.l } })
        end,
        working_sym   = i.pending[1] .. " ", -- The symbol for a plugin being installed/updated
        error_sym     = i.error[1] .. " ", -- The symbol for a plugin with an error in installation/updating
        done_sym      = i.done[1] .. " ", -- The symbol for a plugin which has completed installation/updating
        removed_sym   = i.delete[1] .. " ", -- The symbol for an unused plugin which was removed
        moved_sym     = i.arrowr[1] .. " ", -- The symbol for a plugin which was moved (e.g. from opt to start)
        header_sym    = bs.t, -- The symbol for the header line in packer's display
        prompt_border = { b.tl, b.t, b.tr, b.r, b.br, b.b, b.bl, b.l }, -- Border style of prompt popups.
    },
    -- log = { level = "debug" }, -- The default print log level. One of: "trace", "debug", "info", "warn", "error", "fatal"
})

return packer.startup(function()
    -- Packer
    use({ "wbthomason/packer.nvim" }) -- https://github.com/wbthomason/packer.nvim

--<=< Styling >======================================================================================================>--
    -- Dressing.nvim - Neovim plugin to improve the default vim.ui interfaces
    use({
        "stevearc/dressing.nvim", -- https://github.com/stevearc/dressing.nvim
        config = function()
            require("config.dressing")
        end,
    })

    -- nvim-web-devicons - lua `fork` of vim-web-devicons for neovim
    use({
        "kyazdani42/nvim-web-devicons", -- https://github.com/kyazdani42/nvim-web-devicons
        config = function()
            require("config.nvim-web-devicons")
        end,
    })

    -- neoscroll.nvim - Smooth scrolling neovim plugin written in lua
    use({
        "karb94/neoscroll.nvim", -- https://github.com/karb94/neoscroll.nvim
        config = function()
            require("config.neoscroll")
        end,
    })

    -- alpha-nvim - A fast and highly customizable greeter for neovim
    use({
        "goolord/alpha-nvim", -- https://github.com/goolord/alpha-nvim
        requires = "nvim-web-devicons",
        config = function()
            require("config.alpha")
        end,
    })

    -- nvim-notify -- A fancy, configurable, notification manager for NeoVim
    use({
        "rcarriga/nvim-notify", -- https://github.com/rcarriga/nvim-notify
        config = function()
            require("config.notify")
        end,
    })

    -- nvim-scrollbar - Extensible Neovim Scrollbar
    use({
        "petertriho/nvim-scrollbar", -- https://github.com/petertriho/nvim-scrollbar
        config = function()
            require("config.scrollbar")
        end,
    })

    -- pretty-fold.nvim - Foldtext customization and folded region preview in Neovim
    use({
        "anuvyklack/pretty-fold.nvim", -- https://github.com/anuvyklack/pretty-fold.nvim
        config = function()
            require("config.pretty-fold")
        end,
    })
--<==================================================================================================================>--

--<=< Autocompletion and Syntax highlighting >=======================================================================>--
    -- nvim-lspconfig - Neovim's built-in language server client.
    use({
        "neovim/nvim-lspconfig", -- https://github.com/neovim/nvim-lspconfig
        after = { "cmp-nvim-lsp", "nvim-lsp-installer" },
        requires = {
            -- lsp-status.nvim - Utility functions for getting diagnostic status and progress messages from LSP servers
            {
                "nvim-lua/lsp-status.nvim", -- https://github.com/nvim-lua/lsp-status.nvim
                config = function()
                    require("config.lsp.lsp-status").config()
                end,
            },
            -- nvim-lsp-installer - Seamlessly manage LSP servers locally with :LspInstall
            {
                "williamboman/nvim-lsp-installer", -- https://github.com/williamboman/nvim-lsp-installer
                after = { "lsp-status.nvim", "cmp-nvim-lsp" },
            },
            -- lsp_signature - LSP signature hint as you type
            {
                "ray-x/lsp_signature.nvim", -- https://github.com/ray-x/lsp_signature.nvim
                after = "nvim-lspconfig",
                config = function()
                    require("config.lsp.lsp-signature")
                end,
            },
            -- lspkind.nvim - This tiny plugin adds vscode-like pictograms to neovim built-in lsp
            {
                "onsails/lspkind-nvim", -- https://github.com/onsails/lspkind-nvim
                config = function()
                    require("config.lsp.lspkind").config()
                end,
            },
            -- null-ls.nvim - Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
            {
                "jose-elias-alvarez/null-ls.nvim", -- https://github.com/jose-elias-alvarez/null-ls.nvim
                config = function()
                    require("null-ls").setup({
                        sources = {
                            require("null-ls").builtins.formatting.stylua,
                        },
                    })
                end,
            },
            -- inc-rename.nvim - Incremental LSP rename command based on Neovim's command-preview feature
            {
                "smjonas/inc-rename.nvim", -- https://github.com/smjonas/inc-rename.nvim
                disable = true,
                config = function()
                    require("inc_rename").setup()
                end,
            },
        },
        config = function()
            require("config.lsp.install")
        end,
    })

    -- nvim-cmp - A completion engine plugin for neovim written in Lua
    use({
        "hrsh7th/nvim-cmp", -- https://github.com/hrsh7th/nvim-cmp
        config = function()
            require("config.cmp")
        end,
        requires = {
            -- nvim-cmp source for neovim Lua API
            { "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" }, -- https://github.com/hrsh7th/cmp-nvim-lua
            -- A completion engine plugin for neovim written in Lua
            { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" }, -- https://github.com/hrsh7th/cmp-nvim-lsp
            -- luasnip completion source for nvim-cmp
            { "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" }, -- https://github.com/saadparwaiz1/cmp_luasnip
            -- nvim-cmp source for buffer words
            { "hrsh7th/cmp-buffer", after = "nvim-cmp" }, -- https://github.com/hrsh7th/cmp-buffer
            -- spell source for nvim-cmp based on vim's spellsuggest
            { "f3fora/cmp-spell", after = "nvim-cmp" }, -- https://github.com/f3fora/cmp-spell
            -- nvim-cmp source for filesystem paths
            { "hrsh7th/cmp-path", after = "nvim-cmp" }, -- https://github.com/hrsh7th/cmp-path
            -- nvim-cmp source for vim's cmdline
            { "hrsh7th/cmp-cmdline", after = "nvim-cmp" }, -- https://github.com/hrsh7th/cmp-cmdline
        },
    })

    -- LuaSnip - Snippet Engine for Neovim written in Lua
    use({
        "L3MON4D3/LuaSnip", -- https://github.com/L3MON4D3/LuaSnip
        config = function()
            require("luasnip/loaders/from_vscode").lazy_load()
        end,
        requires = {
            -- friendly-snippets - Set of preconfigured snippets for different languages
            {
                "rafamadriz/friendly-snippets", -- https://github.com/rafamadriz/friendly-snippets
            },
        },
    })

    -- Comment.nvim - Smart and powerful comment plugin for neovim
    use({
        "numToStr/Comment.nvim", -- https://github.com/numToStr/Comment.nvim
        keys = { { "n", "gc" }, { "v", "gc" }, { "n", "gb" }, { "v", "gb" } },
        config = function()
            require("config.comment")
        end,
    })

    -- nvim-autopairs - A super powerful autopair for Neovim. It supports multiple characters
    use({
        "windwp/nvim-autopairs", -- https://github.com/windwp/nvim-autopairs
        event = "InsertEnter",
        after = { "nvim-treesitter", "nvim-cmp" },
        config = function()
            require("config.autopairs")
        end,
    })

    -- nvim-treesitter - The goal of nvim-treesitter is both to provide a simple and easy way to use the interface for tree-sitter in Neovim and to provide some basic functionality such as highlighting based on it
    use({
        "nvim-treesitter/nvim-treesitter", -- https://github.com/nvim-treesitter/nvim-treesitter
        run = ":TSUpdate",
        requires = {
            -- nvim-ts-rainbow - Rainbow parentheses for neovim using tree-sitter
            {
                "p00f/nvim-ts-rainbow", -- https://github.com/p00f/nvim-ts-rainbow
                after = { "nvim-treesitter" },
            },
            -- nvim-ts-autotag - Use treesitter to autoclose and autorename html tagSupport
            {
                "windwp/nvim-ts-autotag", -- https://github.com/windwp/nvim-ts-autotag
                ft = { "html", "javascript", "javascriptreact", "typescriptreact", "svelte", "vue" },
            },
        },
        config = function()
            require("config.treesitter")
        end,
    })

    -- indent-blankline.nvim -- This plugin adds indentation guides to all lines
    use({
        "lukas-reineke/indent-blankline.nvim", -- https://github.com/lukas-reineke/indent-blankline.nvim
        config = function()
            require("config.indent-blankline")
        end,
    })

    -- mini.nvim - Neovim plugin with collection of minimal, independent, and fast Lua modules
    use({
        "echasnovski/mini.nvim", -- https://github.com/echasnovski/mini.nvim
        config = function()
            require("config.mini-cursorword")
        end,
    })

    -- trim.nvim - This plugin trims trailing whitespace and lines
    use({
        "cappyzawa/trim.nvim", -- https://github.com/cappyzawa/trim.nvim
        event = "BufWritePre",
        config = function ()
            require('trim').setup({})
        end,
    })

    -- vim-hexokinase - (Neo)Vim plugin for asynchronously displaying the colours in the file
    use({
        "RRethy/vim-hexokinase", -- https://github.com/RRethy/vim-hexokinase
        run = "make hexokinase",
        cmd = { "HexokinaseToggle", "HexokinaseTurnOn" },
        ft = { "css", "html", "json" },
        setup = function()
            require("config.hexokinase")
        end,
    })

    -- surround.vim - Delete/change/add parentheses/quotes/XML-tags/much more with ease
    use({
        "tpope/vim-surround",
    })

    -- Tabular - Vim script for text filtering and alignment
    use({
        "godlygeek/tabular", -- https://github.com/godlygeek/tabular
    })
--<==================================================================================================================>--

--<=< Project and file navigation >==================================================================================>--
    -- telescope.nvim - Gaze deeply into unknown regions using the power of the moon
    use({
        "nvim-telescope/telescope.nvim", -- https://github.com/nvim-telescope/telescope.nvim
        config = function()
            require("config.telescope")
        end,
        requires = {
            -- All the lua functions I don't want to write twice
            { "nvim-lua/plenary.nvim" }, -- https://github.com/nvim-lua/plenary.nvim
            -- fzf-native is a c port of fzf, a general-purpose command-line fuzzy finder
            { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }, -- https://github.com/nvim-telescope/telescope-fzf-native.nvim
            -- A telescope.nvim extension that offers intelligent prioritization when selecting files from your editing history
            { "nvim-telescope/telescope-frecency.nvim" }, -- https://github.com/nvim-telescope/telescope-frecency.nvim
            -- SQLite/LuaJIT binding for lua and neovim
            { "tami5/sqlite.lua" }, -- https://github.com/tami5/sqlite.lua
            -- An extension for telescope.nvim that allows you to switch between projects
            { "nvim-telescope/telescope-project.nvim" }, -- https://github.com/nvim-telescope/telescope-project.nvim
            -- An extension for telescope.nvim. It helps you navigate, select, and perform actions on results buffer with motions inspired by hop.nvim.
            { "nvim-telescope/telescope-hop.nvim" }, -- https://github.com/nvim-telescope/telescope-hop.nvim
        },
    })

    -- nvim-tree.lua - A File Explorer For Neovim Written In Lua
    use({
        "kyazdani42/nvim-tree.lua", -- https://github.com/kyazdani42/nvim-tree.lua
        requires = "nvim-web-devicons",
        config = function()
            require("config.nvim-tree")
        end,
    })

    -- hop.nvim - Hop allows you to jump anywhere in a document with as few keystrokes as possible
    use({
        "phaazon/hop.nvim", -- https://github.com/phaazon/hop.nvim
        config = function()
            require("hop").setup({
                jump_on_sole_occurrence = true,
            })
        end,
    })

    use({
        "stevearc/aerial.nvim", -- https://github.com/stevearc/aerial.nvim
        config = function()
            require("config.aerial")
        end,
    })

    -- trouble.nvim - A pretty diagnostics, references, telescope results, quickfix and location list
    use({
        "folke/trouble.nvim", -- https://github.com/folke/trouble.nvim
        config = function()
            require("config.trouble")
        end,
    })

    -- nvim-hlslens - Hlsearch Lens for Neovim
    use({
        "kevinhwang91/nvim-hlslens", -- https://github.com/kevinhwang91/nvim-hlslens
        config = function()
            require("config.hlslens")
        end,
    })

    -- diffview.nvim - Single tabpage interface for easily cycling through diffs for all modified files for any git rev
    use({
        "sindrets/diffview.nvim", -- https://github.com/sindrets/diffview.nvim
        cmd = { "DiffviewOpen", "DiffviewFileHistory" },
        config = function()
            require("config.diffview")
        end,
    })

    -- auto-session - A small automated session manager for Neovim
    use({
        "rmagatti/auto-session", -- https://github.com/rmagatti/auto-session
        requires = {
            -- session-lens - A session-switcher extension for rmagatti/auto-session using Telescope.nvim
            {
                "rmagatti/session-lens", -- https://github.com/rmagatti/session-lens
                after = "auto-session",
                config = function()
                    require("config.auto-session.session-lens")
                end,
            },
        },
        after = "nvim-tree.lua",
        config = function()
            require("config.auto-session")
        end,
    })
--<==================================================================================================================>--

--<=< Miscellaneous >================================================================================================>--
    -- bufferline.nvim - This plugin shamelessly attempts to emulate the aesthetics of GUI text editors/Doom Emacs
    use({
        "akinsho/bufferline.nvim", -- https://github.com/akinsho/bufferline.nvim
        requires = "nvim-web-devicons",
        config = function()
            require("config.bufferline")
        end,
    })

    -- lualine - A blazing fast and easy to configure Neovim statusline written in Lua
    use({
        "nvim-lualine/lualine.nvim", -- https://github.com/shadmansaleh/lualine.nvim
        requires = "nvim-web-devicons",
        after = "nvim-lspconfig",
        config = function()
            require("config.lualine")
        end,
    })

    -- bufdelete.nvim - Allows you to delete a buffer without messing up your window layout
    use({
        "famiu/bufdelete.nvim", -- https://github.com/famiu/bufdelete.nvim
    })

    -- FixCursorHold.nvim - Fix CursorHold performance
    use({
        "antoinemadec/FixCursorHold.nvim", -- https://github.com/antoinemadec/FixCursorHold.nvim
        config = function()
            vim.g.cursorhold_updatetime = 100
        end,
    })

    -- todo-comments.nvim - Highlight, list and search todo comments in your projects
    use({
        "folke/todo-comments.nvim", -- https://github.com/folke/todo-comments.nvim
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("config.todo-comments")
        end,
    })

    -- gitsigns.nvim - Git integration for buffers
    use({
        "lewis6991/gitsigns.nvim", -- https://github.com/lewis6991/gitsigns.nvim
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("config.gitsigns")
        end,
    })

    -- which-key.nvim - WhichKey displays a popup with possible key bindings of the command you started typing
    use({
        "folke/which-key.nvim", -- https://github.com/folke/which-key.nvim
        config = function()
            require("config.which-key")
        end,
    })

    -- undotree - The undo history visualizer for VIM
    use({
        "mbbill/undotree", -- https://github.com/mbbill/undotree
        cmd = { "UndotreeToggle", "UndotreeShow" },
        config = function()
            require("config.undotree")
        end,
    })

    -- quick-scope - Lightning fast left-right movement in Vim
    use({
        "unblevable/quick-scope", -- https://github.com/unblevable/quick-scope
        config = function()
            require("config.quick-scope")
        end,
    })

    -- stabilize.nvim - Neovim plugin to stabilize window open/close events
    use({
        "luukvbaal/stabilize.nvim", -- https://github.com/luukvbaal/stabilize.nvim
        config = function()
            require("config.stabilize")
        end,
    })

    -- repeat.vim - Enable repeating supported plugin maps with "."
    use({
        "tpope/vim-repeat", -- https://github.com/tpope/vim-repeat
    })
--<==================================================================================================================>--

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        packer.sync()
    end
end)
