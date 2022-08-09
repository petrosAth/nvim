require("window-picker").setup({
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
            filetype = { "NvimTree", "neo-tree", "neo-tree-popup", "notify" },

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
    fg_color = "#ededed",

    -- if you have include_current_win == true, then current_win_hl_color will
    -- be highlighted using this background color
    current_win_hl_color = "#e35e4f",

    -- all the windows except the curren window will be highlighted using this
    -- color
    other_win_hl_color = "#44cc41",
})
