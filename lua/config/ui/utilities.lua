local i = USER.styling.icons

local M = {}

function M.check_for_custom_title(path, buftype, filetype)
    local SpecialBufTypes = {
        ["help"]     = i.help[1]     .. " Help",
        ["qf"]       = i.list[1]     .. " List",
        ["terminal"] = i.terminal[1] .. " Terminal",
    }
    local SpecialFileTypes = {
        ["aerial"]              = i.codeOutline[1]  .. " Code outline",
        ["alpha"]               = i.dashboard[1]    .. " Dashboard",
        ["Codewindow"]          = i.minimap[1]      .. " Minimap",
        ["diff"]                = i.diffview[1]     .. " Diff Panel",
        ["DiffviewFileHistory"] = i.diffview[1]     .. " Diffview history",
        ["DiffviewFiles"]       = i.diffview[1]     .. " Diffview files",
        ["help"]                = i.help[1]         .. " Help",
        ["lspinfo"]             = i.info[1]         .. " LSP info",
        ["man"]                 = i.help[1]         .. " Man page",
        ["mason"]               = i.info[1]         .. " Mason status",
        ["minimap"]             = i.minimap[1]      .. " Minimap",
        ["null-ls-info"]        = i.info[1]         .. " Null-ls info",
        ["NvimTree"]            = i.fileExplorer[1] .. " File explorer",
        ["Outline"]             = i.codeOutline[1]  .. " Code outline",
        ["packer"]              = i.info[1]         .. " Packer status",
        ["qf"]                  = i.list[1]         .. " List",
        ["Trouble"]             = i.list[1]         .. " List",
        ["TelescopePrompt"]     = i.telescope[1]    .. " Telescope",
        ["undotree"]            = i.undoTree[1]     .. " Undotree",
    }
    local SpecialFileNames = {
        { bufname = "%[Command Line%]",                     icon = i.history[1],      title = " history"                       },
        { bufname = "neo%-tree filesystem",                 icon = i.fileExplorer[1], title = " File explorer"                 },
        { bufname = "neo%-tree git_status",                 icon = i.git.repo[1],     title = " Git status"                    },
        { bufname = "neo%-tree buffers",                    icon = i.buffers[1],      title = " Open buffers"                  },
        { bufname = "^diffview:///null$",                   icon = i.file[1],         title = " Original file"                 },
        { bufname = "/:0:/",                                icon = i.file[1],         title = " Original file"                 },
        { bufname = "(/%.git/.+[a-z0-9]+[0-9]+[a-z0-9]+)/", icon = i.git.commit[1],   title = " ",              gitRepo = true },
    }

    for _, type in pairs(SpecialBufTypes) do
        -- local buftype_match = string.match(buftype, type.buftype)
        -- if buftype_match then
        --     return true, type.icon .. type.title
        -- end
        if _ == buftype then
            return true, type
        end
    end

    for _, type in pairs(SpecialFileTypes) do
        -- local filetype_match = string.match(filetype, type.filetype)
        -- if filetype_match then
        --     return true, type.icon .. type.title
        -- end
        if _ == filetype then
            return true, type
        end
    end

    local is_special = buftype == "nofile" and true or USER.is_diffview
    if is_special then
        for _, name in pairs(SpecialFileNames) do
            local filename_match = string.match(path, name.bufname)
            -- if vim.fn.fnamemodify(path, ":t") == name.bufname then
            if filename_match then
                if name.bufname == "%[Command Line%]" then
                    if vim.bo.filetype == "vim" then
                        return true, name.icon .. " Command line" .. name.title
                        -- return true, string.format("%s", filename_match == "[Command Line]")
                    else
                        return true, name.icon .. " Search" .. name.title
                        -- return true, filename_match
                    end
                end

                if name.gitRepo then
                    local commit = string.sub(filename_match, -11, -4)
                    return true, name.icon .. name.title .. commit
                    -- return true, filename_match
                end

                return true, name.icon .. name.title
                -- return true, filename_match
            end
        end
    end

    return false, ""
end

return M
