local M = {}

---Set the highlights based on the given color palette
---@param palette table The values must be a hexadecimal string
function M.load(palette)
    local p = palette
    local g = {}

    g.editor = {
        Normal = { fg = p.cFg, bg = p.cBg },
        NormalNC = { fg = p.cFg, bg = p.cBgDim },
        NormalFloat = { fg = p.cFg, bg = p.cBgDark },
        FloatBorder = { fg = p.cFill1, bg = p.cBgDark },
        ColorColumn = { bg = p.cBgDim },
        Cursor = { reverse = true },
        lCursor = { link = "Cursor" },
        CursorIM = { link = "Cursor" },
        TermCursor = { link = "Cursor" },
        TermCursorNC = { link = "Cursor" },
        MatchParen = { fg = p.cViolet, bg = p.cFill5, bold = true },
        NonText = { fg = p.cFill3, bg = p.none },
        Conceal = { fg = p.none, bg = p.none },
        Whitespace = { fg = p.cFill3, bg = p.none },
        Pmenu = { fg = p.cFg, bg = p.cBgDark },
        PmenuSel = { fg = p.cCyan, bg = p.cFill4 },
        PmenuSbar = { fg = p.cFg, bg = p.cFill1 },
        PmenuThumb = { fg = p.cCyan, bg = p.cFill3 },
        SpecialKey = { fg = p.cFill4, bg = p.none },
        SpellBad = { bg = p.none, sp = p.cRed, underdotted = true },
        SpellCap = { bg = p.none, sp = p.cYellow, underdotted = true },
        SpellLocal = { bg = p.none, sp = p.cFg, underdotted = true },
        SpellRare = { bg = p.none, sp = p.cFgLight, underdotted = true },
        Visual = { bg = p.cFill4 },
        VisualNOS = { fg = p.none, bg = p.cFill4 },
        Folded = { fg = p.cFill4 },
        FoldColumn = { fg = p.cFill4 },
        SignColumn = { fg = p.cFill2 },
        LineNrAbove = { link = "LineNr" },
        LineNr = { fg = p.cFill5, bg = p.none },
        LineNrBelow = { link = "LineNr" },
        CursorLineNr = { fg = p.cFg, bg = p.cFill1 },
        CursorLine = { fg = p.none, bg = p.cFill1 },
        CursorColumn = { link = "CursorLine" },
        CursorLineSign = { link = "SignColumn" },
        CursorLineFold = { link = "FoldColumn" },
        Directory = { fg = p.cCyan, bg = p.none },
        EndOfBuffer = { fg = p.cFill2, bg = p.none },
        ErrorMsg = { fg = p.cFg, bg = p.cRed },
        ModeMsg = { fg = p.cFg, bg = p.none, bold = true },
        MoreMsg = { fg = p.cYellow, bg = p.none },
        MsgArea = { link = "Normal" },
        WarningMsg = { fg = p.cYellow, bg = p.cBg, reverse = true },
        MsgSeparator = { fg = p.cFg, bg = p.cFill1 },
        Question = { fg = p.cFg, bg = p.none },
        StatusLine = { fg = p.cFg, bg = p.cFill2 },
        StatusLineNC = { fg = p.cFgDim, bg = p.cFill2 },
        StatusLineTerm = { link = "StatusLine" },
        StatusLineTermNC = { link = "StatusLineNC" },
        WinBar = { fg = p.cFg, bg = p.cFill1 },
        WinBarNC = { fg = p.cFg, bg = p.cFill1 },
        WildMenu = { fg = p.cFill2, bg = p.cCyan },
        Search = { fg = p.cCyan, bg = p.cBg, reverse = true },
        IncSearch = { fg = p.cFgLight, bg = p.cSelect, underline = true },
        CurSearch = { fg = p.cFgLight, bg = p.cSelect, underline = true },
        Substitute = { fg = p.cFgLight, bg = p.cBg, reverse = true },
        TabLine = { fg = p.cFg, bg = p.cFill2 },
        TabLineSel = { fg = p.cFg, bg = p.cFill5 },
        TabLineFill = { fg = p.cFgDim, bg = p.cFill3 },
        Title = { fg = p.cSelect, bold = true },
        WinSeparator = { fg = p.cFill2, bg = p.cBgDim },
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
        Comment = { fg = p.cFill5 },

        Constant = { fg = p.cFgLight, bold = true },
        String = { fg = p.cGreen, italic = true },
        Character = { fg = p.cGreen },
        Number = { fg = p.cMagenta },
        Boolean = { fg = p.cMagenta, italic = true },
        Float = { fg = p.cMagenta },

        Identifier = { fg = p.cSelect },
        Function = { fg = p.cCyan, italic = true },

        Statement = { fg = p.cBlue },
        Conditional = { fg = p.cBlue, italic = true },
        Repeat = { fg = p.cBlue },
        Label = { fg = p.cBlue },
        Operator = { fg = p.cBlue },
        Keyword = { fg = p.cBlue, italic = true },
        Exception = { fg = p.cBlue },

        PreProc = { fg = p.cSelect, bold = true },
        Include = { link = "PreProc" },
        Define = { link = "PreProc" },
        Macro = { link = "PreProc" },
        PreCondit = { link = "PreProc" },

        Type = { fg = p.cViolet },
        StorageClass = { link = "Type" },
        Structure = { link = "Type" },
        Typedef = { link = "Type" },

        Special = { fg = p.cFgLight },
        SpecialChar = { fg = p.cYellow },
        Tag = { fg = p.cSelect },
        Delimiter = { fg = p.cFgLight },
        SpecialComment = { fg = p.cCyan },
        Debug = { fg = p.cRed },

        Underlined = { underline = true },
        Ignore = { fg = p.cFill2 },
        Error = { fg = p.cRed, bg = p.none, bold = true, underline = true },
        Todo = { fg = p.cYellow, bg = p.none },
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

        -- diffview.nvim
        DiffviewVertSplit = { fg = p.cFill2, bg = p.cYellow },
        DiffviewWinSeparator = { link = "DiffviewVertSplit" },

        -- gitsigns.nvim
        GitSignsCurrentLineBlame = { fg = p.cMagenta, bold = true, italic = true },
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

        -- incline.nvim
        InclineNormal = { fg = p.nord5, bg = p.cFill4 },
        InclineNormalNC = { link = "InclineNormal" },

        -- indent-blankline.nvim
        IndentBlanklineContextChar = { fg = p.cViolet, bg = p.none },
        IndentBlanklineContextStart = { fg = p.none, bg = p.none, underline = true, sp = p.cViolet },
        IndentBlanklineSpaceCharBlankline = { fg = p.cFill2, bg = p.none },
        IndentBlanklineSpaceChar = { fg = p.cFill2, bg = p.none },
        IndentBlanklineChar = { fg = p.cFill2, bg = p.none },

        -- hop.nvim
        HopNextKey = { fg = p.cCyan, bg = p.none, bold = true },
        HopNextKey1 = { fg = p.cCyan, bg = p.none },
        HopNextKey2 = { fg = p.cFg, bg = p.none },
        HopUnmatched = { fg = p.cFill4, bg = p.none },

        -- mini.nvim
        MiniCursorword = { link = "Visual" },
        MiniCursorwordCurrent = { bold = true },

        -- nvim-cmp
        CmpGhostText = { fg = p.cFill5, bold = true },

        CmpItemMenu = { fg = p.cFill5 },

        CmpItemAbbr = { fg = p.cFg },
        CmpItemAbbrDeprecated = { fg = p.cOrange, strikethrough = true },
        CmpItemAbbrMatch = { fg = p.cSelect, bold = true },
        CmpItemAbbrMatchFuzzy = { link = "CmpItemAbbrMatch" },

        CmpItemKind = { fg = g.editor.Normal.fg },
        CmpItemKindTypeParameter = { link = "@parameter" },
        CmpItemKindConstructor = { link = "@constructor" },
        CmpItemKindEnum = g.syntax.Structure,
        CmpItemKindEnumMember = g.syntax.Structure,
        CmpItemKindReference = g.editor.Visual,
        CmpItemKindInterface = g.syntax.StorageClass,
        CmpItemKindClass = g.syntax.StorageClass,
        CmpItemKindVariable = { link = "@variable" },
        CmpItemKindProperty = { link = "@property" },
        CmpItemKindOperator = { link = "@operator" },
        CmpItemKindFunction = { link = "@function" },
        CmpItemKindConstant = { link = "@constant" },
        CmpItemKindSnippet = g.syntax.String,
        CmpItemKindKeyword = { link = "@keyword" },
        CmpItemKindStruct = g.syntax.Structure,
        CmpItemKindModule = { link = "@namespace" },
        CmpItemKindMethod = { link = "@method" },
        CmpItemKindFolder = g.editor.Directory,
        CmpItemKindFile = g.editor.Directory,
        CmpItemKindValue = { link = "@keyword" },
        CmpItemKindField = { link = "@field" },
        CmpItemKindUnit = { link = "@number" },
        CmpItemKindText = { link = "@text" },

        -- nvim-hlslens
        HlSearchNear = { link = "IncSearch" },
        HlSearchLensNear = { fg = p.cFg, bg = p.none, reverse = true },
        HlSearchLens = { fg = p.cFill5, bg = p.none, reverse = true },
        HlSearchFloat = { link = "IncSearch" },

        -- nvim-notify
        NotifyERRORTitle = { fg = p.cRed, bg = p.cBgDark },
        NotifyWARNTitle = { fg = p.cYellow, bg = p.cBgDark },
        NotifyINFOTitle = { fg = p.cCyan, bg = p.cBgDark },
        NotifyDEBUGTitle = { fg = p.cOrange, bg = p.cBgDark },
        NotifyTRACETitle = { fg = p.cSelect, bg = p.cBgDark },
        NotifyERRORIcon = { fg = p.cRed, bg = p.cBgDark },
        NotifyWARNIcon = { fg = p.cYellow, bg = p.cBgDark },
        NotifyINFOIcon = { fg = p.cCyan, bg = p.cBgDark },
        NotifyDEBUGIcon = { fg = p.cOrange, bg = p.cBgDark },
        NotifyTRACEIcon = { fg = p.cSelect, bg = p.cBgDark },
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
        ScrollBarHandle = { fg = p.none, bg = p.cFill3 },
        ScrollBarError = { link = "DiagnosticError" },
        ScrollBarWarn = { link = "DiagnosticWarn" },
        ScrollBarInfo = { link = "DiagnosticInfo" },
        ScrollBarHint = { link = "DiagnosticHint" },
        ScrollBarMisc = { fg = p.cFg, bg = p.none },
        ScrollBarSearch = { link = "Search" },

        -- nvim-ts-rainbow
        rainbowcol1 = { link = "Tag" },
        rainbowcol2 = { fg = p.cRed },
        rainbowcol3 = { fg = p.cYellow },
        rainbowcol4 = { fg = p.cGreen },
        rainbowcol5 = { fg = p.cMagenta },
        rainbowcol6 = { fg = p.cViolet },
        rainbowcol7 = { fg = p.cCyan },

        --nvim-windowpicker
        WindowPicker = { fg = p.cBgDark, bg = p.cSelect, bold = true },
        WindowPickerNC = { fg = p.cBgDark, bg = p.cSelect, bold = true },

        -- neo-tree.nvim
        NeoTreeNormal = { link = "Normal" },
        NeoTreeNormalNC = { link = "NormalNC" },
        NeoTreePreview = { fg = p.cFg, bg = p.cFill5 },
        NeoTreeFloatBorder = { fg = p.cFill3, bg = p.cBg },
        NeoTreeFloatTitle = { fg = p.cCyan, bg = p.cFill3, bold = true },

        NeoTreeTabActive = { fg = p.cFg, bg = p.cFill5 },
        NeoTreeTabInactive = { fg = p.cFg, bg = p.cFill3 },
        NeoTreeTabBarBackground = { link = "StatusLine" },
        NeoTreeTabSeparatorActive = { fg = p.cFill4, bg = p.cFill5 },
        NeoTreeTabSeparatorInactive = { fg = p.cFill2, bg = p.cFill3 },

        NeoTreeRootName = { fg = p.cFgLight, bg = p.none, bold = true, italic = true },
        NeoTreeIndentMarker = { link = "FoldColumn" },
        NeoTreeFileNameOpened = { bold = true, nocombine = true },
        NeoTreeBufferNumber = { fg = p.cFgLight, bg = p.none },
        NeoTreeDotfile = { fg = p.cFill5, bg = p.none },
        NeoTreeSymbolicLinkTarget = { fg = p.cViolet, bg = p.none, bold = true },

        NeoTreeMessage = { fg = p.cMagenta, bg = p.none },
        NeoTreeDimText = { fg = p.cFill4, bg = p.none },
        NeoTreeFadeText1 = { link = "NeoTreeDotfile" },
        NeoTreeFadeText2 = { link = "NeoTreeDimText" },

        NeoTreeModified = { link = "GitSignsChange" },
        NeoTreeGitAdded = { link = "GitSignsAdd" },
        NeoTreeGitModified = { link = "GitSignsChange" },
        NeoTreeGitDeleted = { link = "GitSignsDelete" },
        NeoTreeGitRenamed = { link = "NeoTreeGitModified" },
        NeoTreeGitUntracked = { fg = p.cSelect, bg = p.none },
        NeoTreeGitIgnored = { link = "NeoTreeDotfile" },
        NeoTreeGitUnstaged = { link = "NeoTreeGitModified" },
        NeoTreeGitStaged = { link = "NeoTreeGitAdded" },
        NeoTreeGitConflict = { fg = p.cOrange, bg = p.none },

        -- quickscope.lua
        QuickScopePrimary = { fg = p.cYellow, bg = p.cBg, underline = true, nocombine = true },
        QuickScopeSecondary = { fg = p.cMagenta, bg = p.cBg, bold = true, nocombine = true },

        -- satellite.nvim
        ScrollView = { fg = p.none, bg = p.cFill4 },
        SearchSV = { fg = p.cCyan, bg = p.none },

        -- telescope.nvim
        TelescopePromptPrefix = { fg = p.cFg, bg = p.none, bold = true },
        TelescopePromptCounter = { fg = p.cViolet, bg = p.none, bold = true },

        TelescopeNormal = { fg = p.cFg, bg = p.cBgDark },
        TelescopeResultsNormal = { fg = p.cBlue, bg = p.none },
        TelescopePreviewNormal = { fg = p.cFg, bg = p.cBg },
        TelescopePromptNormal = { fg = p.cFgLight, bg = p.cBg },

        TelescopeResultsTitle = { fg = p.cCyan, bg = p.cFill3, bold = true },
        TelescopePreviewTitle = { fg = p.cBlue, bg = p.cFill3, bold = true },
        TelescopePromptTitle = { fg = p.cFg, bg = p.cFill3, bold = true },

        TelescopeResultsBorder = { fg = p.cFill3, bg = p.none },
        TelescopePreviewBorder = { fg = p.cFill3, bg = p.cBg },
        TelescopePromptBorder = { fg = p.cFill3, bg = p.cBg },

        TelescopeMultiSelection = { fg = p.cFgLight, bg = p.cFill3 },
        TelescopeMultiIcon = { fg = p.cFgLight, bg = p.cFill3 },
        TelescopselectionCaret = { fg = p.cCyan, bg = p.cFill2 },
        Telescopselection = { link = "Telescop.cSelectionCaret" },
        TelescopeMatching = { fg = p.cFgLight, bg = p.none },

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
        TodoFgPERF = { fg = p.cGreen, bg = p.none },
        TodoSignPERF = { fg = p.cGreen, bg = p.none },
        TodoBgTODO = { fg = p.cFgLight, bg = p.cCyan, bold = true },
        TodoFgTODO = { link = "DiagnosticInfo" },
        TodoSignTODO = { link = "DiagnosticInfo" },
        TodoBgHACK = { fg = p.cFgLight, bg = p.cYellow, bold = true },
        TodoFgHACK = { link = "DiagnosticWarn" },
        TodoSignHACK = { link = "DiagnosticWarn" },

        -- vim-illuminate
        IlluminatedWordText = { link = "LspReferenceText" },
        IlluminatedWordRead = { link = "LspReferenceRead" },
        IlluminatedWordWrite = { link = "LspReferenceWrite" },

        -- which-key.nvim
        WhichKey = { fg = p.cFg, bg = p.none, bold = true },
        WhichKeyBorder = { link = "FloatBorder" },
        WhichKeyGroup = { fg = p.cSelect, bg = p.none, bold = true },
        WhichKeyDesc = { fg = p.cBlue, bg = p.none },
        WhichKeySeparator = { fg = p.cFill4, bg = p.none },
        WhichKeyValue = { link = "Comment" },
        WhichKeyFloat = { link = "NormalFloat" },

        -- hydra.nvim
        HydraHint = { link = "NormalFloat" },
        HydraAmaranth = { fg = p.cOrange, bg = p.none },
        HydraTeal = { fg = p.cViolet, bg = p.none },
        HydraPink = { fg = p.cMagenta, bg = p.none },
        HydraBlue = { fg = p.cSelect, bg = p.none },
        HydraRed = { fg = p.cRed, bg = p.none },
    }

    g.statusBars = {
        ModeInactive = { fg = p.cFill2, bg = p.cCyan },
        ModeVisual = { fg = p.cFill2, bg = p.cYellow },
        ModeReplace = { fg = p.cFill2, bg = p.cRed },
        ModeNormal = { fg = p.cFill2, bg = p.cCyan },
        ModeInsert = { fg = p.cFill2, bg = p.cFgLight },
        ModeCommand = { fg = p.cFill2, bg = p.cViolet },
        ModeTerminal = { fg = p.cFill2, bg = p.cOrange },
        ModeHydra = { fg = p.cFill2, bg = p.cMagenta },
        StatusLineLight = { fg = p.cFg, bg = p.cFill4 },
        WinBarLight = { fg = p.cFg, bg = p.cFill3 },
        WinBarCurrent = { fg = p.cFgLight, bg = p.cFill5 },
        WinBarSpecial = { fg = p.cFg, bg = p.cFill1, bold = true },
        WinBarCurrentSpecial = { fg = p.cFgLight, bg = p.cFill5, bold = true },
        WinBarModifiedCurrent = { fg = p.cFill1, bg = p.cYellow },
        WinBarModifiedInactive = { fg = p.cYellow, bg = p.cFill1 },
        WinBarWindowNumber = { fg = p.cFgLight },
        TabLine = { fg = p.cFg, bg = p.cFill2 },
        TabLineSel = { fg = p.cFg, bg = p.cFill5 },
        TabLineFill = { fg = p.cFgDim, bg = p.cFill3 },
        TabLineHeader = { fg = p.cFill2, bg = p.cCyan },
        TabLineTabSeparator = { fg = p.cFg, bg = p.cFill4 },
        TabLineTabSeparatorSel = { fg = p.cFill2, bg = p.cCyan },
        TabLineTabIndicator = { fg = p.cFg, bg = p.cFill4 },
        TabLineTabIndicatorSel = { fg = p.cFill2, bg = p.cCyan },
        TabLineIndicatorModified = { fg = p.cFill2, bg = p.cFill3 },
        TabLineIndicatorModifiedSel = { fg = p.cFill2, bg = p.cFill5 },
        TabLineIndicatorIsModified = { fg = p.cYellow, bg = p.cFill3 },
        TabLineIndicatorIsModifiedSel = { fg = p.cYellow, bg = p.cFill5 },
    }

   g.treesitter = {
        ["@comment"]               = g.syntax.Comment,
        ["@debug"]                 = g.syntax.Debug,
        -- ["@error"]                 = g.syntax.Error,
        -- ["@none"]                  = { },
        ["@preproc"]               = g.syntax.PreProc,
        ["@punctuation.delimiter"] = g.syntax.Delimiter,
        ["@punctuation.bracket"]   = { fg = p.cCyan },
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

        ["@function"]              = g.syntax.Function,
        ["@function.builtin"]      = g.syntax.Function,
        ["@function.call"]         = g.syntax.Function,
        ["@function.macro"]        = g.syntax.Function,
        ["@parameter"]             = g.syntax.Operator,
        ["@method"]                = g.syntax.Function,
        ["@method.call"]           = g.syntax.Function,
        ["@field"]                 = g.syntax.Special,
        ["@property"]              = g.syntax.Identifier,
        ["@constructor"]           = g.syntax.Keyword,

        ["@conditional"]           = g.syntax.Conditional,
        ["@repeat"]                = g.syntax.Repeat,
        ["@label"]                 = g.syntax.Label,
        ["@keyword"]               = g.syntax.Keyword,
        ["@keyword.function"]      = g.syntax.Function,
        ["@keyword.operator"]      = g.syntax.Operator,
        ["@keyword.return"]        = g.syntax.Keyword,
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
        ["@text.literal"]          = g.syntax.Delimiter,
        ["@text.uri"]              = { fg = p.cBlue, italic = true },
        ["@text.math"]             = g.syntax.Number,
        -- ["@text.environment"]      = {},
        -- ["@text.environment.name"] = {},
        ["@text.reference"]        = g.syntax.SpecialComment,
        ["@text.note"]             = g.diagnostic.DiagnosticHint,
        ["@text.warning"]          = g.diagnostic.DiagnosticWarn,
        ["@text.danger"]           = g.diagnostic.DiagnosticError,
        ["@todo"]                  = g.diagnostic.DiagnosticInfo,
        ["@tag"]                   = g.syntax.Tag,
        ["@tag.attribute"]         = g.syntax.Label,
        -- ["@tag.delimiter"]         = g.diagnostic.DiagnosticHint,
    }

    for _, highlightGroups in pairs(g) do
        for group, highlightName in pairs(highlightGroups) do
            vim.api.nvim_set_hl(0, group, highlightName)
        end
    end
end

return M
