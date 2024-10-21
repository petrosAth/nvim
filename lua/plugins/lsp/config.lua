local M = {}

local show_inlay_hints = false

local function capabilities()
    local client_caps = vim.lsp.protocol.make_client_capabilities()
    client_caps.textDocument.completion.completionItem.snippetSupport = true
    client_caps.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
    }
    client_caps.textDocument.completion.completionItem.resolveSupport = {
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
    end
    client_caps = cmp_nvim_lsp.default_capabilities(client_caps)

    return client_caps
end

local on_attach = function(client, bufnr)
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

local function setup_language_servers(lspconfig, servers, root_files)
    for _, name in ipairs(servers) do
        if name == "bashls" then
            lspconfig[name].setup({
                filetypes = { "makefile", "sh", "zsh" },
                on_attach = on_attach,
                capabilities = capabilities(),
            })
        elseif name == "emmet_language_server" then
            lspconfig[name].setup({
                filetypes = { "html", "php" },
                on_attach = on_attach,
                capabilities = capabilities(),
            })
        elseif name == "eslint" then
            lspconfig[name].setup({
                root_dir = lspconfig.util.root_pattern(root_files),
                on_attach = on_attach,
                capabilities = capabilities(),
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
            })
        elseif name == "intelephense" then
            lspconfig[name].setup({
                init_options = {
                    licenceKey = vim.fn.expand("$HOME/intelephense/licence.txt"),
                },
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
            })
        else
            lspconfig[name].setup({
                on_attach = on_attach,
                capabilities = capabilities(),
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
    -- Set lspinfo window borders
    require("lspconfig.ui.windows").default_options.border = border

    require("plugins.lsp.mason").setup(icons, border)
    require("plugins.lsp.mason-lspconfig").setup()

    setup_language_servers(lspconfig, servers, root_files)

    require("plugins.lsp.null-ls").setup(border, root_files)
end

return M
