return {
    {
        -- mini.animate
        -- Neovim Lua plugin to animate common Neovim actions. Part of 'mini.nvim' library.
        "echasnovski/mini.nvim",
        enabled = true,
        config = function()
            require("plugins.mini.animate").load()
        end,
    },
}
