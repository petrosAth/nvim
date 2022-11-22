local M = {}
local i = USER.styling.icons
local b = USER.styling.borders.default

-- List of servers for installation
M.servers = {
    "bashls",
    "cssls",
    "clangd",
    "emmet_ls",
    "ltex",
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

-- Files to look for when searching for project root dir
M.root_files = {
    "selene.toml",
    "selene.yml",
    "stylua.toml",
    ".git",
    ".luarc.json",
    ".luacheckrc",
    ".nvim",
    ".stylua.toml",
}

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
    if client.server_capabilities.documentSymbolProvider then
        require("nvim-navic").attach(client, bufnr)
    end
    if client.name == "ltex" then
        require("ltex_extra").setup({
            load_langs = { "en-US" }, -- table <string> : languages for witch dictionaries will be loaded
            init_check = true, -- boolean : whether to load dictionaries on startup
            path = ".nvim/ltex", -- string : path to store dictionaries. Relative path uses current working directory
            log_level = "none", -- string : "none", "trace", "debug", "info", "warn", "error", "fatal"
        })
    end
end
return M
