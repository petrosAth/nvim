return {
    {
        -- Neovim Lua plugin to animate common Neovim actions. Part of 'mini.nvim' library.
        "echasnovski/mini.nvim",
        version = "*",
        config = function()
            -- mini.animate
            -- Animate common Neovim actions
            require("plugins.mini.animate").load()
        end,
    },
}
