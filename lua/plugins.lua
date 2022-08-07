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
        working_sym = i.pending[1] .. " ", -- The symbol for a plugin being installed/updated
        error_sym = i.lsp.error[1] .. " ", -- The symbol for a plugin with an error in installation/updating
        done_sym = i.done[1] .. " ", -- The symbol for a plugin which has completed installation/updating
        removed_sym = i.removed[1] .. " ", -- The symbol for an unused plugin which was removed
        moved_sym = i.arrowr[1] .. " ", -- The symbol for a plugin which was moved (e.g. from opt to start)
        header_sym = bs.t, -- The symbol for the header line in packer's display
        prompt_border = { b.tl, b.t, b.tr, b.r, b.br, b.b, b.bl, b.l }, -- Border style of prompt popups.
    },
    -- log = { level = "debug" }, -- The default print log level. One of: "trace", "debug", "info", "warn", "error", "fatal"
})

return packer.startup(function()
    -- Packer
    use({ "wbthomason/packer.nvim" })

    --<=< Styling >======================================================================================================>--
    -- Dressing.nvim - Neovim plugin to improve the default vim.ui interfaces
    use({
        "stevearc/dressing.nvim",
        config = function()
            require("config.dressing")
        end,
    })

    -- nvim-web-devicons - lua `fork` of vim-web-devicons for neovim
    use({
        "kyazdani42/nvim-web-devicons",
        config = function()
            require("config.nvim-web-devicons")
        end,
    })

    -- neoscroll.nvim - Smooth scrolling neovim plugin written in lua
    use({
        "karb94/neoscroll.nvim",
        config = function()
            require("config.neoscroll")
        end,
    })

    -- alpha-nvim - A fast and highly customizable greeter for neovim
    use({
        "goolord/alpha-nvim",
        requires = "nvim-web-devicons",
        config = function()
            require("config.alpha")
        end,
    })

    -- nvim-notify - A fancy, configurable, notification manager for NeoVim
    use({
        "rcarriga/nvim-notify",
        config = function()
            require("config.notify")
        end,
    })

    -- satellite.nvim - Decorate scrollbar for Neovim
    use({
        "lewis6991/satellite.nvim",
        config = function()
            require("config.satellite")
        end,
    })

    -- pretty-fold.nvim - Foldtext customization and folded region preview in Neovim
    use({
        "anuvyklack/pretty-fold.nvim",
        config = function()
            require("config.pretty-fold")
        end,
    })

    -- incline.nvim - Floating winbar statuslines for Neovim
    use({
        "b0o/incline.nvim",
        config = function()
            require("config.incline")
        end,
    })
    --<==================================================================================================================>--

    --<=< Autocompletion and Syntax highlighting >=======================================================================>--
    -- mason.nvim - Portable package manager for Neovim that runs everywhere Neovim runs. Easily install and manage LSP
    -- servers, DAP servers, linters, and formatters.
    use({
        "williamboman/mason.nvim",
        requires = {
            -- mason-tool-installer - Install and upgrade third party tools automatically
            {
                "WhoIsSethDaniel/mason-tool-installer.nvim",
                after = "mason.nvim",
                config = function()
                    require("config.lsp.mason-tool-installer")
                end,
            },
            -- mason-lspconfig.nvim - Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim
            {
                "williamboman/mason-lspconfig.nvim",
                after = { "nvim-lspconfig", "mason.nvim", "mason-tool-installer.nvim" },
                config = function()
                    require("config.lsp.mason-lspconfig")
                end,
            },
        },
        config = function()
            require("config.lsp.mason")
        end,
    })

    -- nvim-lspconfig - Neovim's built-in language server client.
    use({
        "neovim/nvim-lspconfig",
        after = { "cmp-nvim-lsp" },
        requires = {
            -- lsp-status.nvim - Utility functions for getting diagnostic status and progress messages from LSP servers
            {
                "nvim-lua/lsp-status.nvim",
                config = function()
                    require("config.lsp.lsp-status").config()
                end,
            },
            -- lsp_signature - LSP signature hint as you type
            {
                "ray-x/lsp_signature.nvim",
                config = function()
                    require("config.lsp.lsp-signature")
                end,
            },
            -- lspkind.nvim - This tiny plugin adds vscode-like pictograms to neovim built-in lsp
            {
                "onsails/lspkind-nvim",
                config = function()
                    require("config.lsp.lspkind").config()
                end,
            },
            -- null-ls.nvim - Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
            {
                "jose-elias-alvarez/null-ls.nvim",
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
                "smjonas/inc-rename.nvim",
                config = function()
                    require("inc_rename").setup()
                end,
            },
        },
    })

    -- nvim-cmp - A completion engine plugin for neovim written in Lua
    use({
        "hrsh7th/nvim-cmp",
        config = function()
            require("config.cmp")
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
            require("config.comment")
        end,
    })

    -- nvim-autopairs - A super powerful autopair for Neovim. It supports multiple characters
    use({
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        after = { "nvim-treesitter", "nvim-cmp" },
        config = function()
            require("config.autopairs")
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
            -- nvim-ts-autotag - Use treesitter to autoclose and autorename html tagSupport
            {
                "windwp/nvim-ts-autotag",
                ft = { "html", "javascript", "javascriptreact", "typescriptreact", "svelte", "vue" },
            },
        },
        config = function()
            require("config.treesitter")
        end,
    })

    -- indent-blankline.nvim - This plugin adds indentation guides to all lines
    use({
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("config.indent-blankline")
        end,
    })

    -- mini.nvim - Neovim plugin with collection of minimal, independent, and fast Lua modules
    use({
        "echasnovski/mini.nvim",
        config = function()
            require("config.mini.cursorword")
        end,
    })

    -- vim-hexokinase - (Neo)Vim plugin for asynchronously displaying the colours in the file
    use({
        "RRethy/vim-hexokinase",
        run = "make hexokinase",
        cmd = { "HexokinaseToggle", "HexokinaseTurnOn" },
        ft = { "css", "html", "json" },
        setup = function()
            require("config.hexokinase")
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
    --<==================================================================================================================>--

    --<=< Project and file navigation >==================================================================================>--
    -- telescope.nvim - Gaze deeply into unknown regions using the power of the moon
    use({
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        config = function()
            require("config.telescope")
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
        },
    })

    -- neo-tree.nvim - Neovim plugin to manage the file system and other tree like structures
    use({
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "kyazdani42/nvim-web-devicons",
            "MunifTanjim/nui.nvim", -- UI Component Library for Neovim.
        },
        config = function()
            require("config.neo-tree")
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

    -- aerial.nvim - Neovim plugin for a code outline window
    use({
        "stevearc/aerial.nvim",
        config = function()
            require("config.aerial")
        end,
    })

    -- trouble.nvim - A pretty diagnostics, references, telescope results, quickfix and location list
    use({
        "folke/trouble.nvim",
        config = function()
            require("config.trouble")
        end,
    })

    -- nvim-hlslens - Hlsearch Lens for Neovim
    use({
        "kevinhwang91/nvim-hlslens",
        config = function()
            require("config.hlslens")
        end,
    })

    -- diffview.nvim - Single tabpage interface for easily cycling through diffs for all modified files for any git rev
    use({
        "sindrets/diffview.nvim",
        cmd = { "DiffviewOpen", "DiffviewFileHistory" },
        config = function()
            require("config.diffview")
        end,
    })

    -- possession.nvim - Flexible session management for Neovim
    use({
        "jedrzejboczar/possession.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = function()
            require("config.possession")
            require("telescope").load_extension("possession")
        end,
    })
    --<==================================================================================================================>--

    --<=< Miscellaneous >================================================================================================>--
    -- tabby.nvim - A minimal, configurable, neovim style tabline. Use your nvim tabs as workspace multiplexer.
    use({
        "nanozuki/tabby.nvim",
        requires = "nvim-web-devicons",
        after = "lualine.nvim",
        config = function()
            require("config.tabby")
        end,
    })

    -- lualine - A blazing fast and easy to configure Neovim statusline written in Lua
    use({
        "nvim-lualine/lualine.nvim",
        requires = "nvim-web-devicons",
        after = "nvim-lspconfig",
        config = function()
            require("config.lualine")
        end,
    })

    -- bufdelete.nvim - Allows you to delete a buffer without messing up your window layout
    use({
        "famiu/bufdelete.nvim",
    })

    -- FixCursorHold.nvim - Fix CursorHold performance
    use({
        "antoinemadec/FixCursorHold.nvim",
        config = function()
            vim.g.cursorhold_updatetime = 100
        end,
    })

    -- todo-comments.nvim - Highlight, list and search todo comments in your projects
    use({
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("config.todo-comments")
        end,
    })

    -- gitsigns.nvim - Git integration for buffers
    use({
        "lewis6991/gitsigns.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("config.gitsigns")
        end,
    })

    -- which-key.nvim - WhichKey displays a popup with possible key bindings of the command you started typing
    use({
        "folke/which-key.nvim",
        config = function()
            require("config.which-key")
        end,
    })

    -- Hydra.nvim - Bind a bunch of key bindings together
    use({
        "anuvyklack/hydra.nvim",
        config = function()
            require("config.hydra")
        end,
    })

    -- undotree - The undo history visualizer for VIM
    use({
        "mbbill/undotree",
        cmd = { "UndotreeToggle", "UndotreeShow", "UndotreeHide" },
        config = function()
            require("config.undotree")
        end,
    })

    -- quick-scope - Lightning fast left-right movement in Vim
    use({
        "unblevable/quick-scope",
        config = function()
            require("config.quick-scope")
        end,
    })

    -- stabilize.nvim - Neovim plugin to stabilize window open/close events
    use({
        "luukvbaal/stabilize.nvim",
        config = function()
            require("config.stabilize")
        end,
    })
    --<==================================================================================================================>--

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        packer.sync()
    end
end)
