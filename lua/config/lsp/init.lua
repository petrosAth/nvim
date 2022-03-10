local M = {}
local ci = require("cosmetics").icon
local cb = require("cosmetics").border.table

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

-- Borders for LSP popup windows
local borders = {
    { cb.tl, "FloatBorder" },
    { cb.t,  "FloatBorder" },
    { cb.tr, "FloatBorder" },
    { cb.r,  "FloatBorder" },
    { cb.br, "FloatBorder" },
    { cb.b,  "FloatBorder" },
    { cb.bl, "FloatBorder" },
    { cb.l,  "FloatBorder" },
}

-- Configure lsp handlers
-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = borders })
-- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = borders })
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
M.custom_on_attach = function(client, bufnr)
    -- LSP mappings
    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer
    -- See `:help vim.lsp.*` for documentation on any of the below functions

    -- which-key.nvim
    -- local wk = require("which-key")
    -- wk.register({
    --     ["]d"] = { "<CMD>lua vim.diagnostic.goto_next({ border = borders })<CR>", "Next LSP diagnostic" },
    --     ["[d"] = { "<CMD>lua vim.diagnostic.goto_prev({ border = borders })<CR>", "Previous LSP diagnostic" },
    --     ["<Space>l"] = {
    --         name = "LSP",
    --         h = { "<CMD>lua vim.lsp.diagnostic.show_line_diagnostics({ border = borders })<CR>", "Line diagnostics" },
    --         R = { "<CMD>lua vim.lsp.buf.rename()<CR>",                                   "Rename symbol" },
    --         s = { "<CMD>lua vim.lsp.buf.signature_help()<CR>",                           "Signagture help" },
    --         a = { "<CMD>lua vim.lsp.buf.code_action()<CR>",                              "Code actions" },
    --         D = { "<CMD>lua vim.lsp.buf.declaration()<CR>",                              "Show declaration" },
    --         r = { "<CMD>lua vim.lsp.buf.references()<CR>",                               "Show references" },
    --         d = { "<CMD>lua vim.lsp.buf.definition()<CR>",                               "Show definition" },
    --         t = { "<CMD>lua vim.lsp.buf.type_definition()<CR>",                          "Show type definition" },
    --         i = { "<CMD>lua vim.lsp.buf.implementation()<CR>",                           "Show implementation" },
    --         K = { "<CMD>lua vim.lsp.buf.hover()<CR>",                                    "Hover symbol" }
    --     }
    -- },{
    --     mode    = "n",
    --     buffer  = bufnr
    -- })

    -- aerial.nvim
    require("aerial").on_attach(client, bufnr)

    -- lsp-status.nvim
    -- Register client for messages and set up buffer autocommands to update
    -- the statusline and the current function.
    require("lsp-status").on_attach(client)
end

return M
