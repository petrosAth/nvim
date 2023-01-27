local M = {}

function M.get_highlight_groups(palette)
    local p = palette
    local g = {}

    g.editor = {
        Normal = { fg = p.cFg, bg = p.cBg },
        NormalNC = { fg = p.cFg, bg = p.cBg },
        NormalFloat = { fg = p.cFg, bg = p.cBgDark },
        FloatBorder = { fg = p.cFill1, bg = p.cBgDark },
        ColorColumn = { bg = p.cBgDim },
        Cursor = { reverse = true },
        lCursor = { link = "Cursor" },
        CursorIM = { link = "Cursor" },
        TermCursor = { link = "Cursor" },
        TermCursorNC = { link = "Cursor" },
        MatchParen = { bold = true, underline = true },
        NonText = { fg = p.cFill3 },
        Conceal = {},
        Whitespace = { fg = p.cFill3 },
        Pmenu = { fg = p.cFg, bg = p.cBgDark },
        PmenuSel = { fg = p.cCyan, bg = p.cFill4 },
        PmenuSbar = { fg = p.cFg, bg = p.cFill1 },
        PmenuThumb = { fg = p.cCyan, bg = p.cFill3 },
        SpecialKey = { fg = p.cFill4 },
        SpellBad = { sp = p.cRed, underdotted = true },
        SpellCap = { sp = p.cYellow, underdotted = true },
        SpellLocal = { sp = p.cFg, underdotted = true },
        SpellRare = { sp = p.cFgLight, underdotted = true },
        Visual = { bg = p.cFill4 },
        VisualNOS = { bg = p.cFill4 },
        Folded = { fg = p.cFgDim },
        FoldColumn = { fg = p.cFgDim },
        SignColumn = { fg = p.cFill2 },
        LineNrAbove = { link = "LineNr" },
        LineNr = { fg = p.cFill5 },
        LineNrBelow = { link = "LineNr" },
        CursorLineNr = { fg = p.cFg, bg = p.cFill1 },
        CursorLine = { bg = p.cFill1 },
        CursorColumn = { link = "CursorLine" },
        CursorLineSign = { link = "SignColumn" },
        CursorLineFold = { link = "FoldColumn" },
        Directory = { fg = p.cCyan },
        EndOfBuffer = { fg = p.cFill2 },
        ErrorMsg = { fg = p.cFg, bg = p.cRed },
        ModeMsg = { fg = p.cFg, bold = true },
        MoreMsg = { fg = p.cYellow },
        MsgArea = { link = "Normal" },
        WarningMsg = { fg = p.cYellow, bg = p.cBg, reverse = true },
        MsgSeparator = { fg = p.cFg, bg = p.cFill1 },
        Question = { fg = p.cFg },
        StatusLine = { fg = p.cFg, bg = p.cFill2 },
        StatusLineNC = { fg = p.cFgDim, bg = p.cFill2 },
        StatusLineTerm = { link = "StatusLine" },
        StatusLineTermNC = { link = "StatusLineNC" },
        WinBar = { fg = p.cFg, bg = p.cFill2 },
        WinBarNC = { fg = p.cFgDim, bg = p.cFill2 },
        WildMenu = { fg = p.cFill2, bg = p.cCyan },
        Search = { fg = p.cCyan, bg = p.cBg, reverse = true },
        IncSearch = { fg = p.cFgLight, bg = p.cSelect, underline = true },
        CurSearch = { fg = p.cFgLight, bg = p.cSelect, underline = true },
        Substitute = { fg = p.cFgLight, bg = p.cBg, reverse = true },
        TabLine = { fg = p.cFg, bg = p.cFill2 },
        TabLineSel = { fg = p.cFg, bg = p.cFill5 },
        TabLineFill = { fg = p.cFgDim, bg = p.cFill3 },
        Title = { fg = p.cSelect },
        WinSeparator = { fg = p.cFill2, bg = p.cBg },
        VertSplit = { link = "WinSeparator" },
        QuickFixLine = { fg = p.cBg, bg = p.cCyan },
        DiffText = { sp = p.cYellowDim, underdashed = true },
        DiffAdd = { bg = p.cGreenDim },
        DiffChange = { bg = p.cYellowDim },
        DiffDelete = { bg = p.cRedDim },
        diffAdded = { link = "DiffAdd" },
        diffChanged = { link = "DiffChange" },
        diffRemoved = { link = "DiffDelete" },
        Yank = { fg = p.cFgLight, bg = p.cSelect },
    }

    g.syntax = {
        Comment = { fg = p.cFill5, italic = true },

        Constant = { fg = p.cYellow, bold = true },
        String = { fg = p.cGreen, italic = true },
        Character = { fg = p.cGreen },
        Number = { fg = p.cOrange },
        Boolean = { fg = p.cOrange, italic = true },
        Float = { fg = p.cOrange },

        Identifier = { fg = p.cBlue },
        Function = { fg = p.cCyan, italic = true },

        Statement = { fg = p.cMagenta },
        Conditional = { fg = p.cMagenta },
        Repeat = { fg = p.cMagenta },
        Label = { fg = p.cMagenta },

        Operator = { fg = p.cSelect },
        Keyword = { fg = p.cFgLight, italic = true },
        Exception = { link = "Keyword" },

        PreProc = { fg = p.cSelect },
        Include = { link = "PreProc" },
        Define = { link = "PreProc" },
        Macro = { link = "PreProc" },
        PreCondit = { link = "PreProc" },

        Type = { fg = p.cViolet },
        StorageClass = { link = "Type" },
        Structure = { link = "Type" },
        Typedef = { link = "Type" },

        Special = { fg = p.cFgLight, bold = true, italic = true },
        SpecialChar = { link = "Special" },
        Tag = { link = "Special" },
        Delimiter = { link = "Special" },
        SpecialComment = { link = "Special" },
        Debug = { link = "Special" },

        Underlined = { underline = true },
        Ignore = {},
        Error = { fg = p.cRed, bold = true, underline = true },
        Todo = { fg = p.cFgLight },
    }

    g.lsp = {
        -- DocumentHighlight
        LspReferenceText = g.editor.Visual,
        LspReferenceRead = g.editor.Visual,
        LspReferenceWrite = g.editor.Visual,
        -- Neovim LspSignatureHelp
        LspSignatureActiveParameter = { fg = g.syntax.Operator.fg, reverse = true },
        -- lspinfo window
        LspInfoBorder = { link = "FloatBorder" },
    }

    g.diagnostic = {
        DiagnosticError = { fg = p.cRed },
        DiagnosticWarn = { fg = p.cYellow },
        DiagnosticInfo = { fg = p.cCyan },
        DiagnosticHint = { fg = p.cSelect },
        DiagnosticSignError = { link = "DiagnosticError" },
        DiagnosticSignWarn = { link = "DiagnosticWarn" },
        DiagnosticSignInfo = { link = "DiagnosticInfo" },
        DiagnosticSignHint = { link = "DiagnosticHint" },
        DiagnosticFloatingWarn = { link = "DiagnosticError" },
        DiagnosticFloatingError = { link = "DiagnosticWarn" },
        DiagnosticFloatingInfo = { link = "DiagnosticInfo" },
        DiagnosticFloatingHint = { link = "DiagnosticHint" },
        DiagnosticUnderlineError = { undercurl = true, sp = p.cRed },
        DiagnosticUnderlineWarn = { undercurl = true, sp = p.cYellow },
        DiagnosticUnderlineInfo = { undercurl = true, sp = p.cCyan },
        DiagnosticUnderlineHint = { undercurl = true, sp = p.cSelect },
        DiagnosticVirtualTextError = { fg = p.cRed, bold = true, italic = true },
        DiagnosticVirtualTextWarn = { fg = p.cYellow, bold = true, italic = true },
        DiagnosticVirtualTextInfo = { fg = p.cCyan, bold = true, italic = true },
        DiagnosticVirtualTextHint = { fg = p.cSelect, bold = true, italic = true },
    }

    g.treesitter = {
        ["@comment"]               = g.syntax.Comment,
        ["@debug"]                 = g.syntax.Debug,
        -- ["@error"]                 = g.syntax.Error,
        -- ["@none"]                  = { },
        ["@preproc"]               = g.syntax.PreProc,
        ["@punctuation.delimiter"] = g.syntax.Delimiter,
        ["@punctuation.bracket"]   = g.syntax.Special,
        ["@punctuation.special"]   = { fg = p.cCyan },

        ["@constant"]              = g.syntax.Constant,
        ["@constant.builtin"]      = g.syntax.Constant,
        ["@constant.macro"]        = g.syntax.Constant,
        ["@string"]                = g.syntax.String,
        ["@string.regex"]          = g.syntax.SpecialChar,
        ["@string.escape"]         = { fg = p.cMagenta },
        ["@string.special"]        = g.syntax.Special,
        ["@character"]             = g.syntax.Character,
        ["@character.special"]     = g.syntax.Special,
        ["@number"]                = g.syntax.Number,
        ["@boolean"]               = g.syntax.Boolean,
        ["@float"]                 = g.syntax.Float,

        ["@function"]              = { fg = g.syntax.Function.fg, bold = true },
        ["@function.builtin"]      = { fg = g.syntax.Function.fg, bold = true },
        ["@function.call"]         = { fg = g.syntax.Function.fg, bold = true },
        ["@function.macro"]        = { fg = g.syntax.Function.fg, bold = true },
        ["@parameter"]             = { fg = g.syntax.Constant.fg },
        ["@structure"]             = g.syntax.Structure,
        ["@method"]                = { fg = g.syntax.Function.fg, bold = true },
        ["@method.call"]           = { fg = g.syntax.Function.fg, bold = true },
        ["@field"]                 = g.syntax.Special,
        ["@field.lua"]             = { fg = g.editor.Normal.fg },
        ["@property"]              = g.syntax.Identifier,
        ["@constructor"]           = g.syntax.Keyword,

        ["@conditional"]           = g.syntax.Conditional,
        ["@repeat"]                = g.syntax.Repeat,
        ["@label"]                 = g.syntax.Label,
        ["@keyword"]               = g.syntax.Keyword,
        ["@keyword.function"]      = g.syntax.Function,
        ["@keyword.operator"]      = g.syntax.Operator,
        ["@keyword.return"]        = { fg = p.cRed },
        ["@operator"]              = g.syntax.Operator,
        ["@exception"]             = g.syntax.Exception,
        ["@include"]               = g.syntax.Include,
        ["@storageclass"]          = g.syntax.StorageClass,
        ["@type"]                  = g.syntax.Type,
        ["@type.builtin"]          = g.syntax.Type,
        ["@type.definition"]       = g.syntax.Typedef,
        ["@type.qualifier"]        = g.syntax.Type,
        ["@namespace"]             = g.syntax.Identifier,
        ["@symbol"]                = g.syntax.Identifier,
        ["@attribute"]             = g.syntax.Constant,

        ["@variable"]              = { fg = g.editor.Normal.fg },
        ["@variable.builtin"]      = { fg = g.editor.Normal.fg, bold = true },
        ["@variable.global"]       = { fg = g.editor.Normal.fg, bold = true },

        ["@text"]                  = { fg = g.editor.Normal.fg },
        ["@text.strong"]           = { bold = true },
        ["@text.emphasis"]         = { italic = true },
        ["@text.underline"]        = { underline = true },
        ["@text.strike"]           = { strikethrough = true },
        ["@text.title"]            = g.editor.Title,
        ["@text.title.html"]       = { fg = g.editor.Normal.fg },
        ["@text.literal"]          = g.syntax.Delimiter,
        ["@text.uri"]              = { fg = p.cBlue, italic = true },
        ["@text.math"]             = g.syntax.Number,
        ["@text.todo.checked"]     = { fg = p.cGreen },
        ["@text.todo.unchecked"]   = g.syntax.Todo,
        -- ["@text.environment"]      = {},
        -- ["@text.environment.name"] = {},
        ["@text.reference"]        = g.syntax.SpecialComment,
        ["@text.note"]             = g.diagnostic.DiagnosticHint,
        ["@text.warning"]          = g.diagnostic.DiagnosticWarn,
        ["@text.danger"]           = g.diagnostic.DiagnosticError,
        ["@todo"]                  = g.diagnostic.DiagnosticInfo,
        ["@tag"]                   = g.syntax.Tag,
        ["@tag.attribute"]         = g.syntax.Label,
        -- ["@tag.delimiter"]         = g.syntax.Delimiter,
    }

    g.StatusBars = {
        ModeInactive = { fg = p.cFill2, bg = p.cCyan },
        ModeVisual = { fg = p.cFill2, bg = p.cYellow },
        ModeReplace = { fg = p.cFill2, bg = p.cRed },
        ModeNormal = { fg = p.cFill2, bg = p.cCyan },
        ModeInsert = { fg = p.cFill2, bg = p.cFgLight },
        ModeCommand = { fg = p.cFill2, bg = p.cViolet },
        ModeTerminal = { fg = p.cFill2, bg = p.cOrange },
        ModeHydra = { fg = p.cFill2, bg = p.cMagenta },
        StatusLineLight = { fg = p.cFg, bg = p.cFill4 },
        StatusLinePluginUpdates = { fg = p.cViolet },
        WinBarLight = { fg = g.editor.WinBar.fg, bg = p.cFill4 },
        WinBarLightNC = { link = "WinBarLight" },
        WinBarFile = { fg = p.cFgLight, bg = p.cFill4 },
        WinBarFileNC = { fg = g.editor.WinBarNC.fg },
        WinBarSpecial = { fg = p.cFgLight },
        WinBarSpecialNC = { fg = g.editor.WinBarNC.fg },
        WinBarIsModified = { fg = p.cYellow },
        WinBarIsReadOnly = { fg = p.cFgLight },
        WinBarWindowNumber = { fg = p.cFgLight },
        WinBarCloseButton = { fg = g.editor.WinBar.fg },
        TabLineHeader = { fg = p.cFill2, bg = p.cCyan },
        TabLineBuffer = { fg = p.cFg, bg = p.cFill4 },
        TabLineBufferNC = { fg = p.cFgDim, bg = p.cFill2 },
        TabLineTabSeparator = { fg = p.cFg, bg = p.cFill4 },
        TabLineTabSeparatorSel = { fg = p.cFill2, bg = p.cCyan },
        TabLineTabIndicator = { fg = p.cFg, bg = p.cFill4 },
        TabLineTabIndicatorSel = { fg = p.cFill2, bg = p.cCyan },
        TabLineIndicatorModified = { fg = p.cBgDim, bg = p.cFill2 },
        TabLineIndicatorModifiedSel = { fg = p.cBgDim, bg = p.cFill4 },
        TabLineIndicatorIsModified = { fg = p.cYellow, bg = p.cFill2 },
        TabLineIndicatorIsModifiedSel = { fg = p.cYellow, bg = p.cFill4 },
    }

    g.SidePanel = {
        SidePanelNormal       = { fg = g.editor.NormalFloat.fg,  bg = p.cBgDim },
        SidePanelNormalNC     = { link = "SidePanelNormal" },
        SidePanelWinSeparator = { fg = g.editor.WinSeparator.fg, bg = p.cBgDim },
        SidePanelNonText      = { fg = g.editor.NonText.fg,      bg = p.cBgDim }
    }

    g.plugins = {
        -- alpha-nvim
        AlphaButtons = { fg = p.cFg },
        AlphaButtonShortcuts = { fg = p.cCyan },
        AlphaHeader = { fg = p.cBlue },
        AlphaFooter = { fg = p.cFill5 },

        -- codewindow.nvim
        CodewindowBackground = { link = "NormalFloat" },
        CodewindowBorder = { link = "FloatBorder" },
        CodewindowWarn = { link = "DiagnosticWarn" },
        CodewindowError = { link = "DiagnosticError" },
        CodewindowDeletion = { link = "GitSignsDelete" },
        CodewindowAddition = { link = "GitSignsAdd" },
        CodewindowUnderline = { underline = true, sp = p.cCyan },

        -- diffview.nvim
        DiffviewNormal = { link = "SidePanelNormal" },
        DiffviewWinSeparator = { link = "SidePanelWinSeparator" },
        DiffviewVertSplit = { link = "SidePanelWinSeparator" },
        DiffviewEndOfBuffer = { fg = g.SidePanel.SidePanelNormal.bg },
        DiffviewNonText = { link = "SidePanelNonText" },

        -- fidget.nvim
        FidgetTitle = { fg = p.cFgDim },
        FidgetTask = { fg = g.syntax.Comment.fg, bg = g.editor.Normal.bg },

        -- gitsigns.nvim
        GitSignsCurrentLineBlame = { fg = p.cFgDim, bold = true, italic = true },
        GitSignsAdd = { fg = p.cGreen },
        GitSignsAddNr = { fg = p.cGreen, bg = p.cFill2 },
        GitSignsAddLn = { bg = p.cGreenDark },
        GitSignsChange = { fg = p.cYellow },
        GitSignsChangeNr = { fg = p.cYellow, bg = p.cFill2 },
        GitSignsChangeLn = { bg = p.cYellowDark },
        GitSignsDelete = { fg = p.cRed },
        GitSignsDeleteNr = { fg = p.cRed, bg = p.cFill2 },
        GitSignsDeleteLn = { bg = p.cRedDark },
        GitSignsAddInline = { bg = p.cGreenDim },
        GitSignsChangeInline = { bg = p.cYellowDim },
        GitSignsDeleteInline = { bg = p.cRedDim },

        -- hop.nvim
        HopNextKey = { fg = p.cCyan, bold = true },
        HopNextKey1 = { fg = p.cCyan },
        HopNextKey2 = { fg = p.cFg },
        HopUnmatched = { fg = p.cFill4 },

        -- hydra.nvim
        HydraHint = { link = "NormalFloat" },
        HydraAmaranth = { fg = p.cOrange },
        HydraTeal = { fg = p.cViolet },
        HydraPink = { fg = p.cMagenta },
        HydraBlue = { fg = p.cSelect },
        HydraRed = { fg = p.cRed },

        -- incline.nvim
        InclineNormal = { fg = p.nord5, bg = p.cFill4 },
        InclineNormalNC = { link = "InclineNormal" },

        -- indent-blankline.nvim
        IndentBlanklineContextChar = { fg = p.cViolet },
        IndentBlanklineContextStart = { underline = true, sp = p.cViolet },
        IndentBlanklineSpaceCharBlankline = { fg = p.cFill2 },
        IndentBlanklineSpaceChar = { fg = p.cFill2 },
        IndentBlanklineChar = { fg = p.cFill2 },
        IndentBlanklineIndent1 = { bg = p.cBgDim, nocombine = true  },
        IndentBlanklineIndent2 = { bg = p.cBg, nocombine = true  },

        -- lazy.nvim
        LazyH1 = { fg = g.editor.IncSearch.fg, bg = g.editor.IncSearch.bg },

        -- leap.nvim
        LeapMatch = { fg = p.cYellow, underline = true, nocombine = true },
        LeapLabelPrimary = { fg = g.editor.Normal.bg, bg = g.editor.Normal.fg, nocombine = true },
        LeapLabelSecondary = { fg = p.cBg, bg = p.cFgDim, bold = true, nocombine = true },
        LeapLabelSelected = { fg = p.cBg, bg = p.cSelect },
        LeapBackdrop = { fg = p.cFgDim },

        -- mini.nvim
        MiniCursorword = { link = "Visual" },
        MiniCursorwordCurrent = { bold = true },

        -- nvim-cmp
        CmpGhostText = { fg = p.cFill5, bold = true },

        CmpItemMenu = { fg = p.cFill5 },

        CmpItemAbbr = { fg = p.cFg },
        CmpItemAbbrDeprecated = { fg = p.cRed, strikethrough = true },
        CmpItemAbbrMatch = { fg = p.cSelect, bold = true },
        CmpItemAbbrMatchFuzzy = { link = "CmpItemAbbrMatch" },

        CmpItemKind = { fg = g.editor.Normal.fg },
        CmpItemKindTypeParameter = { link = "@type" },
        CmpItemKindConstructor = { link = "@constructor" },
        CmpItemKindEnum = { link = "@field" },
        CmpItemKindEnumMember = { link = "@field" },
        CmpItemKindReference = g.editor.Visual,
        CmpItemKindInterface = { link = "@type" },
        CmpItemKindClass = { link = "@structure" },
        CmpItemKindVariable = { link = "@variable" },
        CmpItemKindProperty = { link = "@property" },
        CmpItemKindOperator = { link = "@operator" },
        CmpItemKindFunction = { link = "@function" },
        CmpItemKindConstant = { link = "@constant" },
        CmpItemKindSnippet = g.syntax.String,
        CmpItemKindKeyword = { link = "@keyword" },
        CmpItemKindStruct = g.syntax.Structure,
        CmpItemKindModule = { link = "@include" },
        CmpItemKindMethod = { link = "@method" },
        CmpItemKindFolder = g.editor.Directory,
        CmpItemKindFile = g.editor.Directory,
        CmpItemKindValue = { link = "@keyword" },
        CmpItemKindField = { link = "@field" },
        CmpItemKindUnit = { link = "@number" },
        CmpItemKindText = { link = "@text" },

        -- nvim-hlslens
        HlSearchNear = { link = "IncSearch" },
        HlSearchLensNear = { fg = p.cFg, reverse = true },
        HlSearchLens = { fg = p.cFill5, reverse = true },
        HlSearchFloat = { link = "IncSearch" },

        -- nvim-navic
        NavicIconsFile = { fg = g.editor.Directory.fg, bg = g.editor.WinBar.bg },
        NavicIconsModule = { fg = g.treesitter["@include"].fg, bg = g.editor.WinBar.bg },
        NavicIconsNamespace = { fg = g.treesitter["@namespace"].fg, bg = g.editor.WinBar.bg },
        NavicIconsPackage = { fg = g.treesitter["@include"].fg, bg = g.editor.WinBar.bg },
        NavicIconsClass = { fg = g.treesitter["@structure"].fg, bg = g.editor.WinBar.bg },
        NavicIconsMethod = { fg = g.treesitter["@method"].fg, bg = g.editor.WinBar.bg },
        NavicIconsProperty = { fg = g.treesitter["@property"].fg, bg = g.editor.WinBar.bg },
        NavicIconsField = { fg = g.treesitter["@field"].fg, bg = g.editor.WinBar.bg },
        NavicIconsConstructor = { fg = g.treesitter["@constructor"].fg, bg = g.editor.WinBar.bg },
        NavicIconsEnum = { fg = g.treesitter["@field"].fg, bg = g.editor.WinBar.bg },
        NavicIconsInterface = { fg = g.treesitter["@type"].fg, bg = g.editor.WinBar.bg },
        NavicIconsFunction = { fg = g.treesitter["@function"].fg, bg = g.editor.WinBar.bg },
        NavicIconsVariable = { fg = g.treesitter["@variable"].fg, bg = g.editor.WinBar.bg },
        NavicIconsConstant = { fg = g.treesitter["@constant"].fg, bg = g.editor.WinBar.bg },
        NavicIconsString = { fg = g.treesitter["@string"].fg, bg = g.editor.WinBar.bg },
        NavicIconsNumber = { fg = g.treesitter["@number"].fg, bg = g.editor.WinBar.bg },
        NavicIconsBoolean = { fg = g.treesitter["@boolean"].fg, bg = g.editor.WinBar.bg },
        NavicIconsArray = { fg = g.treesitter["@field"].fg, bg = g.editor.WinBar.bg },
        NavicIconsObject = { fg = g.treesitter["@type"].fg, bg = g.editor.WinBar.bg },
        NavicIconsKey = { fg = g.treesitter["@keyword"].fg, bg = g.editor.WinBar.bg },
        NavicIconsNull = { fg = g.treesitter["@comment"].fg, bg = g.editor.WinBar.bg },
        NavicIconsEnumMember = { fg = g.treesitter["@field"].fg, bg = g.editor.WinBar.bg },
        NavicIconsStruct = { fg = g.treesitter["@structure"].fg, bg = g.editor.WinBar.bg },
        NavicIconsEvent = { fg = g.treesitter["@keyword"].fg, bg = g.editor.WinBar.bg },
        NavicIconsOperator = { fg = g.treesitter["@operator"].fg, bg = g.editor.WinBar.bg },
        NavicIconsTypeParameter = { fg = g.treesitter["@type"].fg, bg = g.editor.WinBar.bg },
        NavicText = { fg = g.treesitter["@text"].fg, bg = g.editor.WinBar.bg },
        NavicSeparator = g.editor.WinBar,

        -- nvim-notify
        NotifyERRORTitle = { fg = p.cRed, bg = g.editor.NormalFloat.bg },
        NotifyWARNTitle = { fg = p.cYellow, bg = g.editor.NormalFloat.bg },
        NotifyINFOTitle = { fg = p.cCyan, bg = g.editor.NormalFloat.bg },
        NotifyDEBUGTitle = { fg = p.cOrange, bg = g.editor.NormalFloat.bg },
        NotifyTRACETitle = { fg = p.cSelect, bg = g.editor.NormalFloat.bg },
        NotifyERRORIcon = { fg = p.cRed, bg = g.editor.NormalFloat.bg },
        NotifyWARNIcon = { fg = p.cYellow, bg = g.editor.NormalFloat.bg },
        NotifyINFOIcon = { fg = p.cCyan, bg = g.editor.NormalFloat.bg },
        NotifyDEBUGIcon = { fg = p.cOrange, bg = g.editor.NormalFloat.bg },
        NotifyTRACEIcon = { fg = p.cSelect, bg = g.editor.NormalFloat.bg },
        NotifyERRORBorder = { link = "FloatBorder" },
        NotifyWARNBorder = { link = "FloatBorder" },
        NotifyINFOBorder = { link = "FloatBorder" },
        NotifyDEBUGBorder = { link = "FloatBorder" },
        NotifyTRACEBorder = { link = "FloatBorder" },
        NotifyERRORBody = { link = "NormalFloat" },
        NotifyWARNBody = { link = "NormalFloat" },
        NotifyINFOBody = { link = "NormalFloat" },
        NotifyDEBUGBody = { link = "NormalFloat" },
        NotifyTRACEBody = { link = "NormalFloat" },

        -- nvim-scrollbar
        ScrollBarHandle = { bg = p.cFill3 },
        ScrollBarError = { link = "DiagnosticError" },
        ScrollBarWarn = { link = "DiagnosticWarn" },
        ScrollBarInfo = { link = "DiagnosticInfo" },
        ScrollBarHint = { link = "DiagnosticHint" },
        ScrollBarMisc = { fg = p.cFg },
        ScrollBarSearch = { link = "Search" },

        -- nvim-ts-rainbow
        rainbowcol1 = { fg = g.syntax.Special.fg },
        rainbowcol2 = { fg = p.cMagenta },
        rainbowcol3 = { fg = p.cOrange },
        rainbowcol4 = { fg = p.cSelect },
        rainbowcol5 = { fg = p.cFgLight },
        rainbowcol6 = { fg = p.cYellow },
        rainbowcol7 = { fg = p.cCyan },

        -- nvim-windowpicker
        WindowPicker = { fg = p.cBgDark, bg = p.cCyan, bold = true },
        WindowPickerNC = { link = "WindowPicker" },

        -- neo-tree.nvim
        NeoTreeNormal = { link = "SidePanelNormal" },
        NeoTreeNormalNC = { link = "SidePanelNormalNC" },
        NeoTreePreview = { fg = p.cFg, bg = p.cFill5 },
        NeoTreeFloatNormal = { fg = g.editor.Normal.fg, bg = p.cBgDim },
        NeoTreeFloatBorder = { fg = g.editor.FloatBorder.fg, bg = p.cBgDim },
        NeoTreeFloatTitle = { fg = p.cCyan, bg = p.cFill3, bold = true },
        NeoTreeWinSeparator = { link = "SidePanelWinSeparator" },

        NeoTreeTabActive = { fg = p.cFg, bg = p.cFill5 },
        NeoTreeTabInactive = { fg = p.cFg, bg = p.cFill3 },
        NeoTreeTabBarBackground = { link = "StatusLine" },
        NeoTreeTabSeparatorActive = { fg = p.cFill4, bg = p.cFill5 },
        NeoTreeTabSeparatorInactive = { fg = p.cFill2, bg = p.cFill3 },

        NeoTreeRootName = { fg = p.cFgLight, bold = true, italic = true },
        NeoTreeIndentMarker = { link = "FoldColumn" },
        NeoTreeFileNameOpened = { bold = true, nocombine = true },
        NeoTreeBufferNumber = { fg = p.cFgLight },
        NeoTreeDotfile = { fg = p.cFill5 },
        NeoTreeSymbolicLinkTarget = { fg = p.cViolet, bold = true },

        NeoTreeMessage = { fg = p.cMagenta },
        NeoTreeDimText = { fg = p.cFill4 },
        NeoTreeFadeText1 = { link = "NeoTreeDotfile" },
        NeoTreeFadeText2 = { link = "NeoTreeDimText" },

        NeoTreeModified = { link = "GitSignsChange" },
        NeoTreeGitAdded = { link = "GitSignsAdd" },
        NeoTreeGitModified = { link = "GitSignsChange" },
        NeoTreeGitDeleted = { link = "GitSignsDelete" },
        NeoTreeGitRenamed = { link = "NeoTreeGitModified" },
        NeoTreeGitUntracked = { fg = p.cSelect },
        NeoTreeGitIgnored = { link = "NeoTreeDotfile" },
        NeoTreeGitUnstaged = { link = "NeoTreeGitModified" },
        NeoTreeGitStaged = { link = "NeoTreeGitAdded" },
        NeoTreeGitConflict = { fg = p.cOrange },

        -- null-ls.nvim
        NullLsInfoSources = { link = "Title" },
        NullLsInfoHeader = { link = "Label" },
        NullLsInfoBorder = { link = "FloatBorder" },
        NullLsInfoTitle = { link = "Type" },

        -- symbols-outline.nvim
        SymbolsOutlineConnector = { link = "FoldColumn" },

        -- quickscope.lua
        QuickScopePrimary = { fg = p.cYellow, bg = p.cBg, underline = true, nocombine = true },
        QuickScopeSecondary = { fg = p.cMagenta, bg = p.cBg, bold = true, nocombine = true },

        -- satellite.nvim
        ScrollView = { bg = p.cFill3 },
        SearchSV = { fg = p.cCyan },

        -- telescope.nvim
        TelescopePromptPrefix = { fg = p.cFg, bold = true },
        TelescopePromptCounter = { fg = p.cViolet, bold = true },

        TelescopeNormal = { fg = p.cFg, bg = p.cBgDark },
        TelescopeResultsNormal = { fg = p.cBlue, bg = p.cBgDark },
        TelescopePreviewNormal = { fg = p.cFg, bg = p.cBgDim },
        TelescopePromptNormal = { fg = p.cFgLight, bg = p.cBgDim },

        TelescopeResultsTitle = { fg = p.cCyan, bg = p.cFill3, bold = true },
        TelescopePreviewTitle = { fg = p.cBlue, bg = p.cFill3, bold = true },
        TelescopePromptTitle = { fg = p.cFg, bg = p.cFill3, bold = true },

        TelescopeResultsBorder = { fg = p.cFill3, bg = p.cBgDark },
        TelescopePreviewBorder = { fg = p.cFill3, bg = p.cBgDim },
        TelescopePromptBorder = { fg = p.cFill3, bg = p.cBgDim },

        TelescopeMultiSelection = { fg = p.cFgLight, bg = p.cFill3 },
        TelescopeMultiIcon = { fg = p.cFgLight, bg = p.cFill3 },
        TelescopselectionCaret = { fg = p.cCyan, bg = p.cFill2 },
        Telescopselection = { link = "Telescop.cSelectionCaret" },
        TelescopeMatching = { fg = p.cFgLight },

        -- todo-comments.nvim
        TodoBgFIX = { fg = p.cFgLight, bg = p.cRed, bold = true },
        TodoFgFIX = { link = "DiagnosticError" },
        TodoSignFIX = { link = "DiagnosticError" },
        TodoBgNOTE = { fg = p.cFgLight, bg = p.cSelect, bold = true },
        TodoFgNOTE = { link = "DiagnosticHint" },
        TodoSignNOTE = { link = "DiagnosticHint" },
        TodoBgWARN = { fg = p.cFgLight, bg = p.cYellow, bold = true },
        TodoFgWARN = { link = "DiagnosticWarn" },
        TodoSignWARN = { link = "DiagnosticWarn" },
        TodoBgPERF = { fg = p.cFgLight, bg = p.cGreen, bold = true },
        TodoFgPERF = { fg = p.cGreen },
        TodoSignPERF = { fg = p.cGreen },
        TodoBgTODO = { fg = p.cFgLight, bg = p.cCyan, bold = true },
        TodoFgTODO = { link = "DiagnosticInfo" },
        TodoSignTODO = { link = "DiagnosticInfo" },
        TodoBgHACK = { fg = p.cFgLight, bg = p.cYellow, bold = true },
        TodoFgHACK = { link = "DiagnosticWarn" },
        TodoSignHACK = { link = "DiagnosticWarn" },

        -- trouble.nvim
        TroubleNormal = { link = "SidePanelNormal" },
        TroubleFoldIcon = { link = "FoldColumn" },
        TroubleIndent = { link = "FoldColumn" },

        -- vim-illuminate
        IlluminatedWordText = { link = "LspReferenceText" },
        IlluminatedWordRead = { link = "LspReferenceRead" },
        IlluminatedWordWrite = { link = "LspReferenceWrite" },

        -- which-key.nvim
        WhichKey = { fg = p.cFg, bold = true },
        WhichKeyBorder = { link = "FloatBorder" },
        WhichKeyGroup = { fg = p.cSelect, bold = true },
        WhichKeyDesc = { fg = p.cBlue },
        WhichKeySeparator = { fg = p.cFill4 },
        WhichKeyValue = { link = "Comment" },
        WhichKeyFloat = { link = "NormalFloat" },
    }

    return g
end

---Set the highlights based on the given color palette
---@param palette table The values must be a hexadecimal string
function M.load(palette)
    local g = M.get_highlight_groups(palette)

    for _, highlightGroups in pairs(g) do
        for group, highlightName in pairs(highlightGroups) do
            vim.api.nvim_set_hl(0, group, highlightName)
        end
    end
end

return M
