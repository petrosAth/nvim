local i = PA.styling.icons

local M = {}

function M.check_for_custom_title(path, buftype, filetype)
    local SpecialBufTypes = {
        { buftype = "nofile",   icon = "",            title = ""          },
        { buftype = "help",     icon = i.help[1],     title = " Help"     },
        { buftype = "qf",       icon = i.list[1],     title = " List"     },
        { buftype = "terminal", icon = i.terminal[1], title = " Terminal" },
    }
    local SpecialFileTypes = {
        { filetype = "aerial",              icon = i.codeOutline[1],  title = " Code outline"         },
        { filetype = "alpha",               icon = i.dashboard[1],    title = " Dashboard"            },
        { filetype = "diff",                icon = i.diffview[1],     title = " Diff Panel"           },
        { filetype = "DiffviewFileHistory", icon = i.diffview[1],     title = " Diffview history"     },
        { filetype = "DiffviewFiles",       icon = i.diffview[1],     title = " Diffview files"       },
        { filetype = "help",                icon = i.help[1],         title = " Help"                 },
        { filetype = "man",                 icon = i.help[1],         title = " Man page"             },
        { filetype = "minimap",             icon = i.minimap[1],      title = " Minimap"              },
        { filetype = "NvimTree",            icon = i.fileExplorer[1], title = " File explorer"        },
        { filetype = "Outline",             icon = i.codeOutline[1],  title = " Code outline"         },
        { filetype = "qf",                  icon = i.list[1],         title = " List"                 },
        { filetype = "Trouble",             icon = i.list[1],         title = " List"                 },
        { filetype = "TelescopePrompt",     icon = i.telescope[1],    title = " Telescope"            },
        { filetype = "undotree",            icon = i.undoTree[1],     title = " Undotree"             },
        { filetype = "vim",                 icon = i.history[1],      title = " Command line history" },
    }
    local SpecialFileNames = {
        { filename = "%[Command Line%]",                     icon = i.history[1],      title = " Search history"                },
        { filename = "neo%-tree filesystem",                 icon = i.fileExplorer[1], title = " File explorer"                 },
        { filename = "neo%-tree git_status",                 icon = i.git.repo[1],     title = " Git status"                    },
        { filename = "neo%-tree buffers",                    icon = i.buffers[1],      title = " Open buffers"                  },
        { filename = "^diffview:///null$",                   icon = i.file[1],         title = " Original file"                 },
        { filename = "/:0:/",                                icon = i.file[1],         title = " Original file"                 },
        { filename = "(/%.git/.+[a-z0-9]+[0-9]+[a-z0-9]+)/", icon = i.git.commit[1],   title = " ",              gitRepo = true },
    }

    for _, type in pairs(SpecialBufTypes) do
        local buftype_match = string.match(buftype, type.buftype)
        if buftype_match then
            if type.title ~= "" then
                return true, type.icon .. type.title
            end
        end
    end

    for _, type in pairs(SpecialFileTypes) do
        local filetype_match = string.match(filetype, type.filetype)
        if filetype_match then
            return true, type.icon .. type.title
        end
    end

    for _, name in pairs(SpecialFileNames) do
        local filename_match = string.match(path, name.filename)
        if filename_match then
            if name.gitRepo then
                local commit = string.sub(filename_match, -11, -4)
                return true, name.icon .. name.title .. commit
            end
            return true, name.icon .. name.title
        end
    end

    return false, ""
end

return M
