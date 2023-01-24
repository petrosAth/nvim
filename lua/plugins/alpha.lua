local function setup(alpha, icons)
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
                width = 40,
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
            button("LDR p .", string.format("%s %s Load last session", icons.alphaCursor[1], icons.lastSession[1])),
            button("LDR p L", string.format("%s %s Load local session", icons.alphaCursor[1], icons.lastSession[1])),
            button("SPC s s", string.format("%s %s Search sessions", icons.alphaCursor[1], icons.sessions[1])),
        },
        opts = {
            spacing = 0,
        },
    }

    local buttons_navigation = {
        type = "group",
        val = {
            button("SPC s r", string.format("%s %s Recent files", icons.alphaCursor[1], icons.history[1])),
            button("SPC s R", string.format("%s %s Frecent files", icons.alphaCursor[1], icons.history[1])),
            button("SPC s f", string.format("%s %s File search", icons.alphaCursor[1], icons.search[1])),
            button("SPC s g", string.format("%s %s ripGREP search", icons.alphaCursor[1], icons.grep[1])),
        },
        opts = {
            spacing = 0,
        },
    }

    local buttons_utility = {
        type = "group",
        val = {
            button("LDR u u l", string.format("%s %s Update external tooling", icons.alphaCursor[1], icons.update[1])),
            button("LDR u u p", string.format("%s %s Check for plugins updates", icons.alphaCursor[1], icons.preview[1])),
            button("LDR u u P", string.format("%s %s Update plugins", icons.alphaCursor[1], icons.update[1])),
        },
        opts = {
            spacing = 0,
        },
    }

    local change_log = {
        type = "button",
        val = string.format("%s %s Nigthly changelog", icons.alphaCursor[1], icons.list[1]),
        on_press = function()
            if vim.version()["prerelease"] then
                vim.cmd("vert help news")
                vim.cmd("79wincmd|")
                vim.cmd("0")
                return
            end
            local message = "This information is only available in nightly versions"
            vim.notify(message, "warn", { title = "Alpha" })
        end,
        opts = {
            position = "center",
            hl = "AlphaButtons",
            align_shortcut = "right",
            shortcut = "",
            hl_shortcut = "AlphaButtonShortcuts",
            cursor = 0,
            width = 40,
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
            change_log,
            { type = "padding", val = 1 },
            footer,
        },
        opts = {
            margin = 5,
            noautocmd = false,
        },
    })
end

return {
    {
        -- alpha-nvim
        -- alpha is a fast and fully programmable greeter for neovim.
        "goolord/alpha-nvim",
        event = { "VimEnter" },
        config = function()
            local loaded, alpha = pcall(require, "alpha")
            if not loaded then
                USER.loading_error_msg("alpha-nvim")
                return
            end

            local icons = USER.styling.icons
            setup(alpha, icons)
        end,
    },
}
