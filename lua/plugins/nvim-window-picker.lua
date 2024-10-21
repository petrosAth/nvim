local function setup(window_picker)
    local getHl = require("themes.utilities").getHl

    window_picker.setup({
        selection_chars = "FJDKSLARUVMGHEIWOXQPBNZ",
        filter_rules = {
            bo = {
                filetype = {
                    "aerial",
                    "Codewindow",
                    "diff",
                    "DiffviewFileHistory",
                    "DiffviewFiles",
                    "lspinfo",
                    "man",
                    "mason",
                    "minimap",
                    "neo%-tree",
                    "neo%-tree%-popup",
                    "notify",
                    "null%-ls%-info",
                    "NvimTree",
                    "Outline",
                    "packer",
                    "qf",
                    "Trouble",
                    "undotree",
                },
                buftype = {
                    "nofile",
                    "terminal",
                },
            },
        },

        highlights = {
            statusline = {
                focused = getHl("WindowPicker"),
                unfocused = getHl("WindowPicker"),
            },
            winbar = {
                focused = getHl("WindowPicker"),
                unfocused = getHl("WindowPicker"),
            },
        },
    })
end

return {
    {
        -- This plugins prompts the user to pick a window and returns the window id of the picked window
        "s1n7ax/nvim-window-picker",
        event = "VeryLazy",
        version = "2.*",
        config = function()
            local loaded, window_picker = pcall(require, "window-picker")
            if not loaded then
                USER.loading_error_msg("nvim-window-picker")
                return
            end

            setup(window_picker)
        end,
    },
}
