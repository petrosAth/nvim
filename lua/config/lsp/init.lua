local M = {}
local i = PA.styling.icons
local b = PA.styling.borders.default

-- List of servers for installation
M.servers = {
    "bashls",
    "cssls",
    "clangd",
    "emmet_ls",
    -- "html",
    "omnisharp",
    "powershell_es",
    "pyright",
    "sumneko_lua",
    "tsserver",
}

-- Borders for LSP floating windows
local border = {
    { b.tl, "FloatBorder" },
    { b.t, "FloatBorder" },
    { b.tr, "FloatBorder" },
    { b.r, "FloatBorder" },
    { b.br, "FloatBorder" },
    { b.b, "FloatBorder" },
    { b.bl, "FloatBorder" },
    { b.l, "FloatBorder" },
}
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts = {
        max_width = 80,
        border = opts.border or border,
    }
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- Configure lsp handlers
vim.diagnostic.config({
    virtual_text = {
        source = "if_many", --"always" "if_many"
        spacing = 4,
        prefix = i.lsp.virtText[1],
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})

-- Set diagnostic signs
local signs = { Error = i.lsp.error[1], Warn = i.lsp.warn[1], Hint = i.lsp.hint[1], Info = i.lsp.info[1] }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Configure lsp capabilities
function M.capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    -- cmp-nvim-lsp
    -- Use lsp to populate cmp completions
    local cmp_lsp = require("cmp_nvim_lsp")
    capabilities = cmp_lsp.default_capabilities(capabilities)

    return capabilities
end

-- Configure lsp on_attach function
function M.on_attach(client, bufnr)
    if client.name == "cssls" then
        client.server_capabilities.documentFormattingProvider = true
        client.server_capabilities.documentRangeFormattingProvider = true
    end
end

return M
