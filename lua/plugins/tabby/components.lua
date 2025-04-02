local win_name = require("tabby.feature.win_name")
local tab_name = require("tabby.feature.tab_name")
local getHl = require("themes.utilities").getHl
local uiUtils = require("ui.utilities")
local utils = require("plugins.tabby.utilities")
local icons = USER.styling.icons

local M = {}

local check_for_custom_label = function(tab_id)
    local label = tab_name.get_raw(tab_id)
    return label ~= "" and true, label or false, ""
end

M.win_label = function(win_id)
    local buf_id = vim.api.nvim_win_get_buf(win_id)
    local fullPath = vim.api.nvim_buf_get_name(buf_id)
    local filetype = vim.bo[buf_id].filetype
    local buftype = vim.bo[buf_id].buftype
    local buf_label = uiUtils.get_buf_label(fullPath, buftype, filetype)
    local label = win_name.get(win_id, { mode = "unique" })

    if buf_label then label = buf_label end

    return string.format("%s ", label)
end

M.file_icon = function(type, id, bg)
    local win_id = type == "win" and id or vim.api.nvim_tabpage_get_win(id)
    local buf_id = vim.api.nvim_win_get_buf(win_id)
    local fullPath = vim.api.nvim_buf_get_name(buf_id)
    local extension = vim.fn.fnamemodify(fullPath, ":e")
    local icon, fg = require("nvim-web-devicons").get_icon_color(fullPath, extension, { default = true })
    local filetype = vim.bo[buf_id].filetype
    local buftype = vim.bo[buf_id].buftype
    local buf_label = uiUtils.get_buf_label(fullPath, buftype, filetype)

    if buf_label then return "" end

    return { string.format("%s ", icon), hl = { fg = fg, bg = bg } }
end

M.modified_flag = function(win_id, is_current)
    local buf_id = vim.api.nvim_win_get_buf(win_id)
    local is_modified = vim.bo[buf_id].modified
    local fg = getHl("TabLineFill").bg
    local bg = getHl("TabLine").bg

    if is_current then bg = getHl("TabLineSel").bg end

    if is_modified then fg = getHl("BarModified").fg end

    return { string.format(" %s ", icons.edit[1]), hl = { fg = fg, bg = bg } }
end

local tab_top_window = function(tab_id)
    local buf_id = vim.api.nvim_win_get_buf(vim.api.nvim_tabpage_get_win(tab_id))
    local fullPath = vim.api.nvim_buf_get_name(buf_id)
    local filetype = vim.api.nvim_get_option_value("filetype", { buf = buf_id })
    local buftype = vim.api.nvim_get_option_value("buftype", { buf = buf_id })
    local buf_label = uiUtils.get_buf_label(fullPath, buftype, filetype)
    local name = win_name.get(vim.api.nvim_tabpage_get_win(tab_id), { mode = "unique" })
    local label = name

    if buf_label then label = buf_label end

    return label
end

M.tab_label = function(tab_id, is_current)
    local label = tab_top_window(tab_id)
    local has_custom_label, custom_label = check_for_custom_label(tab_id)
    local hl = is_current and "TabLineSel" or "TabLine"

    if has_custom_label then label = custom_label end

    return { string.format("%s", label), hl = hl }
end

M.tab_win_count = function(tab_id)
    local win_count = utils.get_win_count(tab_id)
    local label = string.format("%s %s", icons.windows[1], win_count)

    return win_count > 1 and label or ""
end

return M
