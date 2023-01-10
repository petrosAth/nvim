local filename = require("tabby.module.filename")
local tab_name = require("tabby.feature.tab_name")
local getHl = require("themes.utilities").getHl
local u = require("ui.utilities")
local i = USER.styling.icons
local s = USER.styling.separators.default

local M = {}

M.win_sel_number = 0

M.left_sep_icon = s[1]
M.right_sep_icon = s[2]
M.left_sep_icon_thin = s[3]
M.right_sep_icon_thin = s[4]

local function get_win_number(win_id)
    return vim.api.nvim_win_get_number(win_id)
end

local function is_not_float_win(win_id)
    return vim.api.nvim_win_get_config(win_id).relative == ""
end

M.get_win_count = function(tab_id)
    local win_list = vim.api.nvim_tabpage_list_wins(tab_id)
    local win_list_no_floats = vim.tbl_filter(is_not_float_win, win_list)

    return #win_list_no_floats
end

local function is_last_win(tab_id, win_id)
    local win_count = M.get_win_count(tab_id)
    local win_number = get_win_number(win_id)

    return win_number == win_count and true or false
end

local function is_first_win(win_id)
    local win_number = get_win_number(win_id)

    return win_number == 1 and true or false
end

local function is_before_win_sel(is_current, win_id)
    local win_number = get_win_number(win_id)

    if is_current then
        M.win_sel_number = win_number
    end

    return win_number + 1 == M.win_sel_number
end

local function check_for_custom_label(tab_id)
    local label = tab_name.get_raw(tab_id)

    if label ~= "" then
        return true, label
    end

    return false, ""
end

local function set_sep_icon(type, position, is_current, tab_id, win_id)
    local icon = position == "left" and M.left_sep_icon or M.right_sep_icon
    local has_custom_label = check_for_custom_label(tab_id)

    if type == "win" then
        if position == "left" then
            if is_current then
                icon = " "
            end
            if is_first_win(win_id) then
                icon = M.right_sep_icon .. " "
            end
        end
        if position == "right" then
            icon = M.right_sep_icon_thin
            if is_last_win(tab_id, win_id) then
                icon = M.right_sep_icon
            end
            if is_before_win_sel(is_current, win_id) then
                icon = M.right_sep_icon
            end
            if is_current then
                icon = M.right_sep_icon
            end
        end
    end
    if type == "tab" then
        if position == "inner_left" then
            icon = M.right_sep_icon
            if has_custom_label and M.get_win_count(tab_id) == 1 then
                icon = M.right_sep_icon_thin
            end
        end
        if position == "inner_right" then
            icon = M.right_sep_icon
            if has_custom_label then
                icon = M.right_sep_icon_thin
            end
        end
        if position == "split" then
            icon = M.right_sep_icon_thin
            if has_custom_label then
                icon = M.right_sep_icon
            end
        end
    end

    return icon
end

local function set_sep_hl(type, position, is_current, tab_id, win_id)
    win_id = win_id or 0
    local has_custom_label = check_for_custom_label(tab_id)
    local fg = is_current and getHl("TabLineSel") or getHl("TabLineFill")
    local bg = getHl("TabLine")

    if type == "win" then
        fg = getHl("TabLineBufferNC")
        bg = getHl("TabLineBufferNC")
        if position == "left" then
            if is_current then
                bg = getHl("TabLineBuffer")
            end
            if is_first_win(win_id) then
                fg = getHl("TabLineTabSeparatorSel")
                bg = is_current and getHl("TabLineBuffer") or getHl("TabLineBufferNC")
            end
        elseif position == "right" then
            fg = getHl("TabLine")
            if is_last_win(tab_id, win_id) then
                fg = getHl("TabLineBufferNC")
                bg = getHl("TabLine")
            end
            if is_before_win_sel(is_current, win_id) then
                fg = getHl("TabLineBufferNC")
                bg = getHl("TabLineBuffer")
            end
            if is_current then
                fg = getHl("TabLineBuffer")
            end
        end
    end
    if type == "tab" then
        fg = is_current and getHl("TabLineTabSeparatorSel") or getHl("TabLineTabSeparator")
        if position == "inner_right" then
            if is_current then
                bg = getHl("TabLineSel")
                if has_custom_label then
                    fg = getHl("TabLine")
                    bg = getHl("TabLineTabSeparatorSel")
                end
            else
                bg = getHl("TabLineFill")
                if has_custom_label then
                    fg = getHl("TabLine")
                    bg = getHl("TabLineTabSeparator")
                end
            end
        end
        if position == "inner_left" then
            fg = is_current and getHl("TabLineSel") or getHl("TabLineFill")
            bg = is_current and getHl("TabLineTabSeparatorSel") or getHl("TabLineTabSeparator")
        end
        if position == "split" then
            if is_current then
                fg = getHl("TabLine")
                bg = getHl("TabLineSel")
                if has_custom_label then
                    fg = getHl("TabLineTabSeparatorSel")
                    bg = getHl("TabLineSel")
                end
            else
                fg = getHl("TabLine")
                bg = getHl("TabLineFill")
                if has_custom_label then
                    fg = getHl("TabLineTabSeparator")
                    bg = getHl("TabLineFill")
                end
            end
        end
    end

    return fg, bg
