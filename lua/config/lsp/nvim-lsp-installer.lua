vim.cmd([[
    augroup LSP_INSTALLER_BORDERS
        autocmd!
        autocmd FileType lsp-installer lua
                \ local b = require("styling").border.default
                \ vim.api.nvim_win_set_config(0, { border = { b.tl, b.t, b.tr, b.r, b.br, b.b, b.bl, b.l } })
                \ vim.opt.cursorline = true
    augroup END
]])

local lsp_cfg = require("config.lsp")
local lsp_installer = require("nvim-lsp-installer")
local i = require("styling").icons

-- Get language server list for installation
local servers = lsp_cfg.servers

lsp_installer.setup({
    ensure_installed = servers,
    ui = {
        icons = {
            server_installed = i.done[1],
            server_pending = i.pending[1],
            server_uninstalled = i.delete[1],
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
})
