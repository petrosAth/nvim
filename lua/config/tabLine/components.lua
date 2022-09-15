local filename = require("tabby.module.filename")
local tab_name = require("tabby.feature.tab_name")
local t = require("config.themes.nord.highlights.statusBars").tabby
local i = require("styling").icons
local s = require("styling").separators.default

local M = {}

M.win_sel_number = 0

M.left_sep_icon = s[1]
M.right_sep_icon = s[2]
M.left_sep_icon_thin = s[3]
M.right_sep_icon_thin = s[4]

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

local function set_sep_icon(type, position, is_current, tab_id, win_id)
    local icon = position == "left" and M.left_sep_icon or M.right_sep_icon
    local has_custom_label = has_custom_label(tab_id)
    if type == "win" then
        if position == "left" then
            if is_current then
                icon = " "
            end
            if is_first_win(win_id) then
                icon = M.right_sep_icon .. " "
            end
        end
        if position == "right" then
            icon = M.right_sep_icon_thin
            if is_last_win(tab_id, win_id) then
                icon = M.right_sep_icon
            end
            if is_before_win_sel(is_current, win_id) then
                icon = M.right_sep_icon
            end
            if is_current then
                icon = M.right_sep_icon
            end
        end
    end
    if type == "tab" then
        if position == "inner_left" then
            icon = M.right_sep_icon
        end
        if position == "inner_right" then
            icon = M.right_sep_icon
            if has_custom_label then
                icon = M.right_sep_icon_thin
            end
        end
        if position == "split" then
            icon = M.right_sep_icon_thin
            if has_custom_label then
                icon = M.right_sep_icon
            end
        end
    end
    return icon
end

local function set_sep_hl(type, position, is_current, tab_id, win_id)
    win_id = win_id or 0
    local has_custom_label = has_custom_label(tab_id)
    local fg = is_current and t.TabLineSel or t.TabLineFill
    local bg = t.TabLine
    if type == "win" then
        bg = t.TabLineFill
        if position == "left" then
            if is_current then
                bg = t.TabLineSel
            end
            if is_first_win(win_id) then
                fg = t.TabLineTabSeparatorSel
                bg = is_current and t.TabLineSel or t.TabLineFill
            end
        elseif position == "right" then
            fg = t.TabLine
            if is_last_win(tab_id, win_id) then
                fg = t.TabLineFill
                bg = t.TabLine
            end
            if is_before_win_sel(is_current, win_id) then
                fg = t.TabLineFill
                bg = t.TabLineSel
            end
            if is_current then
                fg = t.TabLineSel
            end
        end
    end
    if type == "tab" then
        fg = is_current and t.TabLineTabSeparatorSel or t.TabLineTabSeparator
        if position == "inner_right" then
            if is_current then
                bg = t.TabLineSel
                if has_custom_label then
                    fg = t.TabLine
                    bg = t.TabLineTabSeparatorSel
                end
            else
                bg = t.TabLineFill
                if has_custom_label then
                    fg = t.TabLine
                    bg = t.TabLineTabSeparator
                end
            end
        end
        if position == "inner_left" then
            fg = is_current and t.TabLineSel or t.TabLineFill
            bg = is_current and t.TabLineTabSeparatorSel or t.TabLineTabSeparator
        end
        if position == "split" then
            if is_current then
                fg = t.TabLine
                bg = t.TabLineSel
                if has_custom_label then
                    fg = t.TabLineTabSeparatorSel
                    bg = t.TabLineSel
                end
            else
                fg = t.TabLine
                bg = t.TabLineFill
                if has_custom_label then
                    fg = t.TabLineTabSeparator
                    bg = t.TabLineFill
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
    local hl = is_current and t.TabLineIndicatorModifiedSel or t.TabLineIndicatorModified
    if is_modified then
        hl = is_current and t.TabLineIndicatorIsModifiedSel or t.TabLineIndicatorIsModified
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
    local hl = is_current and t.TabLineSel or t.TabLineFill
    if has_custom_label then
        hl = is_current and t.TabLineTabIndicatorSel or t.TabLineTabIndicator
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
    local label = " " .. i.windows[1] .. " " .. win_count
    return label
end

return M
