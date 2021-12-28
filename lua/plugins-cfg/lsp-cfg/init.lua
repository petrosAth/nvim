local M = {}
local ci = require("cosmetics").icon
local cb = require("cosmetics").border.table

-- List of servers for installation
M.servers = {
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

    -- Use lsp to populate cmp completions
    local cmp_nvim_lsp_loaded, cmp_lsp = pcall(require, "cmp_nvim_lsp")
    if cmp_nvim_lsp_loaded then
        capabilities = cmp_lsp.update_capabilities(capabilities)
    else
		print("lspconfig - capabilities: cmp-nvim-lsp missing")
        require("notify")("'plugins.lsp.init' - cmp_nvim_lsp not loaded", "error", { title = "Lspconfig" })
        return
    end

    -- Get window/workDoneProgress from lsp server
    local lsp_status_loaded, lsp_status = pcall(require, "lsp-status")
    if lsp_status_loaded then
        capabilities = vim.tbl_extend('keep', capabilities, lsp_status.capabilities)
    else
        require("notify")("'plugins.lsp.init' - lsp-status not loaded", "error", { title = "Lspconfig" })
        return
    end

    return capabilities
end

-- Configure lsp on_attach function
M.custom_on_attach = function(client, bufnr)
    -- LSP mappings
    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    -- local which_key_loaded, wk = pcall(require, "which-key")
    -- if which_key_loaded then
    --     wk.register({
    --         ["]d"] = { "<CMD>lua vim.diagnostic.goto_next({ border = borders })<CR>", "Next LSP diagnostic" },
    --         ["[d"] = { "<CMD>lua vim.diagnostic.goto_prev({ border = borders })<CR>", "Previous LSP diagnostic" },
    --         ["<Space>l"] = {
    --             name = "LSP",
    --             h = { "<CMD>lua vim.lsp.diagnostic.show_line_diagnostics({ border = borders })<CR>", "Line diagnostics" },
    --             R = { "<CMD>lua vim.lsp.buf.rename()<CR>",                                   "Rename symbol" },
    --             s = { "<CMD>lua vim.lsp.buf.signature_help()<CR>",                           "Signagture help" },
    --             a = { "<CMD>lua vim.lsp.buf.code_action()<CR>",                              "Code actions" },
    --             D = { "<CMD>lua vim.lsp.buf.declaration()<CR>",                              "Show declaration" },
    --             r = { "<CMD>lua vim.lsp.buf.references()<CR>",                               "Show references" },
    --             d = { "<CMD>lua vim.lsp.buf.definition()<CR>",                               "Show definition" },
    --             t = { "<CMD>lua vim.lsp.buf.type_definition()<CR>",                          "Show type definition" },
    --             i = { "<CMD>lua vim.lsp.buf.implementation()<CR>",                           "Show implementation" },
    --             K = { "<CMD>lua vim.lsp.buf.hover()<CR>",                                    "Hover symbol" }
    --         }
    --     },{
    --         mode    = "n",
    --         buffer  = bufnr
    --     })
    -- else
    -- require("notify")("'plugins.lsp.init' - which-key not loaded", "error", { title = "Lspconfig" })
    --     return
    -- end

    -- LSP status
    -- Register client for messages and set up buffer autocommands to update
    -- the statusline and the current function.
    local illuminate_loaded, illuminate = pcall(require, "illuminate")
    if illuminate_loaded then
        illuminate.on_attach(client)
    else
        require("notify")("'plugins.lsp.init' - illuminate not loaded", "error", { title = "Lspconfig" })
        return
    end
    local lsp_status_loaded, lsp_status = pcall(require, "lsp-status")
    if lsp_status_loaded then
        lsp_status.on_attach(client)
    else
        require("notify")("'plugins.lsp.init' - lsp-status not loaded", "error", { title = "Lspconfig" })
        return
    end
end

return M
