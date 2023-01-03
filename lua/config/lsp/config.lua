local M = {}

-- Configure lsp capabilities
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

    -- cmp-nvim-lsp
    -- Use lsp to populate cmp completions
    client_capabilities = require("cmp_nvim_lsp").default_capabilities(client_capabilities)

    return client_capabilities
end

-- Configure lsp on_attach function
local function on_attach(client, bufnr)
    if client.server_capabilities.documentFormattingProvider then
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
            local install_path = USER.data_path .. "/mason/packages"
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
            local library = vim.fn.getcwd() == USER.config_path and vim.api.nvim_get_runtime_file("", true) or nil
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
        vim.notify("lspconfig", "ERROR", { title = "Loading failed" })
        return
    end

    -- Set lspinfo window borders
    require("lspconfig.ui.windows").default_options.border = border

    require("config.lsp.mason").setup(icons, border)

    local loaded, mason_lspconfig = pcall(require, "mason-lspconfig")
    if not loaded then
        vim.notify("mason-lspconfig", "ERROR", { title = "Loading failed" })
        return
    end

    mason_lspconfig.setup()

    setup_language_servers(lspconfig, servers, root_files)

    require("config.lsp.null-ls").setup(border, root_files)
end

return M
