local filename = require("tabby.module.filename")
local tab_name = require("tabby.feature.tab_name")
local i = require("styling").icons
local s = require("styling").separators.default
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

local function is_not_float_win(win_id)
  return vim.api.nvim_win_get_config(win_id).relative == ""
end

local function get_win_count(tab_id)
    local win_list = vim.api.nvim_tabpage_list_wins(tab_id)
    local win_list_no_floats = vim.tbl_filter(is_not_float_win, win_list)
    return #win_list_no_floats
end

local function is_last_win(tab_id, win_id)
    local win_count = get_win_count(tab_id)
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

local function has_custom_label(tab_id)
    local label = tab_name.get_raw(tab_id)
    if label ~= "" then
        return true, label
    end
    return false, ""
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
    TabLineIndicatorModified       = { fg = p.nord1,     bg = p.nord2                     },
    TabLineIndicatorModifiedSel    = { fg = p.nord1,     bg = p.nord3light                },
    TabLineIndicatorIsModified     = { fg = p.nord13,    bg = p.nord2                     },
    TabLineIndicatorIsModifiedSel  = { fg = p.nord13,    bg = p.nord3light                },

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

local function set_sep_icon(type, position, is_current, tab_id, win_id)
    local icon = position == "left" and "" or ""
    local has_custom_label = has_custom_label(tab_id)
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
            if is_last_win(tab_id, win_id) then
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
            icon = ""
        end
        if position == "inner_right" then
            icon = ""
            if has_custom_label then
                icon = ""
            end
        end
        if position == "split" then
            icon = ""
            if has_custom_label then
                icon = ""
            end
        end
    end
    return icon
end

local function set_sep_hl(type, position, is_current, tab_id, win_id)
    win_id = win_id or 0
    local has_custom_label = has_custom_label(tab_id)
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
            if is_last_win(tab_id, win_id) then
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
            if is_current then
                bg = M.theme.TabLineSel
                if has_custom_label then
                    fg = M.theme.TabLine
                    bg = M.theme.TabLineTabSeparatorSel
                end
            else
                bg = M.theme.TabLineFill
                if has_custom_label then
                    fg = M.theme.TabLine
                    bg = M.theme.TabLineTabSeparator
                end
            end
        end
        if position == "inner_left" then
            fg = is_current and M.theme.TabLineSel or M.theme.TabLineFill
            bg = is_current and M.theme.TabLineTabSeparatorSel or M.theme.TabLineTabSeparator
        end
        if position == "split" then
            if is_current then
                fg = M.theme.TabLine
                bg = M.theme.TabLineSel
                if has_custom_label then
                    fg = M.theme.TabLineTabSeparatorSel
                    bg = M.theme.TabLineSel
                end
            else
                fg = M.theme.TabLine
                bg = M.theme.TabLineFill
                if has_custom_label then
                    fg = M.theme.TabLineTabSeparator
                    bg = M.theme.TabLineFill
                end
            end
        end
    end
    return fg, bg
end

-- @param type (string: tab, win) tab or win
-- @param position (string: left, right, inner_left, inner_right) separator position
-- @param is_current (boolean) selected or not
-- @param tab_id (number) tab id
-- @param win_id (number) window id
function M.set_sep_all(type, position, is_current, tab_id, win_id)
    local icon = set_sep_icon(type, position, is_current, tab_id, win_id)
    local fg, bg = set_sep_hl(type, position, is_current, tab_id, win_id)
    return icon, fg, bg
end

local function is_plugin(buf_id)
    local plugin_list = {
        { filetype = "aerial",          window_title = i.codeOutline[1]  .. " Code outline"  },
        { filetype = "alpha",           window_title = i.dashboard[1]    .. " Dashboard"     },
        { filetype = "diff",            window_title = i.diffview[1]     .. " Diff Panel"    },
        { filetype = "minimap",         window_title = i.minimap[1]      .. " Minimap"       },
        { filetype = "neo-tree",        window_title = i.fileExplorer[1] .. " File explorer" },
        { filetype = "NvimTree",        window_title = i.fileExplorer[1] .. " File explorer" },
        { filetype = "Outline",         window_title = i.codeOutline[1]  .. " Code outline"  },
        { filetype = "Trouble",         window_title = i.list[1]         .. " List"          },
        { filetype = "TelescopePrompt", window_title = i.telescope[1]    .. " Telescope"     },
        { filetype = "undotree",        window_title = i.undoTree[1]     .. " Undotree"      },
    }
    local filetype = vim.api.nvim_buf_get_option(buf_id, "filetype")
    for _, plugin in pairs(plugin_list) do
        if filetype == plugin.filetype then
            return true, plugin.window_title
        end
    end
end

local function has_custom_name(tab_id, win_id)
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
    win_id = win_id ~= "" and win_id or vim.api.nvim_tabpage_get_win(tab_id)
    local fullPath = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(win_id))
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

M.win_label = function(win_id)
    local buf_id = vim.api.nvim_win_get_buf(win_id)
    local name = filename.unique(win_id)
    local is_plugin, title = is_plugin(buf_id)
    local has_custom_name, custom_name = has_custom_name("", win_id)
    -- local label = bufid .. " : " .. name
    local label = name
    if is_plugin then
        label = title
    end
    if has_custom_name then
        label = custom_name
    end
    return label
end

M.modified_flag = function(win_id, is_current)
    local buf_id = vim.api.nvim_win_get_buf(win_id)
    local is_modified = vim.bo[buf_id].modified
    local hl = is_current and M.theme.TabLineIndicatorModifiedSel or M.theme.TabLineIndicatorModified
    if is_modified then
        hl = is_current and M.theme.TabLineIndicatorIsModifiedSel or M.theme.TabLineIndicatorIsModified
    end
    return { " " .. i.edit[1], hl = hl }
end

local function tab_top_window(tab_id)
    local name = filename.unique(vim.api.nvim_tabpage_get_win(tab_id))
    local buf_id = vim.api.nvim_win_get_buf(vim.api.nvim_tabpage_get_win(tab_id))
    local is_plugin, filetype = is_plugin(buf_id)
    local has_custom_name, custom_name = has_custom_name(tab_id, "")
    -- local label = bufid .. " : " .. name
    local label = name
    if is_plugin then
        label = filetype
    end
    if has_custom_name then
        label = custom_name
    end
    return label
end

local function set_tab_label_hl(is_current, has_custom_label)
    local hl = is_current and M.theme.TabLineSel or M.theme.TabLineFill
    if has_custom_label then
        hl = is_current and M.theme.TabLineTabIndicatorSel or M.theme.TabLineTabIndicator
    end
    return hl
end

M.tab_label = function(tab_id, is_current)
    local label = tab_top_window(tab_id)
    local has_custom_label, custom_label = has_custom_label(tab_id)
    local hl = set_tab_label_hl(is_current, has_custom_label)
    if has_custom_label then
        label = custom_label
    end
    return { " " .. label, hl = hl }
end

M.tab_win_count = function(tab_id)
    local win_count = get_win_count(tab_id)
    local label = "  ⨯".. win_count
    return label
end

return M
