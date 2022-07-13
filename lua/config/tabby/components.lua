local filename = require("tabby.module.filename")
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
    { filetype = "aerial",          window_title = "Code Outline"  },
    { filetype = "alpha",           window_title = "Dashboard"     },
    { filetype = "DiffviewFiles",   window_title = "Diffview"      },
    { filetype = "minimap",         window_title = "Minimap"       },
    { filetype = "neo-tree",        window_title = "File Explorer" },
    { filetype = "NvimTree",        window_title = "File Explorer" },
    { filetype = "Outline",         window_title = "Code Outline"  },
    { filetype = "Trouble",         window_title = "List"          },
    { filetype = "TelescopePrompt", window_title = "Telescope"     },
    { filetype = "undotree",        window_title = "Undo tree"     },
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
    local tabs = vim.api.nvim_list_tabpages()
    local fg = "TabLineWinInactive"
    local bg = "TabLineWinInactive"
    local separator = {
        left = text.separator(c.left_separator_icon, fg, bg),
        right = text.separator(c.right_separator_icon, fg, bg),
    }
    -- If enabled, use thin separators between windows
    if also_use_thin_separators then
        fg = "TabLineWinCurrent"
        separator.left = text.separator(c.left_separator_icon_thin, fg, bg)
        separator.right = text.separator(c.right_separator_icon_thin, fg, bg)
    end
    -- Active window separators
    if current_window then
        fg = "TabLineWinCurrent"
        separator.left = text.separator(c.left_separator_icon, fg, bg)
        separator.right = text.separator(c.right_separator_icon, fg, bg)
    end
    -- Active tab right separator based on the backgrond of the first window(current/inactive)
    if first_window then
        fg = "TabLineTabCurrent"
        bg = current_window and "TabLineWinCurrent" or "TabLineWinInactive"
        separator.left = text.separator("█ ", fg, bg)
    end
    -- Last window separator
    if last_window then
        fg = current_window and "TabLineWinCurrent" or "TabLineWinInactive"
        bg = "TabLineBody"
        separator.right = text.separator(c.right_separator_icon, fg, bg)
        -- When there are more than one tabs add a rectangular separator before close button
        if #tabs > 1 then
            fg = "TabLineTabCurrent"
            bg = current_window and "TabLineWinCurrent" or "TabLineWinInactive"
            separator.right = text.separator(" █", fg, bg)
        end
    end
    return separator
end

return components
