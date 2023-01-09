return {
    {
        "nanozuki/tabby.nvim",
        dependencies = {
            "nvim-web-devicons",
        },
        config = function()
            local loaded, tabby = pcall(require, "tabby.tabline")
            if not loaded then
                USER.loading_error_msg("tabby.nvim")
                return
            end

            local tab_line = require("plugins.ui.tab-line").setup
            tabby.set(tab_line)
        end,
    },
}
