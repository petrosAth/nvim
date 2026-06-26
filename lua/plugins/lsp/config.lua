local M = {}

local function handler_opts(border)
    local opts = {
        max_width = 100,
        max_height = 14,
        border = border,
    }

    local hover, signature_help = vim.lsp.buf.hover, vim.lsp.buf.signature_help
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.lsp.buf.hover = function() return hover(opts) end
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.lsp.buf.signature_help = function() return signature_help(opts) end
end

local function config_diagnostics(icons, border)
    vim.diagnostic.config({
        severity_sort = true,
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = icons.lsp.error[1],
                [vim.diagnostic.severity.HINT] = icons.lsp.hint[1],
                [vim.diagnostic.severity.INFO] = icons.lsp.info[1],
                [vim.diagnostic.severity.WARN] = icons.lsp.warn[1],
            },
            texthl = {
                [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
                [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
                [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
                [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
            },
            numhl = {
                [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
                [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
                [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
                [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
            },
        },
        underline = true,
        update_in_insert = false,
        virtual_text = {
            source = true,
            spacing = 4,
            prefix = icons.lsp.diagnostics[5],
        },
        float = {
            source = true,
            prefix = string.format("%s ", icons.lsp.diagnostics[1]),
            border = border,
        },
    })
end

local function capabilities()
    local client_capabilities = vim.lsp.protocol.make_client_capabilities()
    client_capabilities.textDocument.completion.completionItem.snippetSupport = true
    client_capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
    }
    client_capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = {
            "documentation",
            "detail",
            "additionalTextEdits",
        },
    }

    -- Use lsp to populate cmp completions
    local loaded, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    if loaded then
        client_capabilities = cmp_nvim_lsp.default_capabilities(client_capabilities)
    else
        USER.loading_error_msg("cmp_nvim_lsp")
    end

    return client_capabilities
end

local function on_attach(client, bufnr)
    if client:supports_method("textDocument/documentSymbol") then
        require("plugins.lsp.nvim-navic").setup(client, bufnr)
    end

    if client.server_capabilities.semanticTokensProvider and not USER.lsp.enable_semantic_tokens then
        client.server_capabilities.semanticTokensProvider = nil
    end

    if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_set_option_value("formatexpr", "v:lua.vim.lsp.formatexpr()", { buf = bufnr })
    end

    if client.server_capabilities.inlayHintProvider then vim.lsp.inlay_hint.enable(USER.lsp.show_inlay_hints) end
end

-- Build the set of servers that ship a dedicated config under `servers/`. Each
-- such file returns `function(shared) -> config_table`; servers without one
-- fall through to the shared default below. Discovery walks the runtimepath so
-- a syntax error in a server file surfaces loudly instead of being swallowed.
local function override_servers()
    local overrides = {}
    for _, path in ipairs(vim.api.nvim_get_runtime_file("lua/plugins/lsp/servers/*.lua", true)) do
        overrides[vim.fn.fnamemodify(path, ":t:r")] = true
    end
    return overrides
end

local function setup_language_servers(lspconfig, servers, handlers, root_files)
    local shared = {
        on_attach = on_attach,
        capabilities = capabilities,
        handlers = handlers,
        lspconfig = lspconfig,
        root_files = root_files,
    }
    local overrides = override_servers()

    for _, name in ipairs(servers) do
        local config
        if overrides[name] then
            config = require("plugins.lsp.servers." .. name)(shared)
        else
            config = {
                on_attach = on_attach,
                capabilities = capabilities(),
                handlers = handlers,
            }
        end
        vim.lsp.config(name, config)
    end
end

function M.setup(icons, border, root_files, servers)
    local loaded, lspconfig = pcall(require, "lspconfig")
    if not loaded then
        USER.loading_error_msg("lspconfig")
        return
    end

    require("plugins.lsp.mason").setup(icons, border)
    require("plugins.lsp.mason-lspconfig").setup()
    config_diagnostics(icons, border)
    setup_language_servers(lspconfig, servers, handler_opts(border), root_files)
    require("plugins.lsp.null-ls").setup(border, root_files)
end

return M
