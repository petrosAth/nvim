local icons = USER.styling.icons
local borders = USER.styling.borders.default

-- List of servers for installation
local servers = {
    "bashls",
    "cssls",
    "cssmodules_ls",
    "clangd",
    "emmet_ls",
    "eslint",
    "omnisharp",
    "powershell_es",
    "pyright",
    "sumneko_lua",
    "tsserver",
    "vimls",
    "yamlls",
    "taplo",
}

-- Borders for LSP floating windows
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
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts = {
        border = opts.border or border,
    }
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- Configure lsp handlers
vim.diagnostic.config({
    virtual_text = {
        source = "if_many", --"always" "if_many"
        spacing = 4,
        prefix = icons.lsp.diagnostics[1],
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})

-- Set diagnostic signs
local signs = {
    Error = icons.lsp.error[1],
    Warn = icons.lsp.warn[1],
    Hint = icons.lsp.hint[1],
    Info = icons.lsp.info[1],
}
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, {
        text = icon,
        texthl = hl,
        numhl = hl,
    })
end

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
        -- nvim-lspconfig
        -- Configs for the Nvim LSP client (:help lsp).
        "neovim/nvim-lspconfig",
        dependencies = {
            -- mason.nvim
            -- Portable package manager for Neovim that runs everywhere Neovim runs. Easily install and manage LSP
            -- servers, DAP servers, linters, and formatters. :help mason.nvim
            "williamboman/mason.nvim",
            -- mason-tool-installer
            -- Install or upgrade all of your third-party tools.
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            -- mason-lspconfig.nvim
            -- mason-lspconfig bridges mason.nvim with the lspconfig plugin - making it easier to use both plugins
            -- together. :help mason-lspconfig.nvim
            "williamboman/mason-lspconfig.nvim",
            -- lsp_signature.nvim
            -- Show function signature when you type
            "ray-x/lsp_signature.nvim",
            -- null-ls.nvim
            -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.
            "jose-elias-alvarez/null-ls.nvim",
            -- inc-rename.nvim
            -- A small Neovim plugin that provides a command for LSP renaming with immediate visual feedback thanks to
            -- Neovim's command preview feature.
            "smjonas/inc-rename.nvim",
            -- fidget.nvim
            -- Standalone UI for nvim-lsp progress. Eye candy for the impatient.
            "j-hui/fidget.nvim",
            -- lspsaga.nvim
            -- A lightweight LSP plugin based on Neovim's built-in LSP with a highly performant UI.
            {
                "glepnir/lspsaga.nvim",
                event = "BufRead",
                dependencies = {
                    -- Nvim-web-devicons
                    -- A lua fork of vim-devicons. This plugin provides the same icons as well as colors for each icon.
                    "nvim-tree/nvim-web-devicons",
                },
            },
            -- glance.nvim
            -- A pretty window for previewing, navigating and editing your LSP locations
            { "DNLHC/glance.nvim" },
        },
        config = function()
            -- Setup language servers and null-ls
            require("plugins.lsp.config").setup(icons, border, root_files, servers)
            require("plugins.lsp.install").setup(servers)

            -- Setup lsp utilities
            require("plugins.lsp.signature").setup(icons, border)
            require("plugins.lsp.fidget").setup(icons)
            require("plugins.lsp.inc-rename").setup()
            require("plugins.lsp.lspsaga").setup(icons)
            require("plugins.lsp.glance").setup(icons, borders)
        end,
    },
}
