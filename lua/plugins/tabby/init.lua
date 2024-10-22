return {
    {
        -- A declarative, highly configurable, and neovim style tabline plugin. Use your nvim tabs as a workspace
        -- multiplexer!
        "nanozuki/tabby.nvim",
        dependencies = {
            -- A lua fork of vim-devicons. This plugin provides the same icons as well as colors for each icon.
            "nvim-web-devicons",
        },
        config = function()
            local loaded, tabby = pcall(require, "tabby")
            if not loaded then
                USER.loading_error_msg("tabby.nvim")
                return
            end

            local tabline = require("plugins.tabby.tabline").setup
            tabby.setup(tabline)
        end,
    },
}
