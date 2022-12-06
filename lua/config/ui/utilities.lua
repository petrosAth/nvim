local i = USER.styling.icons

local M = {}

local Labels = {
    -- buftypes
    ["help"]                 = i.help[1]         .. " Help",
    ["qf"]                   = i.list[1]         .. " List",
    ["terminal"]             = i.terminal[1]     .. " Terminal",
    -- filetypes
    ["aerial"]               = i.codeOutline[1]  .. " Code outline",
    ["alpha"]                = i.dashboard[1]    .. " Dashboard",
    ["Codewindow"]           = i.minimap[1]      .. " Minimap",
    ["diff"]                 = i.diffview[1]     .. " Diff Panel",
    ["DiffviewFileHistory"]  = i.diffview[1]     .. " Diffview history",
    ["DiffviewFiles"]        = i.diffview[1]     .. " Diffview files",
    ["lspinfo"]              = i.info[1]         .. " LSP info",
    ["man"]                  = i.help[1]         .. " Man page",
    ["mason"]                = i.info[1]         .. " Mason status",
    ["minimap"]              = i.minimap[1]      .. " Minimap",
    ["null-ls-info"]         = i.info[1]         .. " Null-ls info",
    ["NvimTree"]             = i.fileExplorer[1] .. " File explorer",
    ["Outline"]              = i.codeOutline[1]  .. " Code outline",
    ["packer"]               = i.info[1]         .. " Packer status",
    ["Trouble"]              = i.list[1]         .. " List",
    ["TelescopePrompt"]      = i.telescope[1]    .. " Telescope",
    ["undotree"]             = i.undoTree[1]     .. " Undotree",
    -- pattern matches
    ["DiffviewOriginalFile"] = i.file[1]         .. " Original file",
    ["DiffviewCommit"]       = i.git.commit[1]   .. " ",
    ["neo-tree filesystem"]  = i.fileExplorer[1] .. " File explorer",
    ["neo-tree git_status"]  = i.git.repo[1]     .. " Git status",
    ["neo-tree buffers"]     = i.buffers[1]      .. " Open buffers",
    [":"]                    = i.history[1]      .. " Command line history",
    ["/"]                    = i.history[1]      .. " Search history",
    ["?"]                    = i.history[1]      .. " Search history",
}

local function get_neo_tree_label(path)
    local match = string.match(path, "(neo%-tree .+) .*")

    if match then
        return true, Labels[match]
    end

    return false, ""
end

local function get_diffview_label(path)
    local Matches = {
        "^diffview:.+/(null)$", -- DiffviewOpen of undracked files
        "^diffview:.+/:(0):/", -- DiffviewOpen
        "^diffview:.+/%.git/.+/([a-z0-9]+[0-9]+[a-z0-9]+)/", -- DiffviewFileHistory
    }

    for index, pattern in pairs(Matches) do
        local match = string.match(path, pattern)

        if match then
            if index > 2 then
                return true, Labels["DiffviewCommit"] .. match
            end

            return true, Labels["DiffviewOriginalFile"]
        end
    end

    return false, ""
end

local function get_cmdwin_label(buftype)
    local match = vim.fn.getcmdwintype()

    if match ~= "" then
        return true, Labels[match]
    end

    return false, ""
end

function M.check_for_custom_title(path, buftype, filetype)
    if Labels[buftype] then
        return true, Labels[buftype]
    end

    if Labels[filetype] then
        return true, Labels[filetype]
    end

    if filetype == "neo-tree" then
        return get_neo_tree_label(path)
    end

    if USER.is_diffview > 0 then
        return get_diffview_label(path)
    end

    if buftype == "nofile" then
        return get_cmdwin_label(buftype)
    end

    return false, ""
end

return M
