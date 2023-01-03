local b = USER.styling.borders.default

local lspconfig = require("lspconfig")

-- Set lspinfo window borders
require("lspconfig.ui.windows").default_options.border = { b.tl, b.t, b.tr, b.r, b.br, b.b, b.bl, b.l }

require("mason-lspconfig").setup()

local lsp_cfg = require("config.lsp")
local servers = lsp_cfg.servers
local capabilities = lsp_cfg.capabilities()
local on_attach = lsp_cfg.on_attach

-- Setup language servers
for _, name in ipairs(servers) do
    if name == "bashls" then
        lspconfig[name].setup({
            filetypes = { "makefile", "sh", "zsh" },
            on_attach = on_attach,
            capabilities = capabilities,
        })
    elseif name == "emmet_ls" then
        lspconfig[name].setup({
            filetypes = { "html" },
            on_attach = on_attach,
            capabilities = capabilities,
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
            capabilities = capabilities,
        })
    elseif name == "sumneko_lua" then
        -- Make the server aware of Neovim runtime files when editing Neovim config
        local library = vim.fn.getcwd() == USER.config_path and vim.api.nvim_get_runtime_file("", true) or nil
        lspconfig[name].setup({
            root_dir = lspconfig.util.root_pattern(lsp_cfg.root_files),
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
            capabilities = capabilities,
        })
    else
        lspconfig[name].setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })
    end
end
