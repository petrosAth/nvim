local filename = require("tabby.module.filename")
local tab = require("tabby.tab")
local i = require("styling").icons
local s = require("styling").separators.default
local use_thin_separators = true
local p = require("config.themes.nord.palette") -- TODO: remove it after highlights are set

local M = {}

M.win_sel_number = 0

M.modified_icon = i.edit[1]
M.left_separator_icon = s[1]
M.right_separator_icon = s[2]
M.left_separator_icon_thin = s[3]
M.right_separator_icon_thin = s[4]
M.tab_close_icon = i.close[1]

local function get_win_number(win_id)
    return vim.api.nvim_win_get_number(win_id)
end

local function is_last_win(line, win_id)
    local win_count = #line.api.get_tab_wins(line.api.get_current_tab())
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

M.theme = {
    TabLine                        = { fg = p.nord4,     bg = p.nord1                     },
    TabLineSel                     = { fg = p.nord4,     bg = p.nord3light                },
    TabLineFill                    = { fg = p.nord4dark, bg = p.nord2                     },

    TabLineHeader                  = { fg = p.nord1,     bg = p.nord8                     },

    TabLineTabSeparator            = { fg = p.nord4,     bg = p.nord3                     },
    TabLineTabSeparatorSel         = { fg = p.nord1,     bg = p.nord8                     },

    TabLineTabIndicator            = { fg = p.nord4,     bg = p.nord3                     },
    TabLineTabIndicatorSel         = { fg = p.nord1,     bg = p.nord8                     },
    TabLineTabIndicatorModified    = { fg = p.nord13,    bg = p.nord3light                },
    TabLineTabIndicatorModifiedSel = { fg = p.nord13,    bg = p.nord2                     },

    TabLineWinCurrent              = { fg = p.nord6,     bg = p.nord3light                },
    TabLineWinInactive             = { fg = p.nord4,     bg = p.nord2                     },

    TabLineBody                    = { fg = p.nord4,     bg = p.nord1                     },
    TabLineEdges                   = { fg = p.nord1,     bg = p.nord8,     style = "bold" },
    TabLineTabCurrent              = { fg = p.nord1,     bg = p.nord8                     },
    TabLineTabInactive             = { fg = p.nord4,     bg = p.nord3                     },
    TabLineTabTopWinCurrent        = { fg = p.nord6,     bg = p.nord3light                },
    TabLineTabTopWinInactive       = { fg = p.nord4dark, bg = p.nord2                     },
    TabLineWinModifiedCurrent      = { fg = p.nord13,    bg = p.nord3light                },
    TabLineWinModifiedInactive     = { fg = p.nord13,    bg = p.nord2                     },
    TabLineWinFillCurrent          = { fg = p.nord1,     bg = p.nord3light                },
    TabLineWinFillInactive         = { fg = p.nord1,     bg = p.nord2                     },
    test1 = { fg = "#bf616a", bg = "#ebcb8b" },
    test2 = { fg = "#a3be8c", bg = "#b48ead" },
    test3 = { fg = "#242a35", bg = "#8fbcbb" },
    test4 = { fg = "#eceff4", bg = "#5e81ac" },
}

local function set_sep_icon(line, type, position, is_current, win_id)
    local icon = position == "left" and "" or ""
    if type == "win" then
        if position == "left" then
            if is_current then
                icon = " "
            end
            if is_first_win(win_id) then
                icon = " "
            end
        end
        if position == "right" then
            icon = ""
            if is_last_win(line, win_id) then
                icon = ""
            end
            if is_before_win_sel(is_current, win_id) then
                icon = ""
            end
            if is_current then
                icon = ""
            end
        end
    end
    if type == "tab" then
        if position == "inner_left" then
            icon = ""
        end
    end
    return icon
end

local function set_sep_hl(line, type, position, is_current, win_id)
    win_id = win_id or 0
    local fg = is_current and M.theme.TabLineSel or M.theme.TabLineFill
    local bg = M.theme.TabLine
    if type == "win" then
        bg = M.theme.TabLineFill
        if position == "left" then
            if is_current then
                bg = M.theme.TabLineSel
            end
            if is_first_win(win_id) then
                fg = M.theme.TabLineTabSeparatorSel
                bg = is_current and M.theme.TabLineSel or M.theme.TabLineFill
            end
        elseif position == "right" then
            fg = M.theme.TabLine
            if is_last_win(line, win_id) then
                fg = M.theme.TabLineFill
                bg = M.theme.TabLine
            end
            if is_before_win_sel(is_current, win_id) then
                fg = M.theme.TabLineFill
                bg = M.theme.TabLineSel
            end
            if is_current then
                fg = M.theme.TabLineSel
            end
        end
    end
    if type == "tab" then
        fg = is_current and M.theme.TabLineTabSeparatorSel or M.theme.TabLineTabSeparator
        if position == "inner_right" then
            bg = is_current and M.theme.TabLineSel or M.theme.TabLineFill
        end
        if position == "inner_left" then
            bg = is_current and M.theme.TabLineSel or M.theme.TabLineFill
        end
    end
    return fg, bg
end

-- @param line (var) heirline variable
-- @param type (string: tab, win) tab or win
-- @param position (string: left, right, inner_left, inner_right) separator position
-- @param is_current (boolean) selected or not
-- @param win_id (number) window id
function M.set_sep_all(line, type, position, is_current, win_id)
    local icon = set_sep_icon(line, type, position, is_current, win_id)
    local fg, bg = set_sep_hl(line, type, position, is_current, win_id)
    return icon, fg, bg
end

return M