end

-- @param type (string: tab, win) tab or win
-- @param position (string: left, right, inner_left, inner_right) separator position
-- @param is_current (boolean) selected or not
-- @param tab_id (number) tab id
-- @param win_id (number) window id
function M.set_sep_all(type, position, is_current, tab_id, win_id)
    local icon = set_sep_icon(type, position, is_current, tab_id, win_id)
    local fg, bg = set_sep_hl(type, position, is_current, tab_id, win_id)

    return icon, fg, bg
end

M.win_label = function(win_id)
    local buf_id = vim.api.nvim_win_get_buf(win_id)
    local fullPath = vim.api.nvim_buf_get_name(buf_id)
    local filetype = vim.api.nvim_buf_get_option(buf_id, "filetype")
    local buftype = vim.api.nvim_buf_get_option(buf_id, "buftype")
    local buf_label = u.get_buf_label(fullPath, buftype, filetype)
    local name = filename.unique(win_id)
    local label = name

    if buf_label then
        label = buf_label
    end

    return label .. "  "
end

M.modified_flag = function(win_id, is_current)
    local buf_id = vim.api.nvim_win_get_buf(win_id)
    local is_modified = vim.bo[buf_id].modified
    local hl = is_current and getHl("TabLineIndicatorModifiedSel") or getHl("TabLineIndicatorModified")

    if is_modified then
        hl = is_current and getHl("TabLineIndicatorIsModifiedSel") or getHl("TabLineIndicatorIsModified")
    end

    return { i.edit[1] .. " ", hl = hl }
end

local function tab_top_window(tab_id)
    local buf_id = vim.api.nvim_win_get_buf(vim.api.nvim_tabpage_get_win(tab_id))
    local fullPath = vim.api.nvim_buf_get_name(buf_id)
    local filetype = vim.api.nvim_buf_get_option(buf_id, "filetype")
    local buftype = vim.api.nvim_buf_get_option(buf_id, "buftype")
    local buf_label = u.get_buf_label(fullPath, buftype, filetype)
    local name = filename.unique(vim.api.nvim_tabpage_get_win(tab_id))
    local label = name

    if buf_label then
        label = buf_label
    end

    return label
end

local function set_tab_label_hl(is_current, has_custom_label)
    local hl = is_current and getHl("TabLineSel") or getHl("TabLineFill")

    if has_custom_label then
        hl = is_current and getHl("TabLineTabIndicatorSel") or getHl("TabLineTabIndicator")
    end

    return hl
end

M.tab_label = function(tab_id, is_current)
    local label = tab_top_window(tab_id)
    local has_custom_label, custom_label = check_for_custom_label(tab_id)
    local hl = set_tab_label_hl(is_current, has_custom_label)

    if has_custom_label then
        label = custom_label
    end

    return { " " .. label, hl = hl }
end

M.tab_win_count = function(tab_id)
    local win_count = M.get_win_count(tab_id)
    local label = string.format(" %s %s", i.windows[1], win_count)

    return win_count > 1 and label or ""
end

return M
