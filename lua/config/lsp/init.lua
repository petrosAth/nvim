local M = {}
local icons = USER.styling.icons
local borders = USER.styling.borders.default

-- List of servers for installation
M.servers = {
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
M.root_files = {
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

-- Configure lsp capabilities
function M.capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
    }
    capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = {
            "documentation",
            "detail",
            "additionalTextEdits",
        },
    }

    -- cmp-nvim-lsp
    -- Use lsp to populate cmp completions
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    return capabilities
end

-- Configure lsp on_attach function
function M.on_attach(client, bufnr)
    if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")
    end
end

function M.setup()
    require("config.lsp.null-ls-config").setup(root_files, border)
    require("config.lsp.mason-tool-installer-config").setup()
    require("config.lsp.nvim-navic-config").setup(icons)
    require("config.lsp.nvim-lightbulb-config").setup(icons)
    require("config.lsp.fidget-config").setup(icons)
    require("config.lsp.inc-rename").setup()
end

return M
