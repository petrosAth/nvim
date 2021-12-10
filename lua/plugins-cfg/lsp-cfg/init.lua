local M = {}
local ci = require("cosmetics").icon
local cb = require("cosmetics").border.table

-- List of servers for installation
M.servers = {
    -- "cssls",
    -- "clangd",
    -- "html",
    -- "omnisharp",
    -- "powershell_es",
    -- "pyright",
    -- "sumneko_lua"
}

-- Configure lsp handlers
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

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = borders })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = borders })
vim.diagnostic.config({
    virtual_text = {
        source = "if_many",  --"always" "if_many"
        spacing = 4,
        prefix = "●", --"●" "▎" ""
    },
    signs = true,
    underline = true,
    update_in_insert = true,
    severity_sort = true,
})

-- Set diagnostic signs
local signs = { Error = ci.error[1], Warn = ci.warn[1], Hint = ci.hint[1], Info = ci.info[1], }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl, })
end

-- HACK: Delete when fixed
-- Set diagnostic signs for telescope
local Tsigns = { Error = ci.error[1] .. " ", Warning = ci.warn[1] .. " ", Hint = ci.hint[1] .. " ", Information = ci.info[1] .. " ", }
for type, icon in pairs(Tsigns) do
    local hl = "LspDiagnosticsSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl, })
end

-- Configure line diagnostic popup
function M.show_line_diagnostics()
    local opts = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = borders,
        source = "if_many",
        prefix = "",
    }
    vim.diagnostic.open_float(nil, opts)
end

-- if cmp_nvim_lsp is enabled, populate capabilities
function M.custom_capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    -- Use lsp to populate cmp completions
    local cmp_nvim_lsp_loaded, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    if cmp_nvim_lsp_loaded then
        capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
    else
		print("lspconfig - capabilities: cmp-nvim-lsp missing")
    end

    -- Get window/workDoneProgress from lsp server
    local lsp_status_loaded, lsp_status = pcall(require, "lsp-status")
    if lsp_status_loaded then
        capabilities = vim.tbl_extend('keep', capabilities, lsp_status.capabilities)
    else
        print("lspconfig - capabilities: lsp-status missing")
    end

    return capabilities
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
M.custom_on_attach = function(client, bufnr)
	-- Set mappings
	local function map(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local ns_opts = { noremap=true, silent=true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
	map("n", "<Space>[",  "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", ns_opts)
	map("n", "<Space>]",  "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", ns_opts)
	map("n", "<Space>lh", "<cmd>lua require('plugins-cfg.lsp-cfg').show_line_diagnostics()<CR>", ns_opts)
	map("n", "<Space>lR", "<cmd>lua vim.lsp.buf.rename()<CR>", ns_opts)
	map("n", "<Space>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", ns_opts)
    map("n", "<Space>lD", "<cmd>lua vim.lsp.buf.declaration()<CR>", ns_opts)
	map("n", "<Space>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", ns_opts)
    map("n", "<Space>lr", "<cmd>lua vim.lsp.buf.references()<CR>", ns_opts)
	map("n", "<Space>ld", "<cmd>lua vim.lsp.buf.definition()<CR>", ns_opts)
	map("n", "<Space>lt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", ns_opts)
	map("n", "<Space>li", "<cmd>lua vim.lsp.buf.implementation()<CR>", ns_opts)

    -- Register client for messages and set up buffer autocommands to update
    -- the statusline and the current function.
    local lsp_status_loaded, lsp_status = pcall(require, "lsp-status")
    if lsp_status_loaded then
        lsp_status.on_attach(client)
    else
        print("lspconfig - on_attach: lsp-status missing")
    end
end

return M
