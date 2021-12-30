vim.cmd([[
    augroup ALPHA
        autocmd!
        autocmd FileType alpha setlocal
                \ scrolloff=999
                \ fillchars+=eob:\ "
    augroup END
]])

local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")
local ci = require("cosmetics").icon
local tele_custom = "<cmd> lua require('config.telescope.customPickers')."

local function set_button(sc, txt, keybind, keybind_opts)
    local button = dashboard.button(sc, txt, keybind, keybind_opts)
    button.opts.hl          = "DraculaPink"
    button.opts.hl_shortcut = "DraculaFg"
    button.opts.cursor      = 4

    return button
end

local header = {
    type = "text",
    val = {
        [[   ____  ___  ___`7MMF'   `7MF'           ]],
        [[  / __ \/ _ \/ __ \`MA     ,V             ]],
        [[ / / / /  __/ /_/ / VM:   ,V _            ]],
        [[/_/ /_/\___/\____/   MM.  M'(O) _ __ ___  ]],
        [[                     `MM A' |M|| '_ ` _ \ ]],
        [[                      :MM;  |M|| | | | | |]],
        [[                       VF   |M||_| |_| |_|]]
    },
    opts = {
        position = "center",
        hl = "DraculaPurple"
    }
}

local buttons_navigation = {
    type = "group",
    val = {
        set_button("SPC s r", " " .. ci.arrowr[1] .. " Recent files",   tele_custom .. "find_recent()<CR>"),
        set_button("SPC s p", " " .. ci.arrowr[1] .. " Projects",       tele_custom .. "project()<CR>"),
        set_button("SPC s f", " " .. ci.arrowr[1] .. " File search",    tele_custom .. "find_files()<CR>"),
        set_button("SPC s g", " " .. ci.arrowr[1] .. " ripGREP search", tele_custom .. "live_grep()<CR>"),
        set_button("SPC s b", " " .. ci.arrowr[1] .. " File browser",   tele_custom .. "file_browser()<CR>"),
    },
    opts = {
        spacing = 0,
    },
}

local buttons_utility = {
    type = "group",
    val = {
        set_button("SPC u u", " " .. ci.arrowr[1] .. " Update plugins",  "<cmd>PackerSync<CR>"),
        set_button("SPC u I", " " .. ci.arrowr[1] .. " Language servers", "<cmd>LspInstallInfo<CR>"),
    },
    opts = {
        spacing = 0,
    },
}

local footer = {
    type = "text",
    val = require'alpha.fortune'(),
    opts = {
        position = "center",
        hl = "DraculaGreen"
    },
}

alpha.setup({
    layout = {
        { type = "padding", val = 5 },
        header,
        { type = "padding", val = 4 },
        buttons_navigation,
        { type = "padding", val = 1 },
        buttons_utility,
        { type = "padding", val = 1 },
        footer,
    },
    opts = {
        margin = 5,
        noautocmd = false
    },
})
