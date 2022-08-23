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
    { filetype = "aerial",          window_title = i.codeOutline[1]  .. " Code outline"  },
    { filetype = "alpha",           window_title = i.dashboard[1]    .. " Dashboard"     },
    { filetype = "minimap",         window_title = i.minimap[1]      .. " Minimap"       },
    { filetype = "neo-tree",        window_title = i.fileExplorer[1] .. " File explorer" },
    { filetype = "NvimTree",        window_title = i.fileExplorer[1] .. " File explorer" },
    { filetype = "Outline",         window_title = i.codeOutline[1]  .. " Code outline"  },
    { filetype = "Trouble",         window_title = i.list[1]         .. " List"          },
    { filetype = "TelescopePrompt", window_title = i.telescope[1]    .. " Telescope"     },
    { filetype = "undotree",        window_title = i.undoTree[1]     .. " Undotree"      },
}
local filename_list = {
    { filename = "%[Command Line%]",                     customFilename = i.history[1]    .. " History"                         },
    { filename = "neo%-tree git_status",                 customFilename = i.git.repo[1]   .. " Git status"                      },
    { filename = "neo%-tree buffers",                    customFilename = i.buffers[1]    .. " Open buffers"                    },
    { filename = "/:0:/",                                customFilename =                    "Original file"                    },
    { filename = "(/%.git/.+[a-z0-9]+[0-9]+[a-z0-9]+)/", customFilename = i.git.commit[1] .. " ",                gitRepo = true },
    { filename = "^diffview:///panels/.*History",        customFilename = i.diffview[1]   .. " Diffview history"                },
    { filename = "^diffview:///panels/.*",               customFilename = i.diffview[1]   .. " Diffview files"                  },
    { filename = "^diffview:///.*",                      customFilename = i.diffview[1]   .. " Diffview"                        }
}

c.is_plugin = function(bufid)
    local filetype = vim.api.nvim_buf_get_option(bufid, "filetype")
    for _, plugin in pairs(plugin_list) do
        if filetype == plugin.filetype then
            return true, plugin.window_title
        end
    end
end

c.has_custom_name = function(tabid, winid)
    local winid = winid ~= "" and winid or vim.api.nvim_tabpage_get_win(tabid)
    local fullPath = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(winid))
    for _, name in pairs(filename_list) do
        local filename_match = string.match(fullPath, name.filename)
        if filename_match then
            if name.gitRepo then
                local commit = string.sub(filename_match, -11, -4)
                return true, name.customFilename .. commit
            end
            return true, name.customFilename
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
    local has_custom_name, custom_name = c.has_custom_name(tabid, "")
    -- local label = string.format("%d : %s", bufid, name)
    local label = string.format("%s", name)
    if is_plugin then
        label = string.format("%s", filetype)
    end
    if has_custom_name then
        label = string.format("%s", custom_name)
    end
    if current then
        return { label, hl = "TabLineTabTopWinCurrent" }
    else
        return { label, hl = "TabLineTabTopWinInactive" }
    end
end

c.win_label = function(winid, current)
    local bufid = vim.api.nvim_win_get_buf(winid)
    local name = filename.unique(winid)
    local is_plugin, filetype = c.is_plugin(bufid)
    local has_custom_name, custom_name = c.has_custom_name("", winid)
    -- local label = string.format("%d : %s", bufid, name)
    local label = string.format("%s", name)
    if is_plugin then
        label = string.format("%s", filetype)
    end
    if has_custom_name then
        label = string.format("%s", custom_name)
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
    local fg = "TabLineWinInactive"
    local bg = "TabLineWinInactive"
    local separator = {
        left = text.separator(c.left_separator_icon, fg, bg),
        right = text.separator(c.right_separator_icon, fg, bg),
    }
    -- If enabled, use thin separators between windows
    if also_use_thin_separators then
        fg = "TabLineBody"
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
        separator.left = text.separator(c.right_separator_icon .. " ", fg, bg)
    end
    -- Last window separator
    if last_window then
        fg = current_window and "TabLineWinCurrent" or "TabLineWinInactive"
        bg = "TabLineBody"
        separator.right = text.separator(c.right_separator_icon, fg, bg)
    end
    return separator
end

return components
