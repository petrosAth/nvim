local function setup(window_picker)
    local getHl = require("themes.utilities").getHl

    window_picker.setup({
        -- when you go to window selection mode, status bar will show one of
        -- following letters on them so you can use that letter to select the window
        selection_chars = "ASDGHKLQWERTYUIOPZXCVBNMFJ",

        -- following filters are only applied when you are using the default filter
        -- defined by this plugin. if you pass in a function to "filter_func"
        -- property, you are on your own
        filter_rules = {
            -- filter using buffer options
            bo = {
                -- if the file type is one of following, the window will be ignored
                filetype = {
                    "aerial",
                    "alpha",
                    "Codewindow",
                    "diff",
                    "DiffviewFileHistory",
                    "DiffviewFiles",
                    "lspinfo",
                    "man",
                    "mason",
                    "minimap",
                    "neo%-tree",
                    "notify",
                    "null%-ls%-info",
                    "NvimTree",
                    "Outline",
                    "packer",
                    "qf",
                    "Trouble",
                    "undotree",
                },

                -- if the buffer type is one of following, the window will be ignored
                buftype = { "terminal" },
            },

            -- filter using window options
            wo = {},

            -- if the file path contains one of following names, the window
            -- will be ignored
            file_path_contains = {},

            -- if the file name contains one of following names, the window will be
            -- ignored
            file_name_contains = {},
        },

        -- the foreground (text) color of the picker
        fg_color = getHl("WindowPicker").fg,

        -- if you have include_current_win == true, then current_win_hl_color will
        -- be highlighted using this background color
        current_win_hl_color = getHl("WindowPicker").bg,

        -- all the windows except the curren window will be highlighted using this
        -- color
        other_win_hl_color = getHl("WindowPickerNC").bg,
    })
end

return {
    {
        -- nvim-window-picker
        -- This plugins prompts the user to pick a window and returns the window id of the picked window
        "s1n7ax/nvim-window-picker",
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
