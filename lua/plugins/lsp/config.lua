local M = {}

local show_inlay_hints = false

local function handler_opts(border)
    return {
        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
        ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
    }
end

local function config_diagnostics(icons)
    vim.diagnostic.config({
        virtual_text = {
            source = "if_many", --"always" "if_many"
            spacing = 4,
            prefix = icons.lsp.diagnostics[1],
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
    })

    local signs = {
        Error = icons.lsp.error[1],
        Warn = icons.lsp.warn[1],
        Hint = icons.lsp.hint[1],
        Info = icons.lsp.info[1],
    }

    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, {
            text = icon,
            texthl = hl,
            numhl = hl,
        })
    end
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

    if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_set_option_value("formatexpr", "v:lua.vim.lsp.formatexpr()", { buf = bufnr })
    end

    if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(show_inlay_hints)
    end
end

local function setup_language_servers(lspconfig, servers, handler_opts, root_files)
    for _, name in ipairs(servers) do
        if name == "bashls" then
            lspconfig[name].setup({
                filetypes = { "makefile", "sh", "zsh" },
                on_attach = on_attach,
                capabilities = capabilities(),
                handlers = handler_opts,
            })
        elseif name == "emmet_language_server" then
            lspconfig[name].setup({
                filetypes = { "html", "php" },
                on_attach = on_attach,
                capabilities = capabilities(),
                handlers = handler_opts,
            })
        elseif name == "eslint" then
            lspconfig[name].setup({
                root_dir = lspconfig.util.root_pattern(root_files),
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
                handlers = handler_opts,
            })
        elseif name == "intelephense" then
            lspconfig[name].setup({
                init_options = {
                    licenceKey = vim.fn.expand("$HOME/intelephense/licence.txt"),
                },
                on_attach = on_attach,
                capabilities = capabilities(),
                handlers = handler_opts,
            })
        elseif name == "omnisharp" then
            local install_path = vim.fn.stdpath("data") .. "/mason/packages"
            local cmd = USER.omni_mono and "mono" or "dotnet"
            local path = USER.omni_mono and install_path .. "/omnisharp-mono/omnisharp/OmniSharp.exe"
                or install_path .. "/omnisharp/OmniSharp.dll"
            lspconfig[name].setup({
                -- use_modern_net = user.omni_mono == false and true or false
                on_new_config = function(config)
                    config.cmd = {
                        cmd,
                        path,
                        "--languageserver",
                        "--hostPID",
                        tostring(vim.fn.getpid()),
                    }
                end,
                on_attach = on_attach,
                capabilities = capabilities(),
                handlers = handler_opts,
            })
        elseif name == "lua_ls" then
            -- Make the server aware of Neovim runtime files when editing Neovim config
            local library = vim.fn.getcwd() == vim.fn.stdpath("config") and vim.api.nvim_get_runtime_file("", true)
                or nil
            lspconfig[name].setup({
                root_dir = lspconfig.util.root_pattern(root_files),
                settings = {
                    Lua = {
                        telemetry = {
                            enable = false,
                        },
                        format = {
                            enable = false,
                        },
                        hint = {
                            enable = show_inlay_hints,
                        },
                        workspace = {
                            library = library,
                        },
                    },
                },
                on_attach = on_attach,
                capabilities = capabilities(),
                handlers = handler_opts,
            })
        elseif name == "ts_ls" then
            lspconfig[name].setup({
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
                handlers = handler_opts,
            })
        else
            lspconfig[name].setup({
                on_attach = on_attach,
                capabilities = capabilities(),
                handlers = handler_opts,
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
    config_diagnostics(icons)
    setup_language_servers(lspconfig, servers, handler_opts(border), root_files)
    require("plugins.lsp.null-ls").setup(border, root_files)
end

return M
