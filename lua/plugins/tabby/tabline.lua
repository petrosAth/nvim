local c = require("plugins.tabby.components")
local getHl = require("themes.utilities").getHl
local utils = require("plugins.tabby.utilities")
local icons = USER.styling.icons
local sep = USER.styling.separators.bars

return {
    line = function(line)
        return {
            {
                line.sep(sep.left, "TabLineIndicatorSel", "TabLineFill"),
                ("%s "):format(line.api.get_current_tab()),
                hl = "TabLineIndicatorSel",
                margin = "",
            },
            line.truncate_point(),
            line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
                local hl = win.is_current() and "TabLineSel" or "TabLine"
                local tab_id = line.api.get_current_tab()

                return {
                    line.sep("▏", "TabLineFill", hl),
                    c.modified_flag(win.id, win.is_current()),
                    c.file_icon("win", win.id, getHl(hl).bg),
                    c.win_label(win.id),
                    utils.is_last_win(tab_id, win.id) and line.sep(sep.right, hl, "TabLineFill") or " ",
                    hl = hl,
                    margin = "",
                }
            end),
            line.spacer(),
            line.tabs().foreach(function(tab)
                local hl = tab.is_current() and "TabLineSel" or "TabLine"
                local hl_indicator = tab.is_current() and "TabLineIndicatorSel" or "TabLineIndicator"
                local tab_count = #vim.api.nvim_list_tabpages()
                local win_count = utils.get_win_count(tab.id)

                return tab_count == 1 and ""
                    or {
                        line.sep(sep.left, hl_indicator, "TabLineFill"),
                        { ("%s "):format(tab.number()), hl = hl_indicator },
                        { " ", hl = hl },
                        c.file_icon("tab", tab.id, getHl(hl).bg),
                        c.tab_label(tab.id, tab.is_current()),
                        win_count == 1 and "" or line.sep((" %s "):format(sep.sep), hl_indicator, hl),
                        c.tab_win_count(tab.id),
                        line.sep((" %s "):format(sep.sep), hl_indicator, hl),
                        { tab.close_btn(("%s"):format(icons.close[1])), hl = hl },
                        line.sep(sep.right, hl, "TabLineFill"),
                        hl = hl,
                        margin = "",
                        { " ", hl = "TabLineFill" },
                    }
            end),
            {
                line.sep(sep.left, "TabLineIndicatorSel", "TabLineFill"),
                ("%s Neovim"):format(icons.neovim[1]),
                line.sep(sep.right, "TabLineIndicatorSel", "TabLineFill"),
                hl = "TabLineIndicatorSel",
                margin = "",
            },
            { "%<" },
            hl = "TabLineFill",
        }
    end,
}
