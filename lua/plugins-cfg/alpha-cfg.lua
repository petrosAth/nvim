vim.cmd([[
    augroup ALPHA
        autocmd!
        autocmd FileType alpha
            \ setlocal scrolloff=999 |
            \ lua vim.opt_local.fillchars = { vert = require("cosmetics").icon.nvim_ui.vert[1], eob = " " }
    augroup END
]])

local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")
local custom = "<cmd> lua require('plugins-cfg.telescope-cfg.customPickers')."

local header = {
    type = "text",
    val = {
        [[ ███╗  ██╗███████╗ █████╗ ██╗   ██╗██╗███╗   ███╗]],
        [[ ████╗ ██║██╔════╝██╔══██╗██║   ██║██║████╗ ████║]],
        [[ ██╔██╗██║█████╗  ██║  ██║╚██╗ ██╔╝██║██╔████╔██║]],
        [[ ██║╚████║██╔══╝  ██║  ██║ ╚████╔╝ ██║██║╚██╔╝██║]],
        [[ ██║ ╚███║███████╗╚█████╔╝  ╚██╔╝  ██║██║ ╚═╝ ██║]],
        [[ ╚═╝  ╚══╝╚══════╝ ╚════╝    ╚═╝   ╚═╝╚═╝     ╚═╝]],
    },
    opts = {
        position = "center",
        hl = "DraculaPurple"
    }
}

local function set_button(sc, txt, keybind, keybind_opts)
    local button = dashboard.button(sc, txt, keybind, keybind_opts)
    button.opts.hl = "DraculaPink"
    button.opts.hl_shortcut = "DraculaFg"
    return button
end

local buttons_navigation = {
    type = "group",
    val = {
        set_button("SPC s r", "  Recent Files",    custom  .. "find_recent()<CR>"),
        set_button("SPC s p", "  Projects",        custom  .. "project()<CR>"),
        set_button("SPC s f", "  File search",     custom  .. "find_files()<CR>"),
        set_button("SPC s g", "  ripGREP search",  custom  .. "live_grep()<CR>"),
        set_button("SPC s e", "  File explorer",   custom  .. "file_browser()<CR>"),
        set_button("LDR u n", "ﱐ  New File",        "<cmd>enew<CR>"),
    },
    opts = {
        spacing = 0,
    },
}

local buttons_utility = {
    type = "group",
    val = {
        set_button("LDR u p", "  Update Plugins",  "<cmd>PackerSync<CR>"),
        set_button("LDR u s", "  Language Server", "<cmd>LspInstallInfo<CR>"),
    },
    opts = {
        spacing = 0,
    },
}

local footer = {
    type = "text",
    val = require'alpha.fortune'(),
    opts = { position = "center", hl = "DraculaGreen" },
}

alpha.setup({
    layout = {
        { type = "padding", val = 6 },
        header,
        { type = "padding", val = 5 },
        buttons_navigation,
        { type = "padding", val = 1 },
        buttons_utility,
        { type = "padding", val = 1 },
        footer,
    },
    opts = {
        margin = 5,
    },
})

-- alpha mappings
local map = vim.api.nvim_set_keymap
local ns_opts = { noremap = true, silent = true }

map("n", "<Leader>un", "<cmd>enew<CR>", ns_opts)
