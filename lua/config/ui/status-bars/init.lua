local M = {}

function M.setup()
    local loaded, heirline = pcall(require, "heirline")
    if not loaded then
        USER.loading_error_msg("heirline.nvim")
        return
    end

    local status_lines = require("config.ui.status-bars.status-line").StatusLines
    local win_bars = require("config.ui.status-bars.win-bar").WinBars
    heirline.setup(status_lines, win_bars)
end

return M
