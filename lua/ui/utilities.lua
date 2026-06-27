local i = USER.styling.icons

local M = {}

local Labels = {
    -- buftypes
    ["help"]                      = string.format("%s Help",                 i.help[1]),
    ["qf"]                        = string.format("%s List",                 i.list[1]),
    ["terminal"]                  = string.format("%s Terminal",             i.terminal[1]),
    -- filetypes
    ["aerial"]                    = string.format("%s Code outline",         i.codeOutline[1]),
    ["alpha"]                     = string.format("%s Dashboard",            i.dashboard[1]),
    ["Codewindow"]                = string.format("%s Minimap",              i.minimap[1]),
    ["ccc-ui"]                    = string.format("%s Color picker",         i.palette[1]),
    ["checkhealth"]               = string.format("%s Checkhealth",          i.health[1]),
    ["diff"]                      = string.format("%s Diff Panel",           i.diffview[1]),
    ["codediff-history"]          = string.format("%s Diff history",         i.diffview[1]),
    ["codediff-explorer"]         = string.format("%s Diff files",           i.diffview[1]),
    ["Glance"]                    = string.format("%s Glance",               i.preview[1]),
    ["lazy"]                      = string.format("%s Lazy status",          i.lazy.lazy),
    ["man"]                       = string.format("%s Man page",             i.help[1]),
    ["mason"]                     = string.format("%s Mason status",         i.info[1]),
    ["minimap"]                   = string.format("%s Minimap",              i.minimap[1]),
    ["null-ls-info"]              = string.format("%s Null-ls info",         i.info[1]),
    ["NvimTree"]                  = string.format("%s File explorer",        i.fileExplorer[1]),
    ["Outline"]                   = string.format("%s Code outline",         i.codeOutline[1]),
    ["packer"]                    = string.format("%s Packer status",        i.info[1]),
    ["trouble"]                   = string.format("%s List",                 i.list[1]),
    ["fzf"]                       = string.format("%s fzf-lua",              i.fzf[1]),
    ["undotree"]                  = string.format("%s Undotree",             i.undoTree[1]),
    ["yeet-cache"]                = string.format("%s Command Cache",        i.terminal[1]),
    -- path matches
    ["CodeDiffOriginalFile"]      = string.format("%s Original file",        i.file[1]),
    ["CodeDiffCommit"]            = string.format("%s ",                     i.git.commit[1]),
    ["neo-tree filesystem"]       = string.format("%s File explorer",        i.fileExplorer[1]),
    ["neo-tree git_status"]       = string.format("%s Git status",           i.git.repo[1]),
    ["neo-tree buffers"]          = string.format("%s Open buffers",         i.buffers[1]),
    ["neo-tree document_symbols"] = string.format("%s Code outline",         i.codeOutline[1]),
    [":"]                         = string.format("%s Command history",      i.history[1]),
    ["/"]                         = string.format("%s Search history",       i.history[1]),
    ["?"]                         = string.format("%s Search history",       i.history[1]),
}

local function get_neo_tree_label(path)
    local match = string.match(path, "(neo%-tree .+) .*")

    if match then return Labels[match] end
end

local function get_codediff_label(path)
    -- codediff:///<git-root>///<commit>/<filepath>
    local commit = string.match(path, "^codediff:///.-///([^/]+)/")

    if not commit then return end

    if commit:match("^:%d+:?$") then return Labels["CodeDiffOriginalFile"] end -- index / staged

    if #commit > 7 and commit:match("^%x+$") then commit = commit:sub(1, 7) end -- shorten SHA

    return Labels["CodeDiffCommit"] .. commit
end

local function get_cmdwin_label()
    local match = vim.fn.getcmdwintype()

    if match ~= "" then return Labels[match] end
end

function M.get_buf_label(path, buftype, filetype)
    if Labels[buftype] then return Labels[buftype] end

    if Labels[filetype] then return Labels[filetype] end

    if filetype == "neo-tree" then return get_neo_tree_label(path) end

    if buftype == "nofile" then return get_cmdwin_label() end

    return get_codediff_label(path)
end

return M
