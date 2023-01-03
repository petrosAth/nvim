local M = {}
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

function M.setup()
    -- Setup language servers and null-ls
    require("config.lsp.config").setup(icons, border, root_files, servers)
    require("config.lsp.install").setup(servers)

    -- Setup lsp utilities
    require("config.lsp.signature").setup(icons, border)
    require("config.lsp.navic").setup(icons)
    require("config.lsp.lightbulb").setup(icons)
    require("config.lsp.fidget").setup(icons)
    require("config.lsp.inc-rename").setup()
end

return M
