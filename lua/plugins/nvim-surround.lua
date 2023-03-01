return {
    {
        -- nvim-surround
        -- Add/change/delete surrounding delimiter pairs with ease. Written with love in Lua.
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup()
            local loaded, nvim_surround = pcall(require, "nvim-surround")
            if not loaded then
                USER.loading_error_msg("nvim-surround")
                return
            end

            nvim_surround.setup()
        end,
    },
}
