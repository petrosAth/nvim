local filename = require("tabby.filename")
local text = require("tabby.text")
local tab = require("tabby.tab")
local i = require("styling").icons
local s = require("styling").separators.default
local also_use_thin_separators = true

local components = {}
local c = components

c.modified_icon = i.edit[1]
c.left_separator_icon = s[1]
c.right_separator_icon = s[2]
c.left_separator_icon_thin = s[3]
c.right_separator_icon_thin = s[4]
c.tab_close_icon = i.close[1]

local plugin_list = {
    { filetype = "aerial",        window_title = "Code Outline"  },
    { filetype = "alpha",         window_title = "Dashboard"     },
    { filetype = "DiffviewFiles", window_title = "Diffview"      },
    { filetype = "minimap",       window_title = "Minimap"       },
    { filetype = "neo-tree",      window_title = "File Explorer" },
    { filetype = "NvimTree",      window_title = "File Explorer" },
    { filetype = "Outline",       window_title = "Code Outline"  },
    { filetype = "Trouble",       window_title = "List"          },
    { filetype = "undotree",      window_title = "Undo tree"     },
}

c.is_plugin = function(bufid)
    local filetype = vim.api.nvim_buf_get_option(bufid, "filetype")
    for _, plugin in pairs(plugin_list) do
        if filetype == plugin.filetype then
            return true, plugin.window_title
        end
    end
end

c.tab_label = function(tabid, current)
    local number = vim.api.nvim_tabpage_get_number(tabid)
    local name = tab.get_raw_name(tabid)
    local label = string.format("%d", number)
    if name ~= "" then
        label = string.format("%s", name)
    end
    if current then
        return { label, hl = "TabLineTabCurrent" }
    else
        return { label, hl = "TabLineTabInactive" }
    end
end

c.tab_top_window = function(tabid, current)
    local name = filename.unique(vim.api.nvim_tabpage_get_win(tabid))
    local bufid = vim.api.nvim_win_get_buf(vim.api.nvim_tabpage_get_win(tabid))
    local is_plugin, filetype = c.is_plugin(bufid)
    -- local label = string.format("%d : %s", bufid, name)
    local label = string.format("%s", name)
    if is_plugin then
        label = string.format("擄%s", filetype)
    end
    if current then
        return { label, hl = "TabLineWinCurrent" }
    else
        return { label, hl = "TabLineTabTopWin" }
    end
end

c.win_label = function(winid, current)
    local bufid = vim.api.nvim_win_get_buf(winid)
    local name = filename.unique(winid)
    local is_plugin, filetype = c.is_plugin(bufid)
    -- local label = string.format("%d : %s", bufid, name)
    local label = string.format("%s", name)
    if is_plugin then
        label = string.format("擄%s", filetype)
    end
    if current then
        return { label, hl = "TabLineWinCurrent" }
    else
        return { label, hl = "TabLineWinInactive" }
    end
end

c.modified_flag = function(current_window, modified)
    local flag = { " " .. c.modified_icon, hl = "TabLineWinModifiedCurrent" }
    if current_window then
        flag.hl = modified and "TabLineWinModifiedCurrent" or "TabLineWinFillCurrent"
    else
        flag.hl = modified and "TabLineWinModifiedInactive" or "TabLineWinFillInactive"
    end
    return flag
end

c.separators = function(first_window, last_window, current_window)
    local separator = {
        left = text.separator(c.left_separator_icon, "TabLineWinInactive", "TabLineWinInactive"),
        right = text.separator(c.right_separator_icon, "TabLineWinInactive", "TabLineWinInactive"),
    }
    -- Also use thin separators if true
    if also_use_thin_separators then
        separator.left = text.separator(c.left_separator_icon_thin, "TabLineWinCurrent", "TabLineWinInactive")
        separator.right = text.separator(c.right_separator_icon_thin, "TabLineWinCurrent", "TabLineWinInactive")
    end
    -- Active window separators
    if current_window then
        separator.left = text.separator(c.left_separator_icon, "TabLineWinCurrent", "TabLineWinInactive")
        separator.right = text.separator(c.right_separator_icon, "TabLineWinCurrent", "TabLineWinInactive")
    end
    -- Active tab right separator based on the backgrond of the first window(current/inactive)
    if first_window then
        if current_window then
            separator.left = text.separator("█ ", "TabLineTabCurrent", "TabLineWinCurrent")
        else
            separator.left = text.separator("█ ", "TabLineTabCurrent", "TabLineWinInactive")
        end
    end
    -- Last window's separator
    if last_window then
        if current_window then
            separator.right = text.separator(" █", "TabLineTabCurrent", "TabLineWinCurrent")
        else
            separator.right = text.separator(" █", "TabLineTabCurrent", "TabLineWinInactive")
        end
    end
    return separator
end

return components
