return {
    {
        -- nvim-surround
        -- Add/change/delete surrounding delimiter pairs with ease. Written with love in Lua.
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup()
        end,
    },
}
