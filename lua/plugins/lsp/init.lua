local icons = USER.styling.icons
local borders = USER.styling.borders.default

-- List of servers for installation
local servers = {
    "bashls",
    "cssls",
    "cssmodules_ls",
    "clangd",
    "emmet_ls",
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
        -- max_width = 80,
        border = opts.border or border,
    }
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- Configure lsp handlers
vim.diagnostic.config({
    virtual_text = {
        source = "if_many", --"always" "if_many"
        spacing = 4,
        prefix = icons.lsp.virtText[1],
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
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
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
}

return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            -- mason.nvim - Portable package manager for Neovim that runs everywhere Neovim runs. Easily install and manage LSP
            -- servers, DAP servers, linters, and formatters.
            { "williamboman/mason.nvim" },
            -- mason-tool-installer - Install and upgrade third party tools automatically
            { "WhoIsSethDaniel/mason-tool-installer.nvim" },
            -- mason-lspconfig.nvim - Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim
            { "williamboman/mason-lspconfig.nvim" },
            -- lsp_signature - LSP signature hint as you type
            { "ray-x/lsp_signature.nvim" },
            -- null-ls.nvim - Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
            { "jose-elias-alvarez/null-ls.nvim" },
            -- inc-rename.nvim - Incremental LSP rename command based on Neovim's command-preview feature
            { "smjonas/inc-rename.nvim" },
            -- j-hui/fidget.nvim - Standalone UI for nvim-lsp progress
            { "j-hui/fidget.nvim" },
            -- nvim-lightbulb - VSCode bulb for neovim's built-in LSP.
            { "kosayoda/nvim-lightbulb" },
            -- nvim-navic - Simple winbar/statusline plugin that shows your current code context
            { "SmiteshP/nvim-navic" },
        },
        config = function()
            -- Setup language servers and null-ls
            require("plugins.lsp.config").setup(icons, border, root_files, servers)
            require("plugins.lsp.install").setup(servers)

            -- Setup lsp utilities
            require("plugins.lsp.signature").setup(icons, border)
            require("plugins.lsp.navic").setup(icons)
            require("plugins.lsp.lightbulb").setup(icons)
            require("plugins.lsp.fidget").setup(icons)
            require("plugins.lsp.inc-rename").setup()
        end,
    },
}
