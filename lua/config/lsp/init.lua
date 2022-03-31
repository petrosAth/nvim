local M = {}
local ci = require("styling").icon
local cb = require("styling").border.box

-- List of servers for installation
M.servers = {
    "bashls",
    "cssls",
    "clangd",
    "html",
    "omnisharp",
    "powershell_es",
    "pyright",
    "sumneko_lua"
}

-- Borders for LSP floating windows
local border = {
    { "",                 },
    { "",                 },
    { "",                 },
    { cb.r, "FloatBorder" },
    { "",                 },
    { "",                 },
    { "",                 },
    { cb.l, "FloatBorder" },
}
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or border
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- Configure lsp handlers
vim.diagnostic.config({
    virtual_text = {
        source = "if_many",  --"always" "if_many"
        spacing = 4,
        prefix = "●", --"●" "▎" ""
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})

-- Set diagnostic signs
local signs = { Error = ci.error[1], Warn = ci.warn[1], Hint = ci.hint[1], Info = ci.info[1], }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl, })
end

-- Configure lsp capabilities
function M.custom_capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    -- cmp-nvim-lsp
    -- Use lsp to populate cmp completions
    local cmp_lsp = require("cmp_nvim_lsp")
    capabilities = cmp_lsp.update_capabilities(capabilities)

    -- lsp-status.nvim
    -- Get window/workDoneProgress from lsp server
    local lsp_status = require("lsp-status")
    capabilities = vim.tbl_extend('keep', capabilities, lsp_status.capabilities)

    return capabilities
end

-- Configure lsp on_attach function
function M.custom_on_attach(client, bufnr)
    -- aerial.nvim
    require("aerial").on_attach(client, bufnr)

    -- lsp-status.nvim
    -- Register client for messages and set up buffer autocommands to update
    -- the statusline and the current function.
    require("lsp-status").on_attach(client)
end

return M
