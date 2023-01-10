local M = {}

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

local function on_attach(client, bufnr)
    local server_caps = client.server_capabilities
    -- if server_caps.semanticTokensProvider then
    --     server_caps.semanticTokensProvider = false
    -- end
    if server_caps.documentFormattingProvider then
        vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")
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
        elseif name == "emmet_ls" then
            lspconfig[name].setup({
                filetypes = { "html" },
                on_attach = on_attach,
                capabilities = capabilities(),
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
        elseif name == "sumneko_lua" then
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
                        workspace = {
                            library = library,
                        },
                    },
                },
                on_attach = on_attach,
                capabilities = capabilities(),
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
