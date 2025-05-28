local icons = USER.styling.icons
local borders = USER.styling.borders.default

local border = {
    { borders.tl, "FloatBorder" },
    { borders.t, "FloatBorder" },
    { borders.tr, "FloatBorder" },
    { borders.r, "FloatBorder" },
    { borders.br, "FloatBorder" },
    { borders.b, "FloatBorder" },
    { borders.bl, "FloatBorder" },
    { borders.l, "FloatBorder" },
}

-- List of servers for installation
local servers = {
    "bashls",
    "cssls",
    "cssmodules_ls",
    "clangd",
    "emmet_language_server",
    "eslint",
    "intelephense",
    "jsonls",
    "powershell_es",
    "pyright",
    "ruff",
    "lemminx",
    "lua_ls",
    "sqlls",
    "ts_ls",
    "vimls",
    "yamlls",
    "taplo",
}

-- Files to look for when searching for project root dir
local root_files = {
    "selene.toml",
    "selene.yml",
    "stylua.toml",
    ".git",
    ".luarc.json",
    ".luacheckrc",
    "Makefile",
    ".nvim",
    ".stylua.toml",
    ".eslintrc.js",
    "node_modules",
}

return {
    {
        -- Configs for the Nvim LSP client (:help lsp).
        "neovim/nvim-lspconfig",
        dependencies = {
            -- Portable package manager for Neovim that runs everywhere Neovim runs. Easily install and manage LSP
            -- servers, DAP servers, linters, and formatters. :help mason.nvim
            "williamboman/mason.nvim",
            -- Install or upgrade all of your third-party tools.
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            -- mason-lspconfig bridges mason.nvim with the lspconfig plugin - making it easier to use both plugins
            -- together. :help mason-lspconfig.nvim
            "williamboman/mason-lspconfig.nvim",
            -- null-ls.nvim reloaded / Use Neovim as a language server to inject LSP diagnostics, code actions, and more
            -- via Lua.
            "nvimtools/none-ls.nvim",
            -- A small Neovim plugin that provides a command for LSP renaming with immediate visual feedback thanks to
            -- Neovim's command preview feature.
            "smjonas/inc-rename.nvim",
            -- A simple statusline/winbar component that uses LSP to show your current code context. Named after the
            -- Indian satellite navigation system.
            "SmiteshP/nvim-navic",
            -- A pretty window for previewing, navigating and editing your LSP locations
            "DNLHC/glance.nvim",
            -- VSCode 💡 for neovim's built-in LSP.
            "kosayoda/nvim-lightbulb",
            -- Fully customizable previewer for LSP code actions
            "aznhe21/actions-preview.nvim",
        },
        config = function()
            -- Setup language servers and null-ls
            require("plugins.lsp.config").setup(icons, border, root_files, servers)
            require("plugins.lsp.install").setup(servers)

            -- Setup lsp utilities
            require("plugins.lsp.inc-rename").init()
            require("plugins.lsp.glance").init(icons, borders)
            require("plugins.lsp.nvim-lightbulb").init(icons)
            require("plugins.lsp.actions-preview").init(icons, borders)
        end,
    },
}
