local M = {}

local c = require("plugins.tabby.components")
local i = USER.styling.icons

M.setup = {
    line = function(line)
        return {
            {
                line.sep(c.left_sep_icon, "TabLineTabSeparatorSel", "TabLine"),
                line.api.get_current_tab(),
                hl = "TabLineTabIndicatorSel",
                margin = "",
            },
            line.truncate_point(),
            line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
                local hl = win.is_current() and "TabLineBuffer" or "TabLineBufferNC"
                local tab_id = line.api.get_current_tab()

                return {
                    line.sep(c.set_sep_all("win", "left", win.is_current(), tab_id, win.id)),
                    c.modified_flag(win.id, win.is_current()),
                    c.win_label(win.id),
                    line.sep(c.set_sep_all("win", "right", win.is_current(), tab_id, win.id)),
                    hl = hl,
                    margin = "",
                }
            end),
            line.spacer(),
            line.tabs().foreach(function(tab)
                local hl = tab.is_current() and "TabLineSel" or "TabLineFill"
                local hl_indicator = tab.is_current() and "TabLineTabIndicatorSel" or "TabLineTabIndicator"
                local tab_count = #vim.api.nvim_list_tabpages()
                local win_count = c.get_win_count(tab.id)

                return tab_count == 1 and ""
                    or {
                        { " ", hl = "TabLine" },
                        line.sep(c.set_sep_all("tab", "left", tab.is_current(), tab.id)),
                        { tab.number(), hl = hl_indicator },
                        line.sep(c.set_sep_all("tab", "inner_right", tab.is_current(), tab.id)),
                        c.tab_label(tab.id, tab.is_current()),
                        win_count > 1 and line.sep(c.set_sep_all("tab", "split", tab.is_current(), tab.id)) or "",
                        c.tab_win_count(tab.id),
                        line.sep(c.set_sep_all("tab", "inner_left", tab.is_current(), tab.id)),
                        { tab.close_btn(" " .. i.close[1]), hl = hl_indicator },
                        line.sep(c.set_sep_all("tab", "right", tab.is_current(), tab.id)),
                        hl = hl,
                        margin = "",
                    }
            end),
            { "%<" },
            hl = "TabLineFill",
        }
    end,
}

return M
