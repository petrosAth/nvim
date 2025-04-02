local utils = require("heirline.utils")
local props = require("plugins.heirline.properties")

local M = {}

function M.get_vim_mode_color(mode)
    mode = mode or vim.api.nvim_get_mode()["mode"]
    mode = mode:sub(1, 1) -- get only the first mode character
    local mode_colors = props.ModeHighlightGroups
    local highlight = utils.get_highlight(mode_colors[mode])

    return { fg = highlight.fg, bg = highlight.bg, bold = true }
end

return M
