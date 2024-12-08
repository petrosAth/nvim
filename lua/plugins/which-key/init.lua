local function setup(which_key)
    local icons = USER.styling.icons
    local borders = USER.styling.borders.default
    local transparency = USER.styling.variables.transparency
    which_key.setup({
        preset = "modern",
        win = {
            width = { max = 160 },
            border = {
                borders.tl,
                borders.t,
                borders.tr,
                borders.r,
                borders.br,
                borders.b,
                borders.bl,
                borders.l,
            },
            wo = {
                winblend = transparency,
            },
        },
        icons = {
            breadcrumb = icons.arrow.hollow.r,
            separator = icons.arrow.hollow.r,
            group = string.format("%s ", icons.key[1]),
            ellipsis = "…",
            rules = false,
            keys = {
                Up = string.format("%s ", icons.arrow.hollow.u),
                Down = string.format("%s ", icons.arrow.hollow.b),
                Left = string.format("%s ", icons.arrow.hollow.l),
                Right = string.format("%s ", icons.arrow.hollow.r),
                C = "󰘴 ",
                M = "󰘵 ",
                D = "󰘳 ",
                S = "󰘶 ",
                CR = "󰌑 ",
                Esc = "󱊷 ",
                ScrollWheelDown = "󱕐 ",
                ScrollWheelUp = "󱕑 ",
                NL = "󰌑 ",
                BS = "󰁮",
                Space = "󱁐 ",
                Tab = "󰌒 ",
                F1 = "󱊫",
                F2 = "󱊬",
                F3 = "󱊭",
                F4 = "󱊮",
                F5 = "󱊯",
                F6 = "󱊰",
                F7 = "󱊱",
                F8 = "󱊲",
                F9 = "󱊳",
                F10 = "󱊴",
                F11 = "󱊵",
                F12 = "󱊶",
            },
        },
    })
end

return {
    {
        "folke/which-key.nvim",
        -- WhichKey is a lua plugin for Neovim 0.5 that displays a popup with possible key bindings of the command you
        -- started typing. Heavily inspired by the original emacs-which-key and vim-which-key.
        event = { "VeryLazy" },
        config = function()
            local loaded, which_key = pcall(require, "which-key")
            if not loaded then
                USER.loading_error_msg("which-key.nvim")
                return
            end

            setup(which_key)
            require("plugins.which-key.utils").get_maps_add_descriptions(which_key)
            -- require("plugins.which-key.utils").enable_hydra(which_key)
        end,
    },
}
