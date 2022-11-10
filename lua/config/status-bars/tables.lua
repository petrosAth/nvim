local i = PA.styling.icons

local M = {}

M.Align = { provider = "%=" }

M.Null = { provider = "" }

M.Separator = {
    left  = { provider = " " },
    mid   = { provider = " " },
    right = { provider = " " },
}

M.Hide = {
    FileTypeBlock = {
        icon           = 20,
        value          = 40
    },
    FileFormatBlock = {
        icon           = 20,
        value          = 30
    },
    FileEncoding       = 30,
    FileReadOnly       = 50,
    FileModified       = 50,
    FilePath           = 60,
    FileName           = 70,
    Spell = {
        icon           = 20,
        value          = 40
    },
    Treesitter = {
        icon           = 20,
        value          = 30
    },
    CursorPosition     = 60,
    GitBranch          = 30,
    GitSigns = {
        icon           = 20,
        value          = 40
    },
    lspDiagnosticIcons = 40,
    lspIcon            = 50,
    lspClients         = 20
}

M.DisableBufType = {
    "prompt",
}

M.DisableFileType = {
    "alpha",
    "Codewindow",
    "lspinfo",
    "mason",
    "packer",
    "TelescopePrompt",
}

M.SpecialBufTypes = {
    { buftype = "nofile",   icon = "",            title = ""          },
    { buftype = "help",     icon = i.help[1],     title = " Help"     },
    { buftype = "qf",       icon = i.list[1],     title = " List"     },
    { buftype = "terminal", icon = i.terminal[1], title = " Terminal" },
}

M.SpecialFileTypes = {
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

M.SpecialFileNames = {
    { filename = "%[Command Line%]",                     icon = i.history[1],      title = " Search history"                },
    { filename = "neo%-tree filesystem",                 icon = i.fileExplorer[1], title = " File explorer"                 },
    { filename = "neo%-tree git_status",                 icon = i.git.repo[1],     title = " Git status"                    },
    { filename = "neo%-tree buffers",                    icon = i.buffers[1],      title = " Open buffers"                  },
    { filename = "^diffview:///null$",                   icon = i.file[1],         title = " Original file"                 },
    { filename = "/:0:/",                                icon = i.file[1],         title = " Original file"                 },
    { filename = "(/%.git/.+[a-z0-9]+[0-9]+[a-z0-9]+)/", icon = i.git.commit[1],   title = " ",              gitRepo = true },
}

M.ModeNames = {
    ["n"]     = "NORMAL",
    ["no"]    = "O-PENDING",
    ["nov"]   = "O-PENDING",
    ["noV"]   = "O-PENDING",
    ["no\22"] = "O-PENDING",
    ["niI"]   = "NORMAL",
    ["niR"]   = "NORMAL",
    ["niV"]   = "NORMAL",
    ["nt"]    = "NORMAL",
    ["v"]     = "VISUAL",
    ["vs"]    = "VISUAL",
    ["V"]     = "V-LINE",
    ["Vs"]    = "V-LINE",
    ["\22"]   = "V-BLOCK",
    ["\22s"]  = "V-BLOCK",
    ["s"]     = "SELECT",
    ["S"]     = "S-LINE",
    ["\19"]   = "S-BLOCK",
    ["i"]     = "INSERT",
    ["ic"]    = "INSERT",
    ["ix"]    = "INSERT",
    ["R"]     = "REPLACE",
    ["Rc"]    = "REPLACE",
    ["Rx"]    = "REPLACE",
    ["Rv"]    = "V-REPLACE",
    ["Rvc"]   = "V-REPLACE",
    ["Rvx"]   = "V-REPLACE",
    ["c"]     = "COMMAND",
    ["cv"]    = "EX",
    ["ce"]    = "EX",
    ["r"]     = "REPLACE",
    ["rm"]    = "MORE",
    ["r?"]    = "CONFIRM",
    ["!"]     = "SHELL",
    ["t"]     = "TERMINAL",
}

M.ModeHighlightGroups = {
    ["n"]   = "ModeNormal",
    ["i"]   = "ModeInsert",
    ["v"]   = "ModeVisual",
    ["V"]   = "ModeVisual",
    ["\22"] = "ModeVisual",
    ["c"]   = "ModeCommand",
    ["s"]   = "ModeVisual",
    ["S"]   = "ModeVisual",
    ["\19"] = "ModeVisual",
    ["R"]   = "ModeReplace",
    ["r"]   = "ModeReplace",
    ["!"]   = "ModeTerminal",
    ["t"]   = "ModeTerminal",
    ["h"]   = "ModeHydra",
}

return M
