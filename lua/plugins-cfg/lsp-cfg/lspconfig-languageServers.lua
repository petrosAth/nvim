local lspconfig = require("lspconfig")
local lsp_cfg = require("plugins-cfg.lsp-cfg")
local edit_mode = require("options").nvim_edit_mode

-- Get language server list for installation
local servers = lsp_cfg.servers

local custom_capabilities = lsp_cfg.custom_capabilities()
local custom_on_attach = lsp_cfg.custom_on_attach

-- Setup language servers
for _, name in ipairs(servers) do
    if name == "omnisharp" then--{{{
        local pid = vim.fn.getpid()
        local omnisharp_bin = vim.fn.trim(vim.fn.system("which omnisharp"))
        lspconfig[name].setup({
            on_attach = custom_on_attach,
            capabilities = custom_capabilities,
            cmd = { omnisharp_bin, "--languageserver", "--hostPID", tostring(pid) },
        })--}}}
    elseif name == "powershell_es" then--{{{
        lspconfig[name].setup({
            on_attach = custom_on_attach,
            capabilities = custom_capabilities,
            bundle_path = "C:\\Users\\petrosAth\\.vscode\\extensions\\ms-vscode.powershell-2021.10.2\\modules",
        })--}}}
    elseif name == "sumneko_lua" then--{{{
        if edit_mode then
            --{{{ add nvim and nvim-data folders in workspace library
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
            add(CONFIG_PATH .. "\\*")

            -- add plugins
            -- if you're not using packer, then you might need to change the paths below
            add(PACKER_PATH .. "\\opt\\*")
            add(PACKER_PATH .. "\\start\\*")

            lspconfig[name].setup({
                on_new_config = function(config, root)
                    local libs = vim.tbl_deep_extend("force", {}, nvim_library)
                    libs[root] = nil
                    config.settings.Lua.workspace.library = libs
                    return config
                end,
                on_attach = custom_on_attach,
                capabilities = custom_capabilities,
                settings = {
                    Lua = {
                        runtime = {
                            version = "LuaJIT",
                            path = runtime_path,
                        },
                        diagnostics = {
                            globals = { "vim", "use" },
                        },
                        workspace = {
                            library = nvim_library,
                            maxPreload = 10000,
                            preloadFileSize = 10000,
                            checkThirdParty = false,
                        },
                        telemetry = {
                            enable = false,
                        },
                    },
                }
            })--}}}
        else
            --{{{ add only project root folder in workspace library
            lspconfig[name].setup({
                on_attach = custom_on_attach,
                capabilities = custom_capabilities,
                settings = {
                    Lua = {
                        runtime = {
                            version = "Lua 5.4",
                        },
                        telemetry = {
                            enable = false,
                        },
                    },
                }
            })--}}}
        end--}}}
    else
        lspconfig[name].setup({
            on_attach = custom_on_attach,
            capabilities = custom_capabilities,
        })
    end
end
