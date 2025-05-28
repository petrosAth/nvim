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
    if not loaded then
        USER.loading_msg("cmp_nvim_lsp")
        client_capabilities = cmp_nvim_lsp.default_capabilities(client_capabilities)
    end

    return client_capabilities
end

local function on_attach(client, bufnr)
    if client.supports_method("textDocument/documentSymbol") then
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

local function setup_language_servers(lspconfig, servers, handlers, root_files)
    for _, name in ipairs(servers) do
        if name == "bashls" then
            vim.lsp.config(name, {
                filetypes = { "makefile", "sh", "zsh" },
                on_attach = on_attach,
                capabilities = capabilities(),
                handlers = handlers,
            })
        elseif name == "emmet_language_server" then
            vim.lsp.config(name, {
                filetypes = {
                    "css",
                    "eruby",
                    "html",
                    "htmldjango",
                    "javascriptreact",
                    "less",
                    "php",
                    "pug",
                    "sass",
                    "scss",
                    "typescriptreact",
                    "htmlangular",
                },
                on_attach = on_attach,
                capabilities = capabilities(),
                handlers = handlers,
            })
        elseif name == "eslint" then
            vim.lsp.config(name, {
                root_dir = function(bufnr, on_dir)
                    local fname = vim.api.nvim_buf_get_name(bufnr)
                    on_dir(lspconfig.util.root_pattern(root_files)(fname))
                end,
                settings = {
                    codeAction = {
                        disableRuleComment = {
                            enable = true,
                            location = "separateLine",
                        },
                        showDocumentation = {
                            enable = true,
                        },
                    },
                    codeActionOnSave = {
                        enable = false,
                        mode = "all",
                    },
                    experimental = {
                        useFlatConfig = false,
                    },
                    format = true,
                    nodePath = "",
                    onIgnoredFiles = "off",
                    packageManager = "npm",
                    problems = {
                        shortenToSingleLine = false,
                    },
                    quiet = false,
                    rulesCustomizations = {},
                    run = "onType",
                    useESLintClass = false,
                    validate = "on",
                    workingDirectory = {
                        mode = "location",
                    },
                },
                on_attach = on_attach,
                capabilities = capabilities(),
                handlers = handlers,
            })
        elseif name == "intelephense" then
            vim.lsp.config(name, {
                init_options = {
                    licenceKey = vim.fn.expand("$HOME/intelephense/licence.txt"),
                },
                on_attach = on_attach,
                capabilities = capabilities(),
                handlers = handlers,
            })
        elseif name == "lua_ls" then
            vim.lsp.config(name, {
                root_dir = function(bufnr, on_dir)
                    local fname = vim.api.nvim_buf_get_name(bufnr)
                    on_dir(lspconfig.util.root_pattern(root_files)(fname))
                end,
                settings = {
                    Lua = {
                        telemetry = {
                            enable = false,
                        },
                        format = {
                            enable = false,
                        },
                        hint = {
                            enable = true,
                        },
                    },
                },
                on_attach = on_attach,
                capabilities = capabilities(),
                handlers = handlers,
            })
        elseif name == "ruff" then
            vim.lsp.config(name, {
                init_options = {
                    settings = {
                        lint = {
                            preview = true,
                        },
                    },
                },
                on_attach = function(client, bufnr)
                    client.server_capabilities.document_formatting = false
                    client.server_capabilities.document_range_formatting = false
                    on_attach(client, bufnr)
                end,
                capabilities = capabilities(),
                handlers = handlers,
            })
        elseif name == "ts_ls" then
            vim.lsp.config(name, {
                init_options = {
                    preferences = {
                        includeInlayParameterNameHints = "all",
                        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                        includeInlayFunctionParameterTypeHints = true,
                        includeInlayVariableTypeHints = true,
                        includeInlayPropertyDeclarationTypeHints = true,
                        includeInlayFunctionLikeReturnTypeHints = true,
                        includeInlayEnumMemberValueHints = true,
                        importModuleSpecifierPreference = "non-relative",
                    },
                },
                on_attach = function(client, bufnr)
                    client.server_capabilities.document_formatting = false
                    client.server_capabilities.document_range_formatting = false
                    on_attach(client, bufnr)
                end,
                capabilities = capabilities(),
                handlers = handlers,
            })
        else
            vim.lsp.config(name, {
                on_attach = on_attach,
                capabilities = capabilities(),
                handlers = handlers,
            })
        end
    end
end

function M.setup(icons, border, root_files, servers)
    local loaded, lspconfig = pcall(require, "lspconfig")
    if not loaded then
        USER.loading_msg("lspconfig")
        return
    end

    require("plugins.lsp.mason").setup(icons, border)
    require("plugins.lsp.mason-lspconfig").setup()
    config_diagnostics(icons, border)
    setup_language_servers(lspconfig, servers, handler_opts(border), root_files)
    require("plugins.lsp.null-ls").setup(border, root_files)
end

return M
