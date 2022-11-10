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
