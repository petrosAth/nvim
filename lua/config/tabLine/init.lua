local tabline = require("tabby.tabline")
local c = require("config.tabLine.components")
local i = require("styling").icons
local s = require("styling").separators.default
local p = require("config.themes.nord.palette") -- TODO: remove it after highlights are set

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
}

tabline.set(function(line)
    local win_index = 0
    return {
        {
            { "  ", hl = theme.TabLineHeader },
            line.sep("", theme.TabLineHeader, theme.TabLineSeparatorTail),
        },
        {
            line.sep("", theme.TabLineTabSeparatorSel, theme.TabLineSeparatorTail),
            line.api.get_tab_number(line.api.get_current_tab()),
            hl = theme.TabLineTabIndicatorSel,
            margin = "",
        },
        line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
            win_index = win_index + 1
            local hl = win.is_current() and theme.TabLineSel or theme.TabLineFill
            return {
                line.sep(c.set_sep_all(line, "win", "left", win.is_current(), win_index)),
                win.buf_name(),
                { " " },
                { "" },
                line.sep(c.set_sep_all(line, "win", "right", win.is_current(), win_index)),
                hl = hl,
                margin = "",
            }
        end),
        line.spacer(),
        line.tabs().foreach(function(tab)
            local hl = tab.is_current() and theme.TabLineSel or theme.TabLineFill
            local hl_s = tab.is_current() and theme.TabLineTabSeparatorSel or theme.TabLineTabSeparator
            local hl_s_internal = tab.is_current() and theme.TabLineSel or theme.TabLineFill
            local hl_i = tab.is_current() and theme.TabLineTabIndicatorSel or theme.TabLineTabIndicator
            return {
                line.sep("", hl_s, theme.TabLine),
                { " ", hl = hl_i },
                { tab.number(), hl = hl_i },
                { " ", hl = hl_i },
                line.sep("", hl_s, hl_s_internal),
                { " " },
                tab.name(),
                { " " },
                tab.close_btn(""),
                { " " },
                line.sep(" ", hl, theme.TabLineSeparatorTail),
                hl = hl,
                margin = "",
            }
        end),
        {
            line.sep("", theme.TabLineHeader, theme.TabLineSeparatorTail),
            { "  ", hl = theme.TabLineHeader },
        },
        hl = theme.fill,
    }
end)
