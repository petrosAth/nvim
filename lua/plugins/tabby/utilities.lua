local M = {}

local function get_win_number(win_id) return vim.api.nvim_win_get_number(win_id) end

local function is_not_float_win(win_id) return vim.api.nvim_win_get_config(win_id).relative == "" end

M.get_win_count = function(tab_id)
    local win_list = vim.api.nvim_tabpage_list_wins(tab_id)
    local win_list_no_floats = vim.tbl_filter(is_not_float_win, win_list)

    return #win_list_no_floats
end

M.is_last_win = function(tab_id, win_id)
    local win_count = M.get_win_count(tab_id)
    local win_number = get_win_number(win_id)

    return win_number == win_count and true or false
end

return M
