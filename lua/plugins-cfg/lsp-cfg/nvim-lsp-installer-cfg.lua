local lsp_cfg = require("plugins-cfg.lsp-cfg")
local lsp_installer = require("nvim-lsp-installer")
local edit_mode = require("options").nvim_edit_mode
local ci = require("cosmetics").icon

-- Disables the self-closing behavior of the window
-- vim.cmd([[
--     augroup LSP_INSTALLER_WIN
--         function! s:deregister_autocmd() abort
--             autocmd TextChanged <buffer> ++once autocmd! LspInstallerWindow
--         endfunction
--         autocmd FileType lsp-installer wincmd L | call s:deregister_autocmd()
--     augroup END
-- ]])

-- Get language server list for installation
local servers = lsp_cfg.servers

local custom_capabilities = lsp_cfg.custom_capabilities()
local custom_on_attach = lsp_cfg.custom_on_attach

lsp_installer.settings {
    ui = {
        icons = {
            server_installed = ci.done[1] .. " ",
            server_pending = ci.pending[1] .. " ",
            server_uninstalled = ci.delete[1] .. " ",
        },
        keymaps = {
            toggle_server_expand = "<CR>",
            install_server = "i",
            update_server = "u",
            update_all_servers = "U",
            uninstall_server = "D",
        },
    },

    -- Controls to which degree logs are written to the log file. It's useful to set this to vim.log.levels.DEBUG when
    -- debugging issues with server installations.
    log_level = vim.log.levels.INFO,

    -- Limit for the maximum amount of servers to be installed at the same time. Once this limit is reached, any further
    -- servers that are requested to be installed will be put in a queue.
    max_concurrent_installers = 4,
}

-- Auto install list of servers
for _, name in pairs(servers) do
	local ok, server = lsp_installer.get_server(name)
	-- Check that the server is supported in nvim-lsp-installer
	if ok then
		if not server:is_installed() then
			print("Installing " .. name)
			server:install()
		end
	end
end

-- Set default server options
lsp_installer.on_server_ready(function(server)
	-- Specify the default options which we'll use for pyright and solargraph
	-- Note: These are automatically setup from nvim-lspconfig.
        -- See https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
	local default_opts = {
		on_attach = custom_on_attach,
		capabilities = custom_capabilities,
	}

	-- Now we'll create a server_opts table where we'll specify our custom LSP server configuration
	local server_opts = {
        --[[
        ["omnisharp"] = function()
            local pid = vim.fn.getpid()
			local omnisharp_bin = vim.fn.trim(vim.fn.system("which omnisharp"))

            default_opts.cmd = {
                omnisharp_bin,
                "--languageserver",
                "--hostPID",
                tostring(pid)
            }

            default_opts.on_attach = custom_on_attach
            default_opts.capabilities = custom_capabilities

            return default_opts
        end,
        ]]
        ["sumneko_lua"] = function()

            if edit_mode then
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
                add(CONFIG_PATH .. "\\*")

                -- add plugins
                -- if you're not using packer, then you might need to change the paths below
                add(PACKER_PATH .. "\\opt\\*")
                add(PACKER_PATH .. "\\start\\*")

                default_opts.on_new_config = function(config, root)
                    local libs = vim.tbl_deep_extend("force", {}, nvim_library)
                    libs[root] = nil
                    config.settings.Lua.workspace.library = libs
                    return config
                end

                default_opts.settings = {
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
                    },
                }
            else
                -- add only project root folder in workspace library
                default_opts.settings = {
                    Lua = {
                        runtime = {
                            version = "Lua 5.4",
                        },
                        telemetry = {
                            enable = false,
                        },
                    },
                }
            end

            default_opts.on_attach = custom_on_attach
            default_opts.capabilities = custom_capabilities

            return default_opts
        end
	}

	-- We check to see if any custom server_opts exist for the LSP server, if so, load them, if not, use our default_opts
	server:setup(server_opts[server.name] and server_opts[server.name]() or default_opts)
	vim.cmd([[ do User LspAttachBuffers ]])
end)
