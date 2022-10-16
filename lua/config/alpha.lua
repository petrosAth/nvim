local alpha = require("alpha")
local i = require("styling").icons

local function button(shortcut, description)
    return {
        type = "button",
        val = description,
        on_press = function()
            local sc_ = shortcut:gsub("%s", ""):gsub("SPC", "<space>"):gsub("LDR", "<leader>")
            local key = vim.api.nvim_replace_termcodes(sc_ .. "<Ignore>", true, false, true)

            vim.api.nvim_feedkeys(key, "normal", false)
        end,
        opts = {
            position = "center",
            hl = "AlphaButtons",
            shortcut = shortcut,
            align_shortcut = "right",
            hl_shortcut = "AlphaButtonShortcuts",
            cursor = 0,
            width = 50,
        },
    }
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
        [[                       VF   |M||_| |_| |_|]],
    },
    opts = {
        position = "center",
        hl = "AlphaHeader",
    },
}

local buttons_session = {
    type = "group",
    val = {
        button("LDR p .", i.alphaCursor[1] .. " " .. i.lastSession[1] .. " Load last session"),
        button("LDR p L", i.alphaCursor[1] .. " " .. i.lastSession[1] .. " Load local session"),
        button("LDR s s", i.alphaCursor[1] .. " " .. i.sessions[1]    .. " Search sessions"),
    },
    opts = {
        spacing = 0,
    },
}

local buttons_navigation = {
    type = "group",
    val = {
        button("SPC s r", i.alphaCursor[1] .. " " .. i.history[1] .. " Recent files"),
        button("SPC s R", i.alphaCursor[1] .. " " .. i.history[1] .. " Frecent files"),
        button("SPC s f", i.alphaCursor[1] .. " " .. i.search[1]  .. " File search"),
        button("SPC s g", i.alphaCursor[1] .. " " .. i.grep[1]    .. " ripGREP search"),
    },
    opts = {
        spacing = 0,
    },
}

local buttons_utility = {
    type = "group",
    val = {
        button("LDR u u p", i.alphaCursor[1] .. " " .. i.diffview[1]   .. " Preview plugins updates"),
        button("LDR u u P", i.alphaCursor[1] .. " " .. i.update[1]     .. " Update plugins"),
        button("LDR u u l", i.alphaCursor[1] .. " " .. i.lspServers[1] .. " Update LSP packages"),
    },
    opts = {
        spacing = 0,
    },
}

local footer = {
    type = "text",
    val = require("alpha.fortune")(),
    opts = {
        position = "center",
        hl = "AlphaFooter",
    },
}

alpha.setup({
    layout = {
        { type = "padding", val = 5 },
        header,
        { type = "padding", val = 4 },
        buttons_session,
        { type = "padding", val = 1 },
        buttons_navigation,
        { type = "padding", val = 1 },
        buttons_utility,
        { type = "padding", val = 1 },
        footer,
    },
    opts = {
        margin = 5,
        noautocmd = false,
    },
})
