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
local i = require("styling").icons
local tele_custom = "<cmd> lua require('config.telescope.customPickers')."

local function set_button(sc, txt, keybind, keybind_opts)
    local button = dashboard.button(sc, txt, keybind, keybind_opts)
    local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")
    button.opts.hl          = "AlphaButtons"
    button.opts.hl_shortcut = "AlphaButtonShortcuts"
    button.opts.cursor      = 4
    button.on_press = function()
        local key = vim.api.nvim_replace_termcodes(sc_ .. "<Ignore>", true, false, true)
        vim.api.nvim_feedkeys(key, "normal", false)
    end

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
        hl = "AlphaHeader"
    }
}

local buttons_navigation = {
    type = "group",
    val = {
        set_button("LDR s r", "菱" .. i.arrowr[1] .. " Load last session", "<CMD>PossessionLoad<CR>"),
        set_button("SPC s s", "舘" .. i.arrowr[1] .. " Search sessions",   tele_custom .. "possession()<CR>"),
        set_button("SPC s r", " " .. i.arrowr[1] .. " Recent files",      tele_custom .. "oldfiles()<CR>"),
        set_button("SPC s R", " " .. i.arrowr[1] .. " Frecent files",     tele_custom .. "frecency()<CR>"),
        set_button("SPC s f", " " .. i.arrowr[1] .. " File search",       "<CMD>Telescope find_files<CR>"),
        set_button("SPC s g", " " .. i.arrowr[1] .. " ripGREP search",    "<CMD>Telescope live_grep<CR>")
    },
    opts = {
        spacing = 0,
    },
}

local buttons_utility = {
    type = "group",
    val = {
        set_button("LDR u u", " " .. i.arrowr[1] .. " Update plugins",   "<cmd>PackerSync<CR>"),
        set_button("LDR u I", " " .. i.arrowr[1] .. " Language servers", "<cmd>LspInstallInfo<CR>")
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
        hl = "AlphaFooter"
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
