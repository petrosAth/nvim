return {
    {
        -- Neovim Lua plugin to animate common Neovim actions. Part of 'mini.nvim' library.
        "echasnovski/mini.nvim",
        version = "*",
        event = "VeryLazy",
        config = function()
            -- Align text interactively
            require("plugins.mini.align").load()
            -- Buffer removing (unshow, delete, wipeout), which saves window layout
            require("plugins.mini.bufremove").load()
        end,
    },
}
