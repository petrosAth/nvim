return {
    {
        -- A lua fork of vim-devicons. This plugin provides the same icons as well as colors for each icon.
        "nvim-tree/nvim-web-devicons",
        config = function()
            local loaded, nvim_web_devicons = pcall(require, "nvim-web-devicons")
            if not loaded then
                USER.loading_error_msg("nvim-web-devicons")
                return
            end

            nvim_web_devicons.setup({
                -- your personnal icons can go here (to override)
                -- you can specify color or cterm_color instead of specifying both of them
                -- DevIcon will be appended to `name`
                -- override = {
                --     zsh = {
                --         icon = "",
                --         color = "#428850",
                --         cterm_color = "65",
                --         name = "Zsh",
                --     },
                -- },
                -- globally enable default icons (default to false)
                -- will get overriden by `get_icons` option
                default = false,
            })
        end,
    },
}
