local text = require("tabby.text")
local tab = require("tabby.tab")
-- local hl_mode = "lualine_a_" .. require("lualine.utils.mode").get_mode():lower()
local c = require("config.tabby.components")

require("tabby").setup({
    components = function()
        local coms = {}
        local tabs = vim.api.nvim_list_tabpages()
        local current_tab = vim.api.nvim_get_current_tabpage()
        for _, tabid in ipairs(tabs) do
            if tabid == current_tab then
                local wins = tab.all_wins(current_tab)
                local top_win = vim.api.nvim_tabpage_get_win(current_tab)
                table.insert(coms, {
                    type = "tab",
                    tabid = tabid,
                    label = c.tab_label(tabid, true),
                    left_sep = text.separator(c.left_separator_icon, "TabLineTabCurrent", "TabLineBody"),
                })
                for _, winid in ipairs(wins) do
                    local bufid = vim.api.nvim_win_get_buf(winid)
                    local modified = vim.bo[bufid].modified
                    local current_window = winid == top_win
                    local first_window = _ == 1
                    local last_window = next(wins, _) == nil
                    local left_separator = c.separators(first_window, last_window, current_window).left
                    local right_separator = c.separators(first_window, last_window, current_window).right
                    -- Add left window separator
                    -- and
                    -- Add window label
                    table.insert(coms, {
                        type = "win",
                        winid = winid,
                        label = winid == top_win and c.win_label(winid, true) or c.win_label(winid),
                        left_sep = left_separator,
                    })
                    -- Add modified sign
                    table.insert(coms, {
                        type = "text",
                        text = c.modified_flag(current_window, modified),
                    })
                    -- Add right window separator
                    table.insert(coms, {
                        type = "text",
                        text = right_separator,
                    })
                end
                -- empty space in line
                table.insert(coms, {
                    type = "text",
                    text = {
                        " ",
                        hl = "TabLineBody",
                    },
                })
                table.insert(coms, {
                    type = "spring",
                })
            end
        end
        if #tabs > 1 then
            for _, tabid in ipairs(tabs) do
                local last_tab = next(tabs, _) == nil
                if tabid == current_tab then
                    -- Add active tab number
                    table.insert(coms, {
                        type = "tab",
                        tabid = tabid,
                        label = c.tab_label(tabid, true),
                        left_sep = text.separator(c.left_separator_icon, "TabLineTabCurrent", "TabLineBody"),
                    })
                    -- Add active tab top window
                    table.insert(coms, {
                        type = "tab",
                        tabid = tabid,
                        label = c.tab_top_window(tabid, true),
                        left_sep = text.separator("█ ", "TabLineTabCurrent", "TabLineTabTopWinCurrent"),
                        right_sep = text.separator(" █", "TabLineTabCurrent", "TabLineTabTopWinCurrent"),
                    })
                    -- Add Tab close button
                    table.insert(coms, {
                        type = "text",
                        text = tab.close_btn(tabid, c.tab_close_icon, "TabLineTabCurrent", "TabLineTabCurrent"),
                    })
                    -- Add right tab separator
                    table.insert(coms, {
                        type = "text",
                        text = text.separator(c.right_separator_icon, "TabLineTabCurrent", "TabLineBody"),
                    })
                else
                    -- Add inactive tab number
                    table.insert(coms, {
                        type = "tab",
                        tabid = tabid,
                        label = c.tab_label(tabid),
                        left_sep = text.separator(c.left_separator_icon, "TabLineTabInactive", "TabLineBody"),
                    })
                    -- Add inactive tab top window
                    table.insert(coms, {
                        type = "tab",
                        tabid = tabid,
                        label = c.tab_top_window(tabid),
                        left_sep = text.separator("█ ", "TabLineTabInactive", "TabLineTabTopWinInactive"),
                        right_sep = text.separator(" █", "TabLineTabInactive", "TabLineTabTopWinInactive"),
                    })
                    -- Add inactive tab close button
                    table.insert(coms, {
                        type = "text",
                        text = tab.close_btn(tabid, c.tab_close_icon, "TabLineTabInactive", "TabLineTabInactive"),
                    })
                    -- Add right tab separator
                    table.insert(coms, {
                        type = "text",
                        text = text.separator(c.right_separator_icon, "TabLineTabInactive", "TabLineBody"),
                    })
                end
                if not last_tab then
                    -- space between tabs
                    table.insert(coms, {
                        type = "text",
                        text = {
                            " ",
                            hl = "TabLineBody",
                        },
                    })
                end
            end
        end

        return coms
    end,
})
