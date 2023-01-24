return {
    {
        -- mini.animate
        -- Neovim Lua plugin to animate common Neovim actions. Part of 'mini.nvim' library.
        "echasnovski/mini.nvim",
        enabled = true,
        config = function()
            -- mini.animate
            -- Animate common Neovim actions
            require("plugins.mini.animate").load()
            -- mini.bufremove
            -- Buffer removing (unshow, delete, wipeout), which saves window layout
            require("plugins.mini.bufremove").load()
        end,
    },
}
