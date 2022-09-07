local b = require("styling").borders.default

-- Call the setup function to change the default behavior
require("aerial").setup({
    layout = {
        -- These control the width of the aerial window.
        -- They can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        -- min_width and max_width can be a list of mixed types.
        -- max_width = {40, 0.2} means "the lesser of 40 columns or 20% of total"
        max_width = { 40, 0.35 },
        width = 40,
        min_width = 20,
    },

    -- A list of all symbols to display. Set to false to display all symbols.
    -- This can be a filetype map (see :help aerial-filetype-map)
    -- To see all available values, see :help SymbolKind
    filter_kind = {
        "Class",
        "Constructor",
        "Enum",
        "Function",
        "Interface",
        "Module",
        "Method",
        "Struct",
    },

    -- Control which windows and buffers aerial should ignore.
    -- If close_behavior is "global", focusing an ignored window/buffer will
    -- not cause the aerial window to update.
    -- If open_automatic is true, focusing an ignored window/buffer will not
    -- cause an aerial window to open.
    -- If open_automatic is a function, ignore rules have no effect on aerial
    -- window opening behavior; it's entirely handled by the open_automatic
    -- function.
    ignore = {
        -- Ignore unlisted buffers. See :help buflisted
        unlisted_buffers = true,

        -- List of filetypes to ignore.
        filetypes = {
            "minimap",
            "NvimTree",
            "qf",
        },

        -- Ignored buftypes.
        -- Can be one of the following:
        -- false or nil - No buftypes are ignored.
        -- "special"    - All buffers other than normal buffers are ignored.
        -- table        - A list of buftypes to ignore. See :help buftype for the
        --                possible values.
        -- function     - A function that returns true if the buffer should be
        --                ignored or false if it should not be ignored.
        --                Takes two arguments, `bufnr` and `buftype`.
        buftypes = "special",

        -- Ignored wintypes.
        -- Can be one of the following:
        -- false or nil - No wintypes are ignored.
        -- "special"    - All windows other than normal windows are ignored.
        -- table        - A list of wintypes to ignore. See :help win_gettype() for the
        --                possible values.
        -- function     - A function that returns true if the window should be
        --                ignored or false if it should not be ignored.
        --                Takes two arguments, `winid` and `wintype`.
        wintypes = "special",
    },

    -- Options for opening aerial in a floating win
    float = {
        -- Controls border appearance. Passed to nvim_open_win
        border = { b.tl, b.t, b.tr, b.r, b.br, b.b, b.bl, b.l },
    },
})
