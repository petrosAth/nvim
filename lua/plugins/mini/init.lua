return {
    {
        -- Neovim Lua plugin to animate common Neovim actions. Part of 'mini.nvim' library.
        "echasnovski/mini.nvim",
        version = "*",
        event = "VeryLazy",
        config = function()
            -- Animate common Neovim actions
            require("plugins.mini.animate").load()
            -- Buffer removing (unshow, delete, wipeout), which saves window layout
            require("plugins.mini.bufremove").load()
        end,
    },
}
