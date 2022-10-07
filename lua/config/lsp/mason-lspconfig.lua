local b = require("styling").borders.default

-- Get language server list for installation
local lsp_cfg = require("config.lsp")
local servers = lsp_cfg.servers

require("mason-lspconfig").setup({
    -- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer@nightly", "sumneko_lua" }
    -- This setting has no relation with the `automatic_installation` setting.
    -- ensure_installed = servers,
    -- automatic_installation = true,
})

local lspconfig = require("lspconfig")
local custom_capabilities = lsp_cfg.custom_capabilities()
local custom_on_attach = lsp_cfg.custom_on_attach

require('lspconfig.ui.windows').default_options.border = { b.tl, b.t, b.tr, b.r, b.br, b.b, b.bl, b.l }

-- Setup language servers
for _, name in ipairs(servers) do
    if name == "bashls" then
        lspconfig[name].setup({
            filetypes = { "sh", "zsh", "makefile" }
        })
    elseif name == "omnisharp" then
        local install_path = vim.fn.stdpath("data") .. "/mason/packages"
        local cmd = _G.user.omni_mono and "mono" or "dotnet"
        local path = _G.user.omni_mono and install_path .. "/omnisharp-mono/omnisharp/OmniSharp.exe" or install_path .. "/omnisharp/OmniSharp.dll"
        lspconfig[name].setup({
            -- use_modern_net = _G.user.omni_mono == false and true or false
            on_new_config = function(config)
                config.cmd = {
                    cmd,
                    path,
                    "--languageserver",
                    "--hostPID",
                    tostring(vim.fn.getpid()),
                }
            end,
        })
    elseif name == "sumneko_lua" then
        if _G.user.dev_mode then
            -- add nvim and nvim-data folders in workspace library
            local nvim_library = {}
            local runtime_path = vim.split(package.path, ";")

            table.insert(runtime_path, "lua/?.lua")
            table.insert(runtime_path, "lua/?/init.lua")

            local function add(lib)
                for _, p in pairs(vim.fn.expand(lib, false, true)) do
                    p = vim.loop.fs_realpath(p)
                    nvim_library[p] = true
                end
            end

            -- add runtime
            add("$VIMRUNTIME")

            -- add your config
            add(_G.user.config_path .. "/*")

            -- add plugins
            -- if you're not using packer, then you might need to change the paths below
            add(_G.user.packer_path .. "/opt/*")
            add(_G.user.packer_path .. "/start/*")

            lspconfig[name].setup({
                on_new_config = function(config, root)
                    local libs = vim.tbl_deep_extend("force", {}, nvim_library)
                    libs[root] = nil
                    config.settings.Lua.workspace.library = libs
                    return config
                end,
                settings = {
                    Lua = {
                        runtime = {
                            -- version = "Lua 5.4",
                            version = "LuaJIT",
                            path = runtime_path,
                        },
                        diagnostics = {
                            globals = { "vim", "use" },
                        },
                        workspace = {
                            -- library = vim.api.nvim_get_runtime_file("", true),
                            library = nvim_library,
                            maxPreload = 10000,
                            preloadFileSize = 10000,
                            checkThirdParty = false,
                        },
                        telemetry = {
                            enable = false,
                        },
                        format = {
                            enable = false,
                        },
                    },
                },
                on_attach = custom_on_attach,
                capabilities = custom_capabilities
            })
        else
            lspconfig[name].setup({
                -- add only project root folder in workspace library
                settings = {
                    Lua = {
                        runtime = {
                            version = "Lua 5.4",
                        },
                        telemetry = {
                            enable = false,
                        },
                        format = {
                            enable = false,
                        },
                    },
                },
                on_attach = custom_on_attach,
                capabilities = custom_capabilities
            })
        end
    else
        lspconfig[name].setup({
            on_attach = custom_on_attach,
            capabilities = custom_capabilities,
        })
    end
end
