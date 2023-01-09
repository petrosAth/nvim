return {
    {
        "rebelot/heirline.nvim",
        config = function()
            local loaded, heirline = pcall(require, "heirline")
            if not loaded then
                USER.loading_error_msg("heirline.nvim")
                return
            end

            local status_line = require("plugins.ui.status-bars.status-line").StatusLines
            local win_bar = require("plugins.ui.status-bars.win-bar").WinBars
            heirline.setup(status_line, win_bar)
        end,
    },
}
