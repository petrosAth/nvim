local tabline = require("tabby.tabline")
local c = require("config.tabLine.components")
local i = require("styling").icons
local s = require("styling").separators.default

local theme = c.theme

tabline.set(function(line)
    return {
        {
            { " Neo ", hl = theme.TabLineHeader },
            line.sep("", theme.TabLineHeader, theme.TabLine),
        },
        {
            { " ", hl = "TabLine" },
        },
        {
            line.sep("", theme.TabLineTabSeparatorSel, theme.TabLine),
            line.api.get_current_tab(),
            hl = theme.TabLineTabIndicatorSel,
            margin = "",
        },
        line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
            local hl = win.is_current() and theme.TabLineSel or theme.TabLineFill
            local tab_id = line.api.get_current_tab()
            return {
                line.sep(c.set_sep_all("win", "left", win.is_current(), tab_id, win.id)),
                c.win_label(win.id),
                c.modified_flag(win.id, win.is_current()),
                line.sep(c.set_sep_all("win", "right", win.is_current(), tab_id, win.id)),
                hl = hl,
                margin = "",
            }
        end),
        line.spacer(),
        line.tabs().foreach(function(tab)
            local hl = tab.is_current() and theme.TabLineSel or theme.TabLineFill
            local hl_indicator = tab.is_current() and theme.TabLineTabIndicatorSel or theme.TabLineTabIndicator
            local tab_count = #vim.api.nvim_list_tabpages()
            if tab_count == 1 then
                return nil
            end
            return {
                line.sep(c.set_sep_all("tab", "left", tab.is_current(), tab.id)),
                { tab.number(), hl = hl_indicator },
                line.sep(c.set_sep_all("tab", "inner_right", tab.is_current(), tab.id)),
                c.tab_label(tab.id, tab.is_current()),
                line.sep(c.set_sep_all("tab", "split", tab.is_current(), tab.id)),
                c.tab_win_count(tab.id),
                line.sep(c.set_sep_all("tab", "inner_left", tab.is_current(), tab.id)),
                { tab.close_btn(" " .. i.close[1]), hl = hl_indicator },
                line.sep(c.set_sep_all("tab", "right", tab.is_current(), tab.id)),
                { " ", hl = "TabLine" },
                hl = hl,
                margin = "",
            }
        end),
        { "%<" },
        {
            line.sep("", theme.TabLineHeader, theme.TabLine),
            { " 裡", hl = theme.TabLineHeader },
        },
        hl = theme.fill,
    }
end)
