local M = {}

M.Hide = {
    FileTypeBlock = {
        icon = 20,
        value = 40,
    },
    FileFormatBlock = {
        icon = 20,
        value = 30,
    },
    FileEncoding = 30,
    FileSize = 30,
    FileReadOnly = 70,
    FileModified = 70,
    FileNameBlock = {
        path = 30,
        icon = 50,
        name = 60,
        symbol = 40,
    },
    Spell = {
        icon = 20,
        value = 40,
    },
    Treesitter = {
        icon = 20,
        value = 30,
    },
    PluginUpdates = {
        icon = 10,
        value = 15,
    },
    CursorPosition = 60,
    GitBranch = 30,
    GitSigns = {
        icon = 20,
        value = 40,
    },
    GitBlame = 20,
    nullLsIcon = 50,
    nullLsSources = 20,
    lspIcon = 50,
    lspClients = 20,
    lspDiagnosticIcons = 40,
}

M.Disable = {
    winBar = {
        buftype = {
            "nofile",
            "prompt",
        },
        filetype = {
            "aerial-nav",
            "alpha",
            "Codewindow",
            "ccc-ui",
            "checkhealth",
            "lazy",
            "man",
            "mason",
            "notify",
            "null-ls-info",
            "yeet-cache",
        },
    },
    statusLine = {
        buftype = {
            "nofile",
            "prompt",
        },
        filetype = {
            "alpha",
        },
    },
}

M.ModeNames = {
    ["n"] = "NORMAL",
    ["no"] = "O-PENDING",
    ["nov"] = "O-PENDING",
    ["noV"] = "O-PENDING",
    ["no\22"] = "O-PENDING",
    ["niI"] = "NORMAL",
    ["niR"] = "NORMAL",
    ["niV"] = "NORMAL",
    ["nt"] = "NORMAL",
    ["v"] = "VISUAL",
    ["vs"] = "VISUAL",
    ["V"] = "V-LINE",
    ["Vs"] = "V-LINE",
    ["\22"] = "V-BLOCK",
    ["\22s"] = "V-BLOCK",
    ["s"] = "SELECT",
    ["S"] = "S-LINE",
    ["\19"] = "S-BLOCK",
    ["i"] = "INSERT",
    ["ic"] = "INSERT",
    ["ix"] = "INSERT",
    ["R"] = "REPLACE",
    ["Rc"] = "REPLACE",
    ["Rx"] = "REPLACE",
    ["Rv"] = "V-REPLACE",
    ["Rvc"] = "V-REPLACE",
    ["Rvx"] = "V-REPLACE",
    ["c"] = "COMMAND",
    ["cv"] = "EX",
    ["ce"] = "EX",
    ["r"] = "REPLACE",
    ["rm"] = "MORE",
    ["r?"] = "CONFIRM",
    ["!"] = "SHELL",
    ["t"] = "TERMINAL",
}

M.ModeHighlightGroups = {
    ["n"] = "ModeNormal",
    ["i"] = "ModeInsert",
    ["v"] = "ModeVisual",
    ["V"] = "ModeVisual",
    ["\22"] = "ModeVisual",
    ["c"] = "ModeCommand",
    ["s"] = "ModeVisual",
    ["S"] = "ModeVisual",
    ["\19"] = "ModeVisual",
    ["R"] = "ModeReplace",
    ["r"] = "ModeReplace",
    ["!"] = "ModeTerminal",
    ["t"] = "ModeTerminal",
}

return M
