local i = USER.styling.icons
local b = USER.styling.borders.default
local bs = USER.styling.borders.single

-- Automatically install and set up packer.nvim
local ensure_packer = function()
    local fn = vim.fn
    local install_path = USER.packer_path .. "/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
        vim.cmd([[packadd packer.nvim]])
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

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
        working_sym = i.pending[1], -- The symbol for a plugin being installed/updated
        error_sym = i.lsp.error[1], -- The symbol for a plugin with an error in installation/updating
        done_sym = i.done[1], -- The symbol for a plugin which has completed installation/updating
        removed_sym = i.delete[1], -- The symbol for an unused plugin which was removed
        moved_sym = i.arrowr[1], -- The symbol for a plugin which was moved (e.g. from opt to start)
        header_sym = bs.t, -- The symbol for the header line in packer's display
        prompt_border = { b.tl, b.t, b.tr, b.r, b.br, b.b, b.bl, b.l }, -- Border style of prompt popups.
    },
    -- log = { level = "debug" }, -- The default print log level. One of: "trace", "debug", "info", "warn", "error", "fatal"
})

return packer.startup(function()
    -- Packer
    use({ "wbthomason/packer.nvim" })

    ---- Styling -------------------------------------------------------------------------------------------------------
    -- Dressing.nvim - Neovim plugin to improve the default vim.ui interfaces
    use({
        "stevearc/dressing.nvim",
        config = function()
            require("config.dressing-config")
        end,
    })

    -- nvim-web-devicons - Lua `fork` of vim-web-devicons for Neovim
    use({
        "kyazdani42/nvim-web-devicons",
        config = function()
            require("config.nvim-web-devicons-config")
        end,
    })

    -- neoscroll.nvim - Smooth scrolling Neovim plugin written in Lua
    use({
        "karb94/neoscroll.nvim",
        config = function()
            require("config.neoscroll-config")
        end,
    })

    -- alpha-nvim - A fast and highly customizable greeter for Neovim
    use({
        "goolord/alpha-nvim",
        requires = "nvim-web-devicons",
        config = function()
            require("config.alpha-config")
        end,
    })

    -- nvim-notify - A fancy, configurable, notification manager for Neovim
    use({
        "rcarriga/nvim-notify",
        config = function()
            require("config.notify-config")
        end,
    })

    -- satellite.nvim - Decorate scrollbar for Neovim
    use({
        "petrosAth/satellite.nvim",
        config = function()
            require("config.satellite-config")
        end,
    })

    -- pretty-fold.nvim - foldtext customization and folded region preview in Neovim
    use({
        "anuvyklack/pretty-fold.nvim",
        config = function()
            require("config.pretty-fold-config")
        end,
    })

    -- codewindow.nvim - Codewindow.nvim is a minimap plugin for Neovim, that is closely integrated with treesitter and the builtin LSP to display more information to the user
    use({
        "gorbit99/codewindow.nvim",
        config = function()
            require("config.codewindow-config")
        end,
    })

    ---- Autocompletion and Syntax highlighting ---------------------------------------------------------------------
    -- mason.nvim - Portable package manager for Neovim that runs everywhere Neovim runs. Easily install and manage LSP
    -- servers, DAP servers, linters, and formatters.
    use({
        "williamboman/mason.nvim",
        after = "nvim-lspconfig",
        requires = {
            -- mason-tool-installer - Install and upgrade third party tools automatically
            {
                "WhoIsSethDaniel/mason-tool-installer.nvim",
                after = "mason.nvim",
                config = function()
                    require("config.lsp.mason-tool-installer-config")
                end,
            },
            -- mason-lspconfig.nvim - Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim
            {
                "williamboman/mason-lspconfig.nvim",
                after = "mason.nvim",
                config = function()
                    require("config.lsp.mason-lspconfig-config")
                end,
            },
        },
        config = function()
            require("config.lsp.mason-config")
        end,
    })

    -- nvim-lspconfig - Neovim's built-in language server client.
    use({
        "neovim/nvim-lspconfig",
        after = "cmp-nvim-lsp",
        requires = {
            -- lsp_signature - LSP signature hint as you type
            {
                "ray-x/lsp_signature.nvim",
                config = function()
                    require("config.lsp.lsp-signature-config")
                end,
            },
            -- lspkind.nvim - This tiny plugin adds vscode-like pictograms to neovim built-in lsp
            {
                "onsails/lspkind-nvim",
                config = function()
                    require("config.lsp.lspkind-config")
                end,
            },
            -- null-ls.nvim - Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
            {
                "jose-elias-alvarez/null-ls.nvim",
                config = function()
                    require("config.lsp.null-ls-config")
                end,
            },
            -- inc-rename.nvim - Incremental LSP rename command based on Neovim's command-preview feature
            {
                "smjonas/inc-rename.nvim",
                config = function()
                    require("inc_rename").setup()
                end,
            },
            -- j-hui/fidget.nvim - Standalone UI for nvim-lsp progress
            {
                "j-hui/fidget.nvim",
                config = function()
                    require("config.lsp.fidget-config")
                end,
            },
            -- nvim-lightbulb - VSCode bulb for neovim's built-in LSP.
            {
                "kosayoda/nvim-lightbulb",
                config = function()
                    require("config.lsp.nvim-lightbulb-config")
                end,
            },
            -- nvim-navic - Simple winbar/statusline plugin that shows your current code context
            {
                "SmiteshP/nvim-navic",
                config = function()
                    require("config.lsp.nvim-navic-config")
                end,
            },
        },
    })

    -- nvim-cmp - A completion engine plugin for neovim written in Lua
    use({
        "hrsh7th/nvim-cmp",
        config = function()
            require("config.cmp-config")
        end,
        requires = {
            -- nvim-cmp source for neovim Lua API
            { "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" },
            -- A completion engine plugin for neovim written in Lua
            { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },
            -- luasnip completion source for nvim-cmp
            { "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
            -- nvim-cmp source for buffer words
            { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
            -- spell source for nvim-cmp based on vim's spellsuggest
            { "f3fora/cmp-spell", after = "nvim-cmp" },
            -- nvim-cmp source for filesystem paths
            { "hrsh7th/cmp-path", after = "nvim-cmp" },
            -- nvim-cmp source for math calculation
            { "hrsh7th/cmp-calc", after = "nvim-cmp" },
            -- nvim-cmp source for vim's cmdline
            { "hrsh7th/cmp-cmdline", after = "nvim-cmp" },
        },
    })

    -- LuaSnip - Snippet Engine for Neovim written in Lua
    use({
        "L3MON4D3/LuaSnip",
        config = function()
            require("luasnip/loaders/from_vscode").lazy_load()
        end,
        requires = {
            -- friendly-snippets - Set of preconfigured snippets for different languages
            {
                "rafamadriz/friendly-snippets",
            },
        },
    })

    -- Comment.nvim - Smart and powerful comment plugin for neovim
    use({
        "numToStr/Comment.nvim",
        keys = { { "n", "gc" }, { "v", "gc" }, { "n", "gb" }, { "v", "gb" } },
        config = function()
            require("config.comment-config")
        end,
    })

    -- nvim-autopairs - A super powerful autopair for Neovim. It supports multiple characters
    use({
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        after = { "nvim-treesitter", "nvim-cmp" },
        config = function()
            require("config.autopairs-config")
        end,
    })

    -- nvim-treesitter - The goal of nvim-treesitter is both to provide a simple and easy way to use the interface for tree-sitter in Neovim and to provide some basic functionality such as highlighting based on it
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        requires = {
            -- nvim-ts-rainbow - Rainbow parentheses for neovim using tree-sitter
            {
                "p00f/nvim-ts-rainbow",
                after = { "nvim-treesitter" },
            },
        },
        config = function()
            require("config.treesitter-config")
        end,
    })

    -- indent-blankline.nvim - This plugin adds indentation guides to all lines
    use({
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("config.indent-blankline-config")
        end,
    })

    -- vim-illuminate - Vim plugin for automatically highlighting other uses of the word under the cursor using either LSP, Tree-sitter, or regex matching.
    use({
        "RRethy/vim-illuminate",
        config = function()
            require("config.vim-illuminate-config")
        end,
    })

    -- vim-hexokinase - (Neo)Vim plugin for asynchronously displaying the colours in the file
    use({
        "RRethy/vim-hexokinase",
        run = "make hexokinase",
        cmd = { "HexokinaseToggle", "HexokinaseTurnOn" },
        ft = { "css", "html", "javascript", "json", "scss" },
        setup = function()
            require("config.hexokinase-config")
        end,
    })

    -- nvim-surround - Add/change/delete surrounding delimiter pairs with ease. Written with love in Lua
    use({
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup()
        end,
    })

    -- Tabular - Vim script for text filtering and alignment
    use({
        "godlygeek/tabular",
    })

    ---- Project and file navigation -----------------------------------------------------------------------------------
    -- telescope.nvim - Gaze deeply into unknown regions using the power of the moon
    use({
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        config = function()
            require("config.telescope-config")
        end,
        requires = {
            -- All the lua functions I don't want to write twice
            { "nvim-lua/plenary.nvim" },
            -- fzf-native is a c port of fzf, a general-purpose command-line fuzzy finder
            { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
            -- A telescope.nvim extension that offers intelligent prioritization when selecting files from your editing history
            { "nvim-telescope/telescope-frecency.nvim" },
            -- SQLite/LuaJIT binding for lua and neovim
            { "tami5/sqlite.lua" },
            -- An extension for telescope.nvim. It helps you navigate, select, and perform actions on results buffer with motions inspired by hop.nvim.
            { "nvim-telescope/telescope-hop.nvim" },
            -- File Browser extension for telescope.nvim
            { "nvim-telescope/telescope-file-browser.nvim" },
            -- Telescope.nvim extension that adds LuaSnip integration
            { "benfowler/telescope-luasnip.nvim" },
            -- dir-telescope.nvim - Perform telescope functions in a selected directory
            { "princejoogie/dir-telescope.nvim" },
        },
    })

    -- neo-tree.nvim - Neovim plugin to manage the file system and other tree like structures
    use({
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = {
            { "nvim-lua/plenary.nvim" },
            { "kyazdani42/nvim-web-devicons" },
            { "MunifTanjim/nui.nvim" }, -- UI Component Library for Neovim.
            {
                "s1n7ax/nvim-window-picker", -- nvim-window-picker - This plugins prompts the user to pick a window and returns the window id of the picked window
                -- tag = "v1.*",
                config = function()
                    require("config.nvim-window-picker-config")
                end,
            },
        },
        config = function()
            require("config.neo-tree-config")
        end,
    })

    -- hop.nvim - Hop allows you to jump anywhere in a document with as few keystrokes as possible
    use({
        "phaazon/hop.nvim",
        branch = "v2",
        config = function()
            require("hop").setup()
        end,
    })

    -- symbols-outline.nvim - A tree like view for symbols in Neovim using the Language Server Protocol. Supports all your favourite languages.
    use({
        "simrat39/symbols-outline.nvim",
        config = function()
            require("config.symbols-outline-config")
        end,
    })

    -- trouble.nvim - A pretty diagnostics, references, telescope results, quickfix and location list
    use({
        "folke/trouble.nvim",
        config = function()
            require("config.trouble-config")
        end,
    })

    -- nvim-hlslens - Hlsearch Lens for Neovim
    use({
        "kevinhwang91/nvim-hlslens",
        config = function()
            require("config.hlslens-config")
        end,
    })

    -- diffview.nvim - Single tabpage interface for easily cycling through diffs for all modified files for any git rev
    use({
        "sindrets/diffview.nvim",
        config = function()
            require("config.diffview-config")
        end,
    })

    -- possession.nvim - Flexible session management for Neovim
    use({
        "jedrzejboczar/possession.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = function()
            require("config.possession-config")
        end,
    })

    -- nvim-config-local - Secure load local config files for neovim
    use({
        "klen/nvim-config-local",
        config = function()
            require("config.nvim-config-local-config")
        end,
    })

    ---- Miscellaneous -------------------------------------------------------------------------------------------------
    -- tabby.nvim - A minimal, configurable, neovim style tabline. Use your nvim tabs as workspace multiplexer.
    use({
        "nanozuki/tabby.nvim",
        requires = "nvim-web-devicons",
        config = function()
            require("config.ui.tab-line")
        end,
    })

    -- heirline.nvim - Heirline.nvim is a no-nonsense Neovim Statusline plugin designed around recursive inheritance to be exceptionally fast and versatile.
    use({
        "rebelot/heirline.nvim",
        config = function()
            local status_lines = require("config.ui.status-bars.status-line").StatusLines
            local win_bars = require("config.ui.status-bars.win-bar").WinBars
            require("heirline").setup(status_lines, win_bars)
        end,
    })

    -- bufdelete.nvim - Allows you to delete a buffer without messing up your window layout
    use({
        "famiu/bufdelete.nvim",
    })

    -- todo-comments.nvim - Highlight, list and search todo comments in your projects
    use({
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("config.todo-comments-config")
        end,
    })

    -- gitsigns.nvim - Git integration for buffers
    use({
        "lewis6991/gitsigns.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("config.gitsigns-config")
        end,
    })

    -- which-key.nvim - WhichKey displays a popup with possible key bindings of the command you started typing
    use({
        "folke/which-key.nvim",
        config = function()
            require("config.which-key-config")
        end,
    })

    -- Hydra.nvim - Bind a bunch of key bindings together
    use({
        "anuvyklack/hydra.nvim",
        config = function()
            require("config.hydra-config")
        end,
    })

    -- undotree - The undo history visualizer for VIM
    use({
        "mbbill/undotree",
        cmd = { "UndotreeToggle", "UndotreeShow", "UndotreeHide" },
        config = function()
            require("config.undotree-config")
        end,
    })

    -- quick-scope - Lightning fast left-right movement in Vim
    use({
        "unblevable/quick-scope",
        config = function()
            require("config.quick-scope-config")
        end,
    })

    -- stabilize.nvim - Neovim plugin to stabilize window open/close events
    use({
        "luukvbaal/stabilize.nvim",
        config = function()
            require("config.stabilize-config")
        end,
    })

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        packer.sync()
    end
end)
