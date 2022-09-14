local filename = require("tabby.module.filename")
local tab = require("tabby.tab")
local i = require("styling").icons
local s = require("styling").separators.default
local use_thin_separators = true
local p = require("config.themes.nord.palette") -- TODO: remove it after highlights are set

local M = {}

M.modified_icon = i.edit[1]
M.left_separator_icon = s[1]
M.right_separator_icon = s[2]
M.left_separator_icon_thin = s[3]
M.right_separator_icon_thin = s[4]
M.tab_close_icon = i.close[1]

local function is_last_win(line, index)
    local win_count = #line.api.get_tab_wins(line.api.get_current_tab())
    return index == win_count and true or false
end

local function is_first_win(index)
    return index == 1 and true or false
end

local theme = {
    TabLine                        = { fg = p.nord4,     bg = p.nord1                     },
    TabLineSel                     = { fg = p.nord4,     bg = p.nord3light                },
    TabLineFill                    = { fg = p.nord4dark, bg = p.nord2                     },

    TabLineWinSeparator            = { fg = p.nord4dark, bg = p.nord2                     },
    TabLineWinSeparatorSel         = { fg = p.nord4dark, bg = p.nord3light                },
    TabLineTabSeparator            = { fg = p.nord4,     bg = p.nord3                     },
    TabLineTabSeparatorSel         = { fg = p.nord1,     bg = p.nord8                     },

    TabLineSeparatorTail           = { fg = p.nord4,     bg = p.nord1                     },

    TabLineTabIndicator            = { fg = p.nord4,     bg = p.nord3                     },
    TabLineTabIndicatorSel         = { fg = p.nord1,     bg = p.nord8                     },
    TabLineTabIndicatorModified    = { fg = p.nord13,    bg = p.nord3light                },
    TabLineTabIndicatorModifiedSel = { fg = p.nord13,    bg = p.nord2                     },

    TabLineHeader                  = { fg = p.nord1,     bg = p.nord8                     },
    TabLineBody                    = { fg = p.nord4,     bg = p.nord1                     },
    TabLineEdges                   = { fg = p.nord1,     bg = p.nord8,     style = "bold" },
    TabLineTabCurrent              = { fg = p.nord1,     bg = p.nord8                     },
    TabLineTabInactive             = { fg = p.nord4,     bg = p.nord3                     },
    TabLineTabTopWinCurrent        = { fg = p.nord6,     bg = p.nord3light                },
    TabLineTabTopWinInactive       = { fg = p.nord4dark, bg = p.nord2                     },
    TabLineWinCurrent              = { fg = p.nord6,     bg = p.nord3light                },
    TabLineWinInactive             = { fg = p.nord4,     bg = p.nord2                     },
    TabLineWinModifiedCurrent      = { fg = p.nord13,    bg = p.nord3light                },
    TabLineWinModifiedInactive     = { fg = p.nord13,    bg = p.nord2                     },
    TabLineWinFillCurrent          = { fg = p.nord1,     bg = p.nord3light                },
    TabLineWinFillInactive         = { fg = p.nord1,     bg = p.nord2                     },
    test1 = { fg = "#bf616a", bg = "#ebcb8b" },
    test2 = { fg = "#a3be8c", bg = "#b48ead" },
    test3 = { fg = "#242a35", bg = "#8fbcbb" },
    test4 = { fg = "#eceff4", bg = "#5e81ac" },
}

local function set_sep_icon(type, position, index)
    local icon = position == "left" and "" or ""
    if type == "win" then
        if position == "left" then
            if is_first_win(index) then
                icon = " "
            end
        end
    end
    return icon
end

local function set_sep_hl(line, type, position, is_current, index)
    local fg = is_current and theme.TabLineSel or theme.TabLineFill
    local bg = theme.TabLineFill
    if type == "win" then
        if position == "left" then
            if is_first_win(index) then
                fg = theme.TabLineTabSeparatorSel
                bg = is_current and theme.TabLineSel or theme.TabLineFill
            end
        elseif position == "right" then
            if is_last_win(line, index) then
                bg = theme.TabLine
            end
        end
    end
    return fg, bg
end

-- @param line (var) heirline variable
-- @param type (string: tab, win) tab or win
-- @param position (string: left, right, between) separator position
-- @param is_current (boolean) selected or not
-- @param index (number) window position
function M.set_sep_all(line, type, position, is_current, index)
    local icon = set_sep_icon(type, position, index)
    local fg, bg = set_sep_hl(line, type, position, is_current, index)
    return icon, fg, bg
end

return M
