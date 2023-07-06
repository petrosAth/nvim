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
        PmenuSel = { fg = p.cCyan, bg = p.cFill2 },
        PmenuSbar = { fg = p.cFg, bg = p.cFill1 },
        PmenuThumb = { fg = p.cCyan, bg = p.cFill4 },
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
        WinBarNC = { fg = p.cFgDim },
        WildMenu = { fg = p.cFill2, bg = p.cCyan },
        Search = { fg = p.cCyan, bg = p.cBg, reverse = true },
        IncSearch = { fg = p.cFgLight, bg = p.cSelect, underline = true },
        CurSearch = { fg = p.cFgLight, bg = p.cSelect },
        Substitute = { fg = p.cFgLight, bg = p.cBg, reverse = true },
        TabLine = { fg = p.cFg, bg = p.cFill2 },
        TabLineSel = { fg = p.cFg, bg = p.cFill5 },
        TabLineFill = { fg = p.cFgDim, bg = p.cFill3 },
        Title = { fg = p.cCyan, bold = true },
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
        Comment = { fg = p.cFill5, italic = true }, -- any comment

        Constant = { fg = p.cFgLight, bold = true }, -- (preferred) any constant
        String = { fg = p.cGreen, italic = true }, -- a string constant: "this is a string"
        Character = { fg = p.cGreen, italic = true }, -- a character constant: 'c', '\n'
        Number = { fg = p.cMagenta }, -- a number constant: 234, 0xff
        Boolean = { fg = p.cMagenta }, -- a floating point constant: 2.3e10
        Float = { fg = p.cMagenta }, -- a boolean constant: TRUE, false

        Identifier = { fg = p.cFg }, -- (preferred) any variable name
        Function = { fg = p.cCyan, italic = true }, -- function name (also: methods for classes)

        Statement = { fg = p.cSelect }, -- (preferred) any statement
        Conditional = { link = "Statement" }, -- if, then, else, endif, switch, etc.
        Repeat = { link = "Statement" }, -- for, do, while, etc.
        Label = { link = "Statement" }, -- case, default, etc.

        Operator = { fg = p.cBlue }, -- "sizeof", "+", "*", etc.
        Keyword = { fg = p.cBlue }, -- any other keyword
        Exception = { link = "Operator" }, -- try, catch, throw

        PreProc = { fg = p.cBlue }, -- (preferred) generic Preprocessor
        Include = { link = "PreProc" }, -- preprocessor #include
        Define = { link = "PreProc" }, -- preprocessor #define
        Macro = { link = "PreProc" }, -- same as Define
        PreCondit = { link = "PreProc" }, -- preprocessor #if, #else, #endif, etc.

        Type = { fg = p.cViolet }, -- (preferred) int, long, char, etc.
        StorageClass = { link = "Type" }, -- static, register, volatile, etc.
        Structure = { link = "Type" }, -- struct, union, enum, etc.
        Typedef = { link = "Type" }, -- A typedef

        Special = { fg = p.cYellow }, -- (preferred) any special symbol
        SpecialChar = { link = "Special" }, -- special character in a constant
        Tag = { link = "Special" }, -- you can use CTRL-] on this
        Delimiter = { fg = p.cFgLight }, -- character that needs attention
        SpecialComment = { link = "Special" }, -- special things inside a comment
        Debug = { link = "Special" }, -- debugging statements

        Underlined = { underline = true }, -- (preferred) text that stands out, HTML links
        Ignore = {}, -- (preferred) left blank, hidden  |hl-Ignore|
        Error = { fg = p.cRed, bold = true, underline = true }, -- (preferred) any erroneous construct
        Todo = { fg = p.cYellow, bold = true }, -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX
    }

    g.lsp = {
        -- DocumentHighlight
        LspReferenceText = { link = "Visual" },
        LspReferenceRead = { link = "Visual" },
        LspReferenceWrite = { link = "Visual" },
        -- Neovim LspSignatureHelp
        LspSignatureActiveParameter = { fg = g.syntax.Operator.fg, reverse = true },
        -- lspinfo window
        LspInfoBorder = { link = "FloatBorder" },
    }

    g.diagnostic = {
        DiagnosticUnnecessary = { link = "Comment" },
        DiagnosticDeprecated = { fg = g.syntax.Comment.fg, strikethrough = true },
        DiagnosticError = { fg = p.cRed },
        DiagnosticWarn = { fg = p.cYellow },
        DiagnosticInfo = { fg = p.cCyan },
        DiagnosticHint = { fg = p.cSelect },
        DiagnosticOk = { fg = p.cGreen },
        DiagnosticSignError = { link = "DiagnosticError" },
        DiagnosticSignWarn = { link = "DiagnosticWarn" },
        DiagnosticSignInfo = { link = "DiagnosticInfo" },
        DiagnosticSignHint = { link = "DiagnosticHint" },
        DiagnosticSignOk = { link = "DiagnosticOk" },
        DiagnosticFloatingWarn = { link = "DiagnosticError" },
        DiagnosticFloatingError = { link = "DiagnosticWarn" },
        DiagnosticFloatingInfo = { link = "DiagnosticInfo" },
        DiagnosticFloatingHint = { link = "DiagnosticHint" },
        DiagnosticFloatingOk = { link = "DiagnosticOk" },
        DiagnosticUnderlineError = { undercurl = true, sp = p.cRed },
        DiagnosticUnderlineWarn = { undercurl = true, sp = p.cYellow },
        DiagnosticUnderlineInfo = { undercurl = true, sp = p.cCyan },
        DiagnosticUnderlineHint = { undercurl = true, sp = p.cSelect },
        DiagnosticUnderlineOk = { undercurl = true, sp = p.cGreen },
        DiagnosticVirtualTextError = { fg = p.cRed, bold = true, italic = true },
        DiagnosticVirtualTextWarn = { fg = p.cYellow, bold = true, italic = true },
        DiagnosticVirtualTextInfo = { fg = p.cCyan, bold = true, italic = true },
        DiagnosticVirtualTextHint = { fg = p.cSelect, bold = true, italic = true },
        DiagnosticVirtualTextOk = { fg = p.cGreen, bold = true, italic = true },
    }

    g.flash = {
        FlashPromptIcon    = { fg = g.editor.MoreMsg.fg, bg = g.editor.StatusLine.bg },
        FlashBackdrop      = { link = "Comment" },
        FlashCurrent       = { link = "IncSearch" },
        FlashPrompt        = { link = "MsgArea" },
        FlashMatch         = { link = "Search" },
        FlashLabel         = { link = "Substitute" },
    }

    g.treesitter = {
        ["@comment"]               = g.syntax.Comment,
        ["@documentation"]         = { fg = p.cFg, nocombine = true },
        ["@debug"]                 = g.syntax.Debug,
        -- ["@error"]                 = g.syntax.Error,
        ["@preproc"]               = g.syntax.PreProc,
        ["@punctuation.delimiter"] = g.syntax.Delimiter,
        ["@punctuation.bracket"]   = { fg = p.cCyan },
        ["@punctuation.special"]   = { fg = p.cBlue },

        ["@constant"]              = g.syntax.Constant,
        ["@constant.git_rebase"]   = g.syntax.Constant,
        ["@constant.builtin"]      = { fg = g.syntax.Constant.fg, bold = true },
        ["@constant.macro"]        = { fg = g.syntax.Constant.fg, bold = true },
        ["@string"]                = g.syntax.String,
        ["@string.regex"]          = g.syntax.SpecialChar,
        ["@string.escape"]         = g.syntax.SpecialChar,
        ["@string.special"]        = g.syntax.SpecialChar,
        ["@character"]             = g.syntax.Character,
        ["@character.special"]     = g.syntax.SpecialChar,
        ["@number"]                = g.syntax.Number,
        ["@boolean"]               = g.syntax.Boolean,
        ["@float"]                 = g.syntax.Float,

        ["@function"]              = { fg = g.syntax.Function.fg, bold = true },
        ["@function.builtin"]      = { link = "@function" },
        ["@function.call"]         = { link = "@function" },
        ["@function.macro"]        = { link = "@function" },
        ["@parameter"]             = { fg = g.syntax.Function.fg },
        ["@structure"]             = g.syntax.Structure,
        ["@method"]                = { link = "@function" },
        ["@method.call"]           = { link = "@function" },
        ["@field"]                 = g.syntax.Identifier,
        ["@property"]              = { link = "@field" },
        ["@constructor"]           = g.syntax.Keyword,

        ["@conditional"]           = g.syntax.Conditional,
        ["@repeat"]                = g.syntax.Repeat,
        ["@label"]                 = g.syntax.Label,
        ["@label.json"]            = { link = "Normal" },
        ["@keyword"]               = g.syntax.Keyword,
        ["@keyword.function"]      = { fg = g.syntax.Keyword.fg, italic = true },
        ["@keyword.operator"]      = { fg = g.syntax.Keyword.fg, italic = true },
        ["@keyword.return"]        = g.syntax.Special,
        ["@operator"]              = g.syntax.Operator,
        ["@exception"]             = g.syntax.Exception,
        ["@include"]               = g.syntax.Include,
        ["@storageclass"]          = g.syntax.StorageClass,
        ["@type"]                  = g.syntax.Type,
        ["@type.builtin"]          = { link = "@type" },
        ["@type.definition"]       = { link = "@type" },
        ["@type.qualifier"]        = { link = "@type" },
        ["@namespace"]             = g.syntax.Identifier,
        ["@symbol"]                = g.syntax.Identifier,
        ["@attribute"]             = g.syntax.Constant,

        ["@global"]                = g.syntax.Constant,
        ["@variable"]              = { fg = g.syntax.Constant.fg },
        ["@variable.builtin"]      = { fg = p.cBlue },
        ["@variable.global"]       = { fg = g.syntax.Identifier.fg, bold = true },
        ["@definition"]            = g.syntax.Keyword,

        ["@text"]                  = { fg = p.cFg },
        ["@text.strong"]           = { bold = true },
        ["@text.emphasis"]         = { italic = true },
        ["@text.underline"]        = { underline = true },
        ["@text.strike"]           = { strikethrough = true },
        ["@text.title"]            = g.editor.Title,
        ["@text.title.html"]       = { fg = p.cFg },
        ["@text.literal"]          = { fg = p.cViolet },
        ["@text.uri"]              = { fg = p.cGreen, underline = true },
        ["@text.math"]             = { fg = p.cViolet },
        ["@text.todo.checked"]     = { fg = p.cGreen },
        ["@text.todo.unchecked"]   = g.syntax.Todo,
        ["@text.environment"]      = { fg = p.cViolet },
        ["@text.environment.name"] = { fg = p.cBlue },
        ["@text.reference"]        = { fg = p.cViolet },
        ["@text.note"]             = g.diagnostic.DiagnosticHint,
        ["@text.warning"]          = g.diagnostic.DiagnosticWarn,
        ["@text.danger"]           = g.diagnostic.DiagnosticError,
        ["@text.diff.add"]         = { link = "DiffAdd" },
        ["@text.diff.delete"]      = { link = "DiffDelete" },
        ["@todo"]                  = g.diagnostic.DiagnosticInfo,
        ["@tag"]                   = { fg = p.cBlue },
        ["@tag.attribute"]         = { fg = p.cViolet },
        ["@tag.delimiter"]         = { fg = p.cBlue },
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
        WinBarLight = { fg = g.editor.WinBar.fg, bg = p.cFill5 },
        WinBarLightNC = { link = "WinBarLight" },
        WinBarFile = { fg = p.cFgLight, bg = p.cFill5 },
        WinBarFileNC = { fg = g.editor.WinBarNC.fg },
        WinBarSpecial = { fg = p.cFgLight },
        WinBarSpecialNC = { fg = g.editor.WinBarNC.fg },
        WinBarIsModified = { fg = p.cYellow },
        WinBarIsReadOnly = { fg = p.cFgLight },
        WinBarWindowNumber = { fg = p.cFgLight },
        WinBarCloseButton = { fg = g.editor.WinBar.fg },
        TabLineHeader = { fg = p.cFill2, bg = p.cCyan },
        TabLineBuffer = { fg = p.cFg, bg = p.cFill5 },
        TabLineBufferNC = { fg = p.cFgDim, bg = p.cFill2 },
        TabLineTabSeparator = { fg = p.cFg, bg = p.cFill4 },
        TabLineTabSeparatorSel = { fg = p.cFill2, bg = p.cCyan },
        TabLineTabIndicator = { fg = p.cFg, bg = p.cFill4 },
        TabLineTabIndicatorSel = { fg = p.cFill2, bg = p.cCyan },
        TabLineIndicatorModified = { fg = p.cBgDim, bg = p.cFill2 },
        TabLineIndicatorModifiedSel = { fg = p.cBgDim, bg = p.cFill5 },
        TabLineIndicatorIsModified = { fg = p.cYellow, bg = p.cFill2 },
        TabLineIndicatorIsModifiedSel = { fg = p.cYellow, bg = p.cFill5 },
    }

    g.plugins = {
        -- aerial.nvim
        AerialLine = { link = "CursorLine" },
        AerialLineNC = { bg = p.cFill4 },

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
        DiffviewNormal = { link = "Normal" },
        DiffviewWinSeparator = { link = "WinSeparator" },
        DiffviewVertSplit = { link = "WinSeparator" },
        DiffviewEndOfBuffer = { link = "EndOfBuffer" },
        DiffviewNonText = { link = "NonText" },

        -- fidget.nvim
        FidgetTitle = { fg = p.cFgDim },
        FidgetTask = { fg = g.syntax.Comment.fg, bg = g.editor.NormalFloat.bg },

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
        HopNextKey = { fg = p.cCyan, bold = true, nocombine = true },
        HopNextKey1 = { fg = p.cCyan, nocombine = true },
        HopNextKey2 = { fg = p.cFg, nocombine = true },
        HopUnmatched = { fg = p.cFill4, nocombine = true },

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
        IndentBlanklineIndent1 = { bg = p.cBgDim, nocombine = true },
        IndentBlanklineIndent2 = { bg = p.cBg, nocombine = true },

        -- lazy.nvim
        LazyButton = { link = "Tabline" },
        LazyH1 = { link = "Search" },

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
        CmpItemAbbrDeprecated = { link = "DiagnosticDeprecated" },
        CmpItemAbbrMatch = { fg = p.cSelect, bold = true },
        CmpItemAbbrMatchFuzzy = { link = "CmpItemAbbrMatch" },

        CmpItemKind = { fg = g.editor.Normal.fg },
        CmpItemKindTypeParameter = { link = "@type" },
        CmpItemKindConstructor = { link = "@constructor" },
        CmpItemKindEnum = { link = "@structure" },
        CmpItemKindEnumMember = { link = "@structure" },
        CmpItemKindReference = g.editor.Visual,
        CmpItemKindInterface = { link = "@type" },
        CmpItemKindClass = { link = "@function" },
        CmpItemKindVariable = { link = "@variable" },
        CmpItemKindProperty = { link = "@property" },
        CmpItemKindOperator = { link = "@operator" },
        CmpItemKindFunction = { link = "@function" },
        CmpItemKindConstant = { link = "@constant" },
        CmpItemKindSnippet = { link = "@string" },
        CmpItemKindKeyword = { link = "@keyword" },
        CmpItemKindStruct = { link = "@structure" },
        CmpItemKindModule = { link = "@include" },
        CmpItemKindMethod = { link = "@method" },
        CmpItemKindFolder = g.editor.Directory,
        CmpItemKindFile = g.editor.Directory,
        CmpItemKindValue = { link = "@keyword" },
        CmpItemKindField = { link = "@field" },
        CmpItemKindUnit = { link = "@number" },
        CmpItemKindText = { link = "@text" },

        -- glance.nvim
        GlancePreviewNormal = { fg = p.cFg, bg = p.cBgDim },
        GlancePreviewMatch = { bg = p.cFill2 },
        GlancePreviewCursorLine = { link = "CursorLine" },
        GlancePreviewSignColumn = { link = "SignColumn" },
        GlancePreviewEndOfBuffer = { fg = g.editor.EndOfBuffer.fg, bg = p.cBgDim },
        GlancePreviewLineNr = { link = "LineNr" },
        GlancePreviewBorderBottom = { fg = g.editor.FloatBorder.fg, bg = p.cBgDim },
        GlanceWinBarFilename = { fg = p.cFg, bg = p.cFill2, bold = true },
        GlanceWinBarFilepath = { fg = p.cBlue, bg = p.cFill2 },
        GlanceWinBarTitle = { fg = p.cCyan, bg = p.cFill3, bold = true },
        GlanceListNormal = { fg = p.cFg, bg = p.cBgDark },
        GlanceListFilename = { link = "Define" },
        GlanceListFilepath = { link = "Comment" },
        GlanceListCount = { link = "Number" },
        GlanceListMatch = { fg = p.cCyan, bg = p.cFill1 },
        GlanceListCursorLine = { link = "CursorLine" },
        GlanceListEndOfBuffer = { fg = p.cBlue, bg = p.cBgDark },
        GlanceListBorderBottom = { fg = g.editor.FloatBorder.fg, bg = p.cBgDark },
        GlanceFoldIcon = { link = "FoldColumn" },
        GlanceIndent = { link = "FoldColumn" },
        GlanceBorderTop = { link = "FloatBorder" },

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
        NavicIconsClass = { fg = g.treesitter["@function"].fg, bg = g.editor.WinBar.bg },
        NavicIconsMethod = { fg = g.treesitter["@method"].fg, bg = g.editor.WinBar.bg },
        NavicIconsProperty = { fg = g.treesitter["@property"].fg, bg = g.editor.WinBar.bg },
        NavicIconsField = { fg = g.treesitter["@field"].fg, bg = g.editor.WinBar.bg },
        NavicIconsConstructor = { fg = g.treesitter["@constructor"].fg, bg = g.editor.WinBar.bg },
        NavicIconsEnum = { fg = g.treesitter["@structure"].fg, bg = g.editor.WinBar.bg },
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
        NavicIconsEnumMember = { fg = g.treesitter["@structure"].fg, bg = g.editor.WinBar.bg },
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
        rainbowcol1 = { fg = p.cMagenta },
        rainbowcol2 = { fg = p.cYellow },
        rainbowcol3 = { fg = p.cRed },
        rainbowcol4 = { fg = p.cViolet },
        rainbowcol5 = { fg = p.cFgLight },
        rainbowcol6 = { fg = p.cMagenta },
        rainbowcol7 = { fg = p.cYellow },

        -- nvim-windowpicker
        WindowPicker = { fg = p.cBgDark, bg = p.cCyan, bold = true },
        WindowPickerNC = { link = "WindowPicker" },

        -- neo-tree.nvim
        NeoTreeNormal = { link = "Normal" },
        NeoTreeNormalNC = { link = "NormalNC" },
        NeoTreePreview = { fg = p.cFg, bg = p.cFill5 },
        NeoTreeFloatNormal = { fg = g.editor.Normal.fg, bg = p.cBgDim },
        NeoTreeFloatBorder = { fg = g.editor.FloatBorder.fg, bg = p.cBgDim },
        NeoTreeFloatTitle = { fg = p.cCyan, bg = p.cFill3, bold = true },
        NeoTreeWinSeparator = { link = "WinSeparator" },
        NeoTreeCursorLine = { link = "CursorLine" },

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
        QuickScopeSecondary = { fg = p.cMagenta, bg = p.cBg, underline = true, nocombine = true },

        -- satellite.nvim
        ScrollView = { bg = p.cFill4 },
        SatelliteDiagnosticError = { link = "DiagnosticSignError" },
        SatelliteDiagnosticWarn = { link = "DiagnosticWarn" },
        SatelliteDiagnosticInfo = { link = "DiagnosticInfo" },
        SatelliteDiagnosticHint = { link = "DiagnosticHint" },
        SatelliteGitSignsDelete = { link = "GitSignsDelete" },
        SatelliteGitSignsChange = { link = "GitSignsChange" },
        SatelliteGitSignsAdd = { link = "GitSignsAdd" },
        SatelliteQuickfix = { link = "WarningMsg" },
        SatelliteSearch = { fg = p.cCyan },
        SatelliteCursor = { fg = p.cFg },
        SatelliteMark = { fg = p.cFgDim },

        -- telescope.nvim
        TelescopePromptPrefix = { fg = p.cFg, bold = true },
        TelescopePromptCounter = { link = "Number" },

        TelescopeNormal = { fg = p.cFg, bg = p.cBgDark },
        TelescopeResultsNormal = { fg = p.cBlue, bg = p.cBgDark },
        TelescopePreviewNormal = { fg = p.cFg, bg = p.cBgDim },
        TelescopePromptNormal = { fg = p.cFgLight, bg = p.cBgDim },

        TelescopeResultsTitle = { fg = p.cCyan, bg = p.cFill3, bold = true },
        TelescopePreviewTitle = { fg = p.cBlue, bg = p.cFill3, bold = true },
        TelescopePromptTitle = { fg = p.cFg, bg = p.cFill3, bold = true },

        TelescopeResultsBorder = { fg = g.editor.FloatBorder.fg, bg = p.cBgDark },
        TelescopePreviewBorder = { fg = g.editor.FloatBorder.fg, bg = p.cBgDim },
        TelescopePromptBorder = { fg = g.editor.FloatBorder.fg, bg = p.cBgDim },

        TelescopeMultiSelection = { fg = p.cFgLight, bg = p.cFill3 },
        TelescopeMultiIcon = { fg = p.cFgLight, bg = p.cFill3 },
        TelescopeSelectionCaret = { link = "TelescopeSelectionCaret" },
        TelescopeSelection = { link = "PmenuSel" },
        TelescopeMatching = { fg = p.cFgLight },

        -- todo-comments.nvim
        TodoBgFIX = { fg = p.cBgDark, bg = g.diagnostic.DiagnosticError.fg, bold = true },
        TodoFgFIX = { link = "DiagnosticError" },
        TodoSignFIX = { link = "DiagnosticError" },
        TodoBgNOTE = { fg = p.cBgDark, bg = g.diagnostic.DiagnosticHint.fg, bold = true },
        TodoFgNOTE = { link = "DiagnosticHint" },
        TodoSignNOTE = { link = "DiagnosticHint" },
        TodoBgWARN = { fg = p.cBgDark, bg = g.diagnostic.DiagnosticWarn.fg, bold = true },
        TodoFgWARN = { link = "DiagnosticWarn" },
        TodoSignWARN = { link = "DiagnosticWarn" },
        TodoBgPERF = { fg = p.cBgDark, bg = p.cGreen, bold = true },
        TodoFgPERF = { fg = p.cGreen },
        TodoSignPERF = { fg = p.cGreen },
        TodoBgTODO = { fg = p.cBgDark, bg = g.diagnostic.DiagnosticInfo.fg, bold = true },
        TodoFgTODO = { link = "DiagnosticInfo" },
        TodoSignTODO = { link = "DiagnosticInfo" },
        TodoBgHACK = { fg = p.cBgDark, bg = g.diagnostic.DiagnosticWarn.fg, bold = true },
        TodoFgHACK = { link = "DiagnosticWarn" },
        TodoSignHACK = { link = "DiagnosticWarn" },

        -- trouble.nvim
        TroubleNormal = { link = "Normal" },
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
