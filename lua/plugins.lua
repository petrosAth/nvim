local packer = require("plugins-cfg.packer-cfg")
local use = packer.use

return packer.startup(function()
------ Packer ------------------------------------------------------------------
    use{ "wbthomason/packer.nvim" } -- https://github.com/wbthomason/packer.nvim

-- Autocompletion and Syntax highlighting --{{{
    -- nvim-lspconfig - Neovim's built-in language server client.
    use{--{{{
        "neovim/nvim-lspconfig", -- https://github.com/neovim/nvim-lspconfig
        disable = false,
		lock = false,
        after = "cmp-nvim-lsp",
        -- config = function()
        --     require("plugins-cfg.lsp-cfg.lspconfig-languageServers")
        -- end,
        requires = {
            -- lsp-status.nvim - Utility functions for getting diagnostic status and progress messages from LSP servers
            {--{{{
                "nvim-lua/lsp-status.nvim", -- https://github.com/nvim-lua/lsp-status.nvim
                disable = false,
                lock = false,
                config = function()
                    require("plugins-cfg.lsp-cfg.lsp-status-cfg").config()
                end
            },--}}}
            -- nvim-lsp-installer - Seamlessly manage LSP servers locally with :LspInstall
            {--{{{
                "williamboman/nvim-lsp-installer", -- https://github.com/williamboman/nvim-lsp-installer
                disable = false,
                lock = false,
                after = { "lsp-status.nvim", "cmp-nvim-lsp" },
                config = function()
                    require("plugins-cfg.lsp-cfg.nvim-lsp-installer-cfg")
                end
            },--}}}
            -- lsp_signature - LSP signature hint as you type
            {--{{{
                "ray-x/lsp_signature.nvim", -- https://github.com/ray-x/lsp_signature.nvim
                disable = false,
                lock = false,
                after = "nvim-lspconfig",
                config = function()
                    require("plugins-cfg.lsp-cfg.lsp-signature-cfg")
                end
            },--}}}
            -- nvim-lightbulb - VSCode action for neovim's built-in LSP
            {--{{{
                "kosayoda/nvim-lightbulb", -- https://github.com/kosayoda/nvim-lightbulb
                disable = false,
                lock = false,
                config = function()
                    require("plugins-cfg.lsp-cfg.nvim-lightbulb-cfg")
                end
            },--}}}
            -- lspkind.nvim - This tiny plugin adds vscode-like pictograms to neovim built-in lsp
            {--{{{
                "onsails/lspkind-nvim", -- https://github.com/onsails/lspkind-nvim
                disable = false,
                lock = false,
                config = function()
                    require("plugins-cfg.lsp-cfg.lspkind-cfg").config()
                end,
            },--}}}
        },
    }--}}}

    -- A completion engine plugin for neovim written in Lua
    use{--{{{
        "hrsh7th/nvim-cmp", -- https://github.com/hrsh7th/nvim-cmp
        disable = false,
		lock = false,
        config = function()
            require("plugins-cfg.cmp-cfg")
        end,
        requires = {
            -- nvim-cmp source for neovim Lua API
            { "hrsh7th/cmp-nvim-lua", after = "nvim-cmp", lock = false }, -- https://github.com/hrsh7th/cmp-nvim-lua
            -- A completion engine plugin for neovim written in Lua
            { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp", lock = false }, -- https://github.com/hrsh7th/cmp-nvim-lsp
            -- luasnip completion source for nvim-cmp
            { "saadparwaiz1/cmp_luasnip", after = "nvim-cmp", lock = false }, -- https://github.com/saadparwaiz1/cmp_luasnip
            -- nvim-cmp source for buffer words
            { "hrsh7th/cmp-buffer", after = "nvim-cmp", lock = false }, -- https://github.com/hrsh7th/cmp-buffer
            -- spell source for nvim-cmp based on vim's spellsuggest
            { "f3fora/cmp-spell", after = "nvim-cmp", lock = false }, -- https://github.com/f3fora/cmp-spell
            -- nvim-cmp source for math calculation
            { "hrsh7th/cmp-calc", after = "nvim-cmp", lock = false }, -- https://github.com/hrsh7th/cmp-calc
            -- nvim-cmp source for filesystem paths
            { "hrsh7th/cmp-path", after = "nvim-cmp", lock = false }, -- https://github.com/hrsh7th/cmp-path
            -- nvim-cmp source for vim's cmdline
            { "hrsh7th/cmp-cmdline", after = "nvim-cmp", lock = false }, -- https://github.com/hrsh7th/cmp-cmdline
        },
    }--}}}

    -- Snippet Engine for Neovim written in Lua
    use{--{{{
        "L3MON4D3/LuaSnip", -- https://github.com/L3MON4D3/LuaSnip
        disable = false,
        lock = false,
        config = function()
            require("luasnip\\loaders\\from_vscode").lazy_load()
        end,
        requires = {
            -- friendly-snippets - Set of preconfigured snippets for different languages
            {--{{{
                "rafamadriz/friendly-snippets", -- https://github.com/rafamadriz/friendly-snippets
                disable = false,
                lock = false,
            }--}}}
        }
    }--}}}

    -- Comment.nvim - Smart and powerful comment plugin for neovim
    use{--{{{
        "numToStr/Comment.nvim", -- https://github.com/numToStr/Comment.nvim
        disable = false,
		lock = false,
        keys = {{ "n", "gc" }, { "v", "gc" }, { "n", "gb" }, { "v", "gb" }},
        config = function()
            require("plugins-cfg.comment-cfg")
        end,
    }--}}}

    -- nvim-autopairs - A super powerful autopair for Neovim. It supports multiple characters
    use{--{{{
        "windwp/nvim-autopairs", -- https://github.com/windwp/nvim-autopairs
        disable = false,
        lock = false,
        -- event = "InsertEnter",
        after = { "nvim-treesitter", "nvim-cmp" },
        config = function()
            require("plugins-cfg.autopairs-cfg")
        end,
    }--}}}

    -- nvim-treesitter - The goal of nvim-treesitter is both to provide a simple and easy way to use the interface for tree-sitter in Neovim and to provide some basic functionality such as highlighting based on it
    use{--{{{
        "nvim-treesitter/nvim-treesitter", -- https://github.com/nvim-treesitter/nvim-treesitter
        disable = false,
		lock = false,
        run = ":TSUpdate",
        requires = {
            -- nvim-ts-rainbow - Rainbow parentheses for neovim using tree-sitter
            {--{{{
                "p00f/nvim-ts-rainbow", -- https://github.com/p00f/nvim-ts-rainbow
                disable = false,
                lock = false,
                after = { "nvim-treesitter" },
            },--}}}
            -- nvim-ts-autotag - Use treesitter to autoclose and autorename html tagSupport
            {--{{{
                "windwp/nvim-ts-autotag", -- https://github.com/windwp/nvim-ts-autotag
                disable = false,
                lock = false,
                ft = { "html", "javascript", "javascriptreact", "typescriptreact", "svelte", "vue" }
            },--}}}
        },
        config = function()
            require("plugins-cfg.treesitter-cfg")
        end,
    }--}}}

    -- vim-hexokinase - (Neo)Vim plugin for asynchronously displaying the colours in the file
    use{--{{{
        "RRethy/vim-hexokinase", -- https://github.com/RRethy/vim-hexokinase
        disable = false,
		lock    = false,
        run     = "mingw32-make",
        cmd     = { "HexokinaseToggle", "HexokinaseTurnOn" },
        ft      = { "css", "html" },
        setup   = function()
            require("plugins-cfg.hexokinase-cfg")
        end
    }--}}}

    -- indent-blankline.nvim -- This plugin adds indentation guides to all lines
    use{--{{{
        "lukas-reineke/indent-blankline.nvim", -- https://github.com/lukas-reineke/indent-blankline.nvim
        disable = false,
		lock = false,
        config = function()
            require("plugins-cfg.indent-blankline-cfg")
        end,
    }--}}}

    -- vim-illuminate - Vim plugin for automatically highlighting other uses of the current word under the cursor
    use{--{{{
        "RRethy/vim-illuminate", -- https://github.com/RRethy/vim-illuminate
        disable = false,
        lock = false,
        event = "BufAdd",
        setup = function()
            require("plugins-cfg.illuminate-cfg")
        end
    }--}}}
--}}}

-- Cosmetics --{{{
    -- dracula -- color theme
    use{--{{{
        "dracula/vim", as = "dracula", -- https://github.com/dracula/vim
        disable = false,
		lock = false,
        config = function()
            require("cosmetics").dracula()
        end,
    }--}}}

    -- nvim-web-devicons - lua `fork` of vim-web-devicons for neovim
    use{--{{{
		"kyazdani42/nvim-web-devicons", -- https://github.com/kyazdani42/nvim-web-devicons
        disable = false,
		lock = false,
		config = function()
            require("nvim-web-devicons").setup()
		end,
	}--}}}

    -- neoscroll.nvim - Smooth scrolling neovim plugin written in lua
    use{--{{{
        "karb94/neoscroll.nvim", -- https://github.com/karb94/neoscroll.nvim
        disable = false,
		lock = false,
        config = function()
            require("plugins-cfg.neoscroll-cfg")
        end,
    }--}}}

    -- alpha-nvim - A fast and highly customizable greeter for neovim
    use{--{{{
        "goolord/alpha-nvim", -- https://github.com/goolord/alpha-nvim
        disable = false,
		lock = false,
        requires = "nvim-web-devicons",
        config = function()
            require("plugins-cfg.alpha-cfg")
        end,
    }--}}}
--}}}

-- Project and file navigation --{{{
    -- telescope.nvim - Gaze deeply into unknown regions using the power of the moon
    use{--{{{
        "nvim-telescope/telescope.nvim", -- https://github.com/nvim-telescope/telescope.nvim
        disable = false,
		lock = false,
        setup = function()
            vim.g.sqlite_clib_path = "C:\\ProgramData\\chocolatey\\lib\\SQLite\\tools\\sqlite3.dll"
		end,
        config = function()
			require("plugins-cfg.telescope-cfg")
        end,
        requires = {--{{{
            -- All the lua functions I don't want to write twice
            { "nvim-lua/plenary.nvim", lock = false }, -- https://github.com/nvim-lua/plenary.nvim
            -- fzf-native is a c port of fzf, a general-purpose command-line fuzzy finder
            { "nvim-telescope/telescope-fzf-native.nvim", run = "mingw32-make", lock = false }, -- https://github.com/nvim-telescope/telescope-fzf-native.nvim
            -- A telescope.nvim extension that offers intelligent prioritization when selecting files from your editing history
            { "nvim-telescope/telescope-frecency.nvim", lock = false }, -- https://github.com/nvim-telescope/telescope-frecency.nvim
            -- SQLite/LuaJIT binding for lua and neovim
            { "tami5/sqlite.lua", lock = false }, -- https://github.com/tami5/sqlite.lua
            -- An extension for telescope.nvim that allows you to switch between projects
            { "nvim-telescope/telescope-project.nvim", lock = false }, -- https://github.com/nvim-telescope/telescope-project.nvim
            -- An extension for telescope.nvim. It helps you navigate, select, and perform actions on results buffer with motions inspired by hop.nvim.
            { "nvim-telescope/telescope-hop.nvim", lock = false }, -- https://github.com/nvim-telescope/telescope-hop.nvim
        },--}}}
    }--}}}

    -- nvim-tree.lua - A File Explorer For Neovim Written In Lua
    use{--{{{
        "kyazdani42/nvim-tree.lua", -- https://github.com/kyazdani42/nvim-tree.lua
        -- commit = "b853e1083c67a79b4eb046a112a8e12b35e9cd19",
        disable = false,
		lock = false,
        cmd = { "NvimTreeOpen", "NvimTreeToggle" },
        requires = "nvim-web-devicons",
        config = function()
            require("plugins-cfg.nvim-tree-cfg")
        end,
    }--}}}

    -- hop.nvim - Hop allows you to jump anywhere in a document with as few keystrokes as possible
    use{--{{{
        "phaazon/hop.nvim", -- https://github.com/phaazon/hop.nvim
        disable = false,
		lock = false,
        config = function()
            require("plugins-cfg.hop-cfg")
        end,
    }--}}}

    -- minimap.vim - Blazing fast minimap / scrollbar for vim, powered by code-minimap written in Rust
    use{--{{{
        "wfxr/minimap.vim", -- https://github.com/wfxr/minimap.vim
        disable = false,
		lock = false,
        cmd = { "Minimap", "MinimapToggle" },
        setup = function()
            require("plugins-cfg.minimap-cfg")
        end,
    }--}}}

    -- symbols-outline.nvim - A tree like view for symbols in Neovim using the Language Server Protocol
    use{--{{{
        "simrat39/symbols-outline.nvim", -- https://github.com/simrat39/symbols-outline.nvim
        disable = false,
		lock = false,
        cmd = { "SymbolsOutline", "SymbolsOutlineOpen" },
        setup = function()
            require("plugins-cfg.symbols-outline-cfg")
        end
    }--}}}

    -- trouble.nvim - A pretty diagnostics, references, telescope results, quickfix and location list
    use{--{{{
        "folke/trouble.nvim", -- https://github.com/folke/trouble.nvim
        disable = false,
        lock = false,
        config = function()
            require("plugins-cfg.trouble-cfg")
        end
    }--}}}

    -- nvim-hlslens - Hlsearch Lens for Neovim
    use{--{{{
        "kevinhwang91/nvim-hlslens", -- https://github.com/kevinhwang91/nvim-hlslens
        disable = false,
        lock = false,
        config = function()
            require("plugins-cfg.nvim-hlslens-cfg")
        end
    }--}}}
--}}}

-- Miscellaneous --{{{
    -- bufferline.nvim - This plugin shamelessly attempts to emulate the aesthetics of GUI text editors/Doom Emacs
    use{--{{{
        "akinsho/bufferline.nvim", -- https://github.com/akinsho/bufferline.nvim
        disable = false,
		lock = false,
        requires = "nvim-web-devicons",
        config = function()
            require("plugins-cfg.bufferline-cfg")
        end,
    }--}}}

    -- lualine.nvim - A blazing fast and easy to configure Neovim statusline written in Lua
    use{--{{{
        "nvim-lualine/lualine.nvim", -- https://github.com/shadmansaleh/lualine.nvim
        disable = false,
		lock = false,
        requires = "nvim-web-devicons",
        after = "nvim-lspconfig",
        config = function()
            require("plugins-cfg.lualine-cfg")
        end,
    }--}}}

    -- bufdelete.nvim - Allows you to delete a buffer without messing up your window layout
    use{--{{{
        "famiu/bufdelete.nvim", -- https://github.com/famiu/bufdelete.nvim
        disable = false,
		lock = false
    }--}}}

    -- FixCursorHold.nvim - Fix CursorHold performance
    use{--{{{
        "antoinemadec/FixCursorHold.nvim", -- https://github.com/antoinemadec/FixCursorHold.nvim
        disable = false,
		lock = false
    }--}}}

    -- todo-comments.nvim - Highlight, list and search todo comments in your projects
    use{--{{{
        "folke/todo-comments.nvim", -- https://github.com/folke/todo-comments.nvim
        disable = false,
        lock = false,
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("plugins-cfg.todo-comments-cfg")
        end
    }--}}}

    -- gitsigns.nvim - Git integration for buffers
    use{--{{{
        "lewis6991/gitsigns.nvim", -- https://github.com/lewis6991/gitsigns.nvim
        disable = false,
        lock = false,
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("plugins-cfg.gitsigns-cfg")
        end
    }--}}}

    -- which-key.nvim - WhichKey displays a popup with possible key bindings of the command you started typing
    use{--{{{
        "folke/which-key.nvim", -- https://github.com/folke/which-key.nvim
        disable = false,
        lock = false,
        config = function()
            require("plugins-cfg.which-key")
        end
    }--}}}
--}}}

    -- Automatic initial plugin installation
    if vim.fn.len(vim.fn.globpath(PACKER_PATH .. "\\start", "*", 0, 1)) == 1 then
        vim.cmd([[PackerSync]])
    end
end)
