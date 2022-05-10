require("themer").setup({
    colorscheme  = "nord", -- default colorscheme
    transparent  = false,
    term_colors  = true,
    dim_inactive = false,
    disable_telescope_themes = {},
    remaps = {
        palette = {
            -- per colorscheme palette remaps, for example:
            -- rose_pine = {
            --     fg = "#000000"
            -- }
        },
        highlights = {
            nord = {
                base = {
                    -- Editor
                    ColorColumn      = { fg = "NONE",    bg = "#434C5E" },
                    Cursor           = { fg = "#2E3440", bg = "#D8DEE9" },
                    CursorLine       = { fg = "NONE",    bg = "#3B4252" },
                    CursorColumn     = { fg = "NONE",    bg = "#3B4252" },
                    Error            = { fg = "#D8DEE9", bg = "#BF616A" },
                    iCursor          = { fg = "#2E3440", bg = "#D8DEE9" },
                    LineNrAbove      = { fg = "#4C566A", bg = "NONE"    },
                    LineNr           = { fg = "#D8DEE9", bg = "NONE"    },
                    LineNrBelow      = { fg = "#4C566A", bg = "NONE"    },
                    MatchParen       = { fg = "#88C0D0", bg = "#4C566A" },
                    NonText          = { fg = "#434C5E", bg = "NONE",    style = "NONE" },
                    Normal           = { fg = "#D8DEE9", bg = "#2E3440" },
                    NormalNC         = { fg = "#D8DEE9", bg = "#2A303C" },
                    Pmenu            = { fg = "#D8DEE9", bg = "#3b4252", style = "NONE" },
                    PmenuSel         = { fg = "#88C0D0", bg = "#4C566A" },
                    PmenuSbar        = { fg = "#D8DEE9", bg = "#4C566A" },
                    PmenuThumb       = { fg = "#88C0D0", bg = "#3b4252" },
                    SpecialKey       = { fg = "#4C566A", bg = "NONE"    },
                    SpellBad         = { fg = "#BF616A", bg = "#2E3440", style = "undercurl", sp = "#BF616A" },
                    SpellCap         = { fg = "#EBCB8B", bg = "#2E3440", style = "undercurl", sp = "#EBCB8B" },
                    SpellLocal       = { fg = "#E5E9F0", bg = "#2E3440", style = "undercurl", sp = "#E5E9F0" },
                    SpellRare        = { fg = "#ECEFF4", bg = "#2E3440", style = "undercurl", sp = "#ECEFF4" },
                    Visual           = { fg = "NONE",    bg = "#434C5E" },
                    VisualNOS        = { fg = "NONE",    bg = "#434C5E" },
                    -- Neovim
                    healthError      = { fg = "#BF616A", bg = "#3B4252" },
                    healthSuccess    = { fg = "#A3BE8C", bg = "#3B4252" },
                    healthWarning    = { fg = "#EBCB8B", bg = "#3B4252" },
                    TermCursorNC     = { fg = "NONE",    bg = "#3B4252" },
                    -- Gutter
                    CursorLineNr     = { fg = "#D8DEE9", bg = "#3B4252", style = "NONE" },
                    Folded           = { fg = "#2E3440", bg = "#434c5e", style = "bold" },
                    FoldColumn       = { fg = "#4C566A", bg = "NONE"    },
                    SignColumn       = { fg = "#3B4252", bg = "NONE"    },
                    -- Navigation
                    Directory        = { fg = "#88C0D0", bg = "NONE"    },
                    -- Prompt/Status
                    EndOfBuffer      = { fg = "#3B4252", bg = "NONE",    style = "NONE" },
                    ErrorMsg         = { fg = "#D8DEE9", bg = "#BF616A" },
                    ModeMsg          = { fg = "#D8DEE9", bg = "NONE"    },
                    MoreMsg          = { fg = "#88C0D0", bg = "NONE"    },
                    Question         = { fg = "#D8DEE9", bg = "NONE",    style = "NONE" },
                    StatusLine       = { fg = "#88C0D0", bg = "#3B4252", style = "NONE" },
                    StatusLineNC     = { fg = "#D8DEE9", bg = "#3B4252", style = "NONE" },
                    StatusLineTerm   = { fg = "#88C0D0", bg = "#3B4252", style = "NONE" },
                    StatusLineTermNC = { fg = "#D8DEE9", bg = "#3B4252", style = "NONE" },
                    WarningMsg       = { fg = "#2E3440", bg = "#EBCB8B" },
                    WildMenu         = { fg = "#3B4252", bg = "#88C0D0" },
                    NormalFloat      = { fg = "#D8DEE9", bg = "#2E3440" },
                    FloatBorder      = { link = "Float" },
                    -- Search
                    Search           = { fg = "#88C0D0", bg = "#3B4252", style = "reverse" },
                    IncSearch        = { fg = "#ECEFF4", bg = "#5E81AC", style = "underline" },
                    -- Tabs
                    TabLine          = { fg = "#ECEFF4", bg = "#4C566A", style = "NONE" },
                    TabLineFill      = { fg = "#ECEFF4", bg = "#3B4252", style = "NONE" },
                    TabLineSel       = { fg = "#88C0D0", bg = "#3B4252", style = "NONE" },
                    -- Window
                    Title            = { fg = "#D8DEE9", bg = "NONE",    style = "NONE" },
                    VertSplit        = { fg = "#3b4252", bg = "NONE" },
                },
                plugins = {
                    alpha = {
                        AlphaButtons         = { fg = "#d8dee9", bg = "NONE" },
                        AlphaButtonShortcuts = { fg = "#88C0D0", bg = "NONE" },
                        AlphaHeader          = { fg = "#81a1c1", bg = "NONE" },
                        AlphaFooter          = { fg = "#4c566a", bg = "NONE" },
                    },
                    bufferline = {
                        BufferLineDiagnostic                = { fg = "#D8DEE9", bg = "#4C566A" },
                        BufferLineDiagnosticVisible         = { fg = "#ECEFF4", bg = "#616E88" },
                        BufferLineDiagnosticSelected        = { fg = "#3B4252", bg = "#81A1C1" },
                        BufferLineErrorDiagnostic           = { fg = "#BF616A", bg = "#4C566A" },
                        BufferLineErrorDiagnosticVisible    = { fg = "#BF616A", bg = "#616E88" },
                        BufferLineErrorDiagnosticSelected   = { fg = "#BF616A", bg = "#81A1C1" },
                        BufferLineError                     = { fg = "#D8DEE9", bg = "#4C566A" },
                        BufferLineErrorVisible              = { fg = "#ECEFF4", bg = "#616E88" },
                        BufferLineErrorSelected             = { fg = "#3B4252", bg = "#81A1C1" },
                        BufferLineWarningDiagnostic         = { fg = "#EBCB8B", bg = "#4C566A" },
                        BufferLineWarningDiagnosticVisible  = { fg = "#EBCB8B", bg = "#616E88" },
                        BufferLineWarningDiagnosticSelected = { fg = "#EBCB8B", bg = "#81A1C1" },
                        BufferLineWarning                   = { fg = "#D8DEE9", bg = "#4C566A" },
                        BufferLineWarningVisible            = { fg = "#ECEFF4", bg = "#616E88" },
                        BufferLineWarningSelected           = { fg = "#3B4252", bg = "#81A1C1" },
                        BufferLineInfoDiagnostic            = { fg = "#88C0D0", bg = "#4C566A" },
                        BufferLineInfoDiagnosticVisible     = { fg = "#88C0D0", bg = "#616E88" },
                        BufferLineInfoDiagnosticSelected    = { fg = "#88C0D0", bg = "#81A1C1" },
                        BufferLineInfo                      = { fg = "#D8DEE9", bg = "#4C566A" },
                        BufferLineInfoVisible               = { fg = "#ECEFF4", bg = "#616E88" },
                        BufferLineInfoSelected              = { fg = "#3B4252", bg = "#81A1C1" },
                        BufferLineHintDiagnostic            = { fg = "#5E81AC", bg = "#4C566A" },
                        BufferLineHintDiagnosticVisible     = { fg = "#5E81AC", bg = "#616E88" },
                        BufferLineHintDiagnosticSelected    = { fg = "#5E81AC", bg = "#81A1C1" },
                        BufferLineHint                      = { fg = "#D8DEE9", bg = "#4C566A" },
                        BufferLineHintVisible               = { fg = "#ECEFF4", bg = "#616E88" },
                        BufferLineHintSelected              = { fg = "#3B4252", bg = "#81A1C1" },
                        BufferLineGroupSeparator            = { fg = "#3B4252", bg = "#4C566A" },
                        BufferLineGroupLabel                = { fg = "#3B4252", bg = "#88C0D0" },
                        BufferLineNumbers                   = { fg = "#D8DEE9", bg = "#4C566A" },
                        BufferLineNumbersVisible            = { fg = "#ECEFF4", bg = "#616E88" },
                        BufferLineNumbersSelected           = { fg = "#3B4252", bg = "#81A1C1" },
                        BufferLineBuffer                    = { fg = "#D8DEE9", bg = "#4C566A" },
                        BufferLineBufferVisible             = { fg = "#ECEFF4", bg = "#616E88" },
                        BufferLineBufferSelected            = { fg = "#3B4252", bg = "#81A1C1" },
                        BufferLineTab                       = { fg = "#D8DEE9", bg = "#4C566A" },
                        BufferLineTabSelected               = { fg = "#3B4252", bg = "#81A1C1" },
                        BufferLineTabClose                  = { fg = "#D8DEE9", bg = "#4C566A" },
                        BufferLineCloseButton               = { fg = "#D8DEE9", bg = "#4C566A" },
                        BufferLineCloseButtonVisible        = { fg = "#ECEFF4", bg = "#616E88" },
                        BufferLineCloseButtonSelected       = { fg = "#3B4252", bg = "#81A1C1" },
                        BufferLineSeparator                 = { fg = "#3B4252", bg = "#4C566A" },
                        BufferLineSeparatorVisible          = { fg = "#3B4252", bg = "#616E88" },
                        BufferLineSeparatorSelected         = { fg = "#3B4252", bg = "#81A1C1" },
                        BufferLineDuplicate                 = { fg = "#ECEFF4", bg = "#4C566A", style = "bold" },
                        BufferLineDuplicateVisible          = { fg = "#ECEFF4", bg = "#616E88", style = "bold" },
                        BufferLineDuplicateSelected         = { fg = "#ECEFF4", bg = "#81A1C1", style = "bold" },
                        BufferLineModified                  = { fg = "#EBCB8B", bg = "#4C566A" },
                        BufferLineModifiedVisible           = { fg = "#EBCB8B", bg = "#616E88" },
                        BufferLineModifiedSelected          = { fg = "#EBCB8B", bg = "#81A1C1" },
                        BufferLinePick                      = { fg = "#D08770", bg = "#2E3440" },
                        BufferLinePickVisible               = { fg = "#D08770", bg = "#2E3440" },
                        BufferLinePickSelected              = { fg = "#D08770", bg = "#2E3440" },
                        BufferLineIndicatorSelected         = { fg = "#3B4252", bg = "#81A1C1" },
                        BufferLineBackground                = { fg = "#D8DEE9", bg = "#4C566A" },
                        BufferLineFill                      = { fg = "#ECEFF4", bg = "#3B4252", style = "bold" },
                    },
                    cmp = {
                        CmpItemAbbr           = { fg = "#81A1C1", bg = "NONE"    },
                        CmpItemKind           = { fg = "#ECEFF4", bg = "NONE"    },
                        CmpItemMenu           = { fg = "#ECEFF4", bg = "NONE"    },
                        CmpItemAbbrDeprecated = { fg = "#D08770", bg = "NONE",    style = "strikethrough" },
                        CmpItemAbbrMatch      = { fg = "#D8DEE9", bg = "NONE"    },
                        CmpItemAbbrMatchFuzzy = { fg = "#D8DEE9", bg = "NONE"    },
                        CmpItemKindSnippet    = { fg = "#EBCB8B", bg = "NONE"    },
                        CmpItemKindVariable   = { fg = "#5E81AC", bg = "NONE"    },
                        CmpItemKindInterface  = { fg = "#5E81AC", bg = "NONE"    },
                        CmpItemKindText       = { fg = "#5E81AC", bg = "NONE"    },
                        CmpItemKindFunction   = { fg = "#88C0D0", bg = "NONE"    },
                        CmpItemKindMethod     = { fg = "#88C0D0", bg = "NONE"    },
                        CmpItemKindKeyword    = { fg = "#D8DEE9", bg = "NONE"    },
                        CmpItemKindProperty   = { fg = "#D8DEE9", bg = "NONE"    },
                        CmpItemKindUnit       = { fg = "#D8DEE9", bg = "NONE"    },
                    },
                    dressing = {
                        FloatTitle = { link = "Float" },
                    },
                    gitsigns = {
                        GitSignsCurrentLineBlame = { fg = "#5e81ac", bg = "NONE"    },
                        GitSignsAdd              = { fg = "#A3BE8C", bg = "NONE"    },
                        GitSignsAddNr            = { fg = "#A3BE8C", bg = "#3B4252" },
                        GitSignsAddLn            = { fg = "#A3BE8C", bg = "NONE"    },
                        GitSignsChange           = { fg = "#EBCB8B", bg = "NONE"    },
                        GitSignsChangeNr         = { fg = "#EBCB8B", bg = "#3B4252" },
                        GitSignsChangeLn         = { fg = "#EBCB8B", bg = "NONE"    },
                        GitSignsDelete           = { fg = "#BF616A", bg = "NONE"    },
                        GitSignsDeleteNr         = { fg = "#BF616A", bg = "#3B4252" },
                        GitSignsDeleteLn         = { fg = "#BF616A", bg = "NONE"    },
                    },
                    indentline = {
                        IndentBlanklineContextChar        = { fg = "#8FBCBB", bg = "NONE"    },
                        IndentBlanklineContextStart       = { fg = "#8FBCBB", bg = "NONE"    },
                        IndentBlanklineSpaceCharBlankline = { fg = "#3B4252", bg = "NONE"    },
                        IndentBlanklineSpaceChar          = { fg = "#3B4252", bg = "NONE"    },
                        IndentBlanklineChar               = { fg = "#3B4252", bg = "NONE"    },
                    },
                    hlslens = {
                        HlSearchNear     = { link = "IncSearch" },
                        HlSearchLens     = { fg = "#2e3440", bg = "#d8dee9" },
                        HlSearchLensNear = { link = "IncSearch" },
                        HlSearchFloat    = { link = "IncSearch" },
                    },
                    hop = {
                        HopNextKey                = { fg = "#88C0D0", bg = "NONE",    style = "bold" },
                        HopNextKey1               = { fg = "#88C0D0", bg = "NONE"    },
                        HopNextKey2               = { fg = "#D8DEE9", bg = "NONE"    },
                        HopUnmatched              = { fg = "#4C566A", bg = "NONE"    },
                    },
                    lsp = {
                        -- Neovim Diagnostics API
                        DiagnosticError             = { fg = "#BF616A", bg = "NONE"    },
                        DiagnosticWarn              = { fg = "#EBCB8B", bg = "NONE"    },
                        DiagnosticInfo              = { fg = "#88C0D0", bg = "NONE"    },
                        DiagnosticHint              = { fg = "#5E81AC", bg = "NONE"    },
                        -- Neovim DocumentHighlight
                        LspReferenceText            = { fg = "NONE",    bg = "#4C566A" },
                        LspReferenceRead            = { fg = "NONE",    bg = "#4C566A" },
                        LspReferenceWrite           = { fg = "NONE",    bg = "#4C566A" },
                        -- Neovim lspconfig
                        LspCodeLens                 = { fg = "#616E88", bg = "NONE"    },
                        DiagnosticSignError         = { link = "DiagnosticError" },
                        DiagnosticSignWarn          = { link = "DiagnosticWarn" },
                        DiagnosticSignInfo          = { link = "DiagnosticInfo" },
                        DiagnosticSignHint          = { link = "DiagnosticHint" },
                        DiagnosticDefaultError      = { link = "DiagnosticError" },
                        DiagnosticDefaultWarn       = { link = "DiagnosticWarn" },
                        DiagnosticDefaultInfo       = { link = "DiagnosticInfo" },
                        DiagnosticDefaultHint       = { link = "DiagnosticHint" },
                        DiagnosticUnderlineError    = { fg = "#BF616A", bg = "NONE",    style = "undercurl" },
                        DiagnosticUnderlineWarn     = { fg = "#EBCB8B", bg = "NONE",    style = "undercurl" },
                        DiagnosticUnderlineInfo     = { fg = "#88C0D0", bg = "NONE",    style = "undercurl" },
                        DiagnosticUnderlineHint     = { fg = "#5E81AC", bg = "NONE",    style = "undercurl" },
                        DiagnosticVirtualTextError  = { fg = "#BF616A", bg = "NONE",    style = "italic" },
                        DiagnosticVirtualTextWarn   = { fg = "#EBCB8B", bg = "NONE",    style = "italic" },
                        DiagnosticVirtualTextInfo   = { fg = "#88C0D0", bg = "NONE",    style = "italic" },
                        DiagnosticVirtualTextHint   = { fg = "#5E81AC", bg = "NONE",    style = "italic" },
                        -- Neovim LspSignatureHelp
                        LspSignatureActiveParameter = { fg = "#88C0D0", bg = "NONE"    },
                    },
                    lualine = {
                        lualineDiagnosticError = { fg = "#BF616A", bg = "#3B4252" },
                        lualineDiagnosticWarn  = { fg = "#EBCB8B", bg = "#3B4252" },
                        lualineDiagnosticInfo  = { fg = "#88C0D0", bg = "#3B4252" },
                        lualineDiagnosticHint  = { fg = "#5E81AC", bg = "#3B4252" },
                    },
                    mini_cursorword = {
                        MiniCursorword        = { link = "Visual" },
                        MiniCursorwordCurrent = { fg = "NONE",    bg = "NONE",    style = "nocombine" },
                    },
                    notify = {
                        NotifyERRORBorder = { link = "DiagnosticError" },
                        NotifyWARNBorder  = { link = "DiagnosticWarn" },
                        NotifyINFOBorder  = { link = "DiagnosticInfo" },
                        NotifyDEBUGBorder = { link = "DiagnosticError" },
                        NotifyTRACEBorder = { link = "DiagnosticHint" },
                        NotifyERRORIcon   = { link = "DiagnosticError" },
                        NotifyWARNIcon    = { link = "DiagnosticWarn" },
                        NotifyINFOIcon    = { link = "DiagnosticInfo" },
                        NotifyDEBUGIcon   = { link = "DiagnosticError" },
                        NotifyTRACEIcon   = { link = "DiagnosticHint" },
                        NotifyERRORTitle  = { link = "DiagnosticError" },
                        NotifyWARNTitle   = { link = "DiagnosticWarn" },
                        NotifyINFOTitle   = { link = "DiagnosticInfo" },
                        NotifyDEBUGTitle  = { link = "DiagnosticError" },
                        NotifyTRACETitle  = { link = "DiagnosticHint" },
                        NotifyERRORBody   = { link = "Normal" },
                        NotifyWARNBody    = { link = "Normal" },
                        NotifyINFOBody    = { link = "Normal" },
                        NotifyDEBUGBody   = { link = "Normal" },
                        NotifyTRACEBody   = { link = "Normal" },
                    },
                    nvim_tree = {
                        NvimTreeNormalNC          = { link = "NormalNC" },
                        NvimTreeSignColumn        = { fg = "#3B4252", bg = "NONE"    },
                        NvimTreeRootFolder        = { fg = "#88C0D0", bg = "NONE",    style = "bold" },
                        NvimTreeFolderIcon        = { fg = "#D8DEE9", bg = "NONE"    },
                        NvimTreeFolderName        = { fg = "#5E81AC", bg = "NONE"    },
                        NvimTreeEmptyFolderName   = { fg = "#4C566A", bg = "NONE"    },
                        NvimTreeOpenedFolderName  = { fg = "#81a1c1", bg = "NONE"    },
                        NvimTreeIndentMarker      = { fg = "#4C566A", bg = "NONE"    },
                        NvimTreeOpenedFile        = { fg = "#81A1C1", bg = "NONE"    },
                        NvimTreeExecFile          = { fg = "#88C0D0", bg = "NONE"    },
                        NvimTreeSpecialFile       = { fg = "#81A1C1", bg = "NONE",    style = "underline" },
                        NvimTreeGitNew            = { fg = "#A3BE8C", bg = "NONE"    },
                        NvimTreeGitDirty          = { fg = "#EBCB8B", bg = "NONE"    },
                        NvimTreeImageFile         = { fg = "#B48EAD", bg = "NONE"    },
                        NvimTreeWindowPicker      = { fg = "#3b4252", bg = "#88C0D0" },
                        LspDiagnosticsError       = { link = "DiagnosticError" },
                        LspDiagnosticsWarning     = { link = "DiagnosticWarn" },
                        LspDiagnosticsHint        = { link = "DiagnosticInfo" },
                        LspDiagnosticsInformation = { link = "DiagnosticHint" },
                    },
                    quick_scope = {
                        QuickScopeSecondary = { fg = "#EBCB8B", bg = "NONE"    },
                        QuickScopePrimary   = { fg = "#B48EAD", bg = "NONE"    },
                    },
                    scrollbar = {
                        ScrollBarHandle = { fg = "NONE",    bg = "#4C566A" },
                    },
                    telescope = {
                        TelescopePromptPrefix   = { fg = "#8fbcbb", bg = "NONE" },
                        TelescopePromptBorder   = { link = "Float" },
                        TelescopeResultsBorder  = { link = "Float" },
                        TelescopeResultsNormal  = { fg = "#81A1C1", bg = "NONE"    },
                        TelescopePreviewBorder  = { fg = "#88C0D0", bg = "NONE"    },
                        TelescopeMultiSelection = { link = "TelescopeResultsNormal" },
                        TelescopeMultiIcon      = { fg = "#ECEFF4", bg = "#434c5e" },
                        TelescopeSelectionCaret = { link = "TelescopeSelection" },
                        TelescopeSelection      = { fg = "#88C0D0", bg = "#434c5e", style = "bold" },
                        TelescopeMatching       = { fg = "#ECEFF4", bg = "NONE" },
                    },
                    todo = {
                        TodoBgFIX    = { fg = "#ECEFF4", bg = "#BF616A", style = "bold" },
                        TodoFgFIX    = { link = "DiagnosticError" },
                        TodoSignFIX  = { link = "DiagnosticError" },
                        TodoBgNOTE   = { fg = "#ECEFF4", bg = "#5E81AC", style = "bold" },
                        TodoFgNOTE   = { link = "DiagnosticHint" },
                        TodoSignNOTE = { link = "DiagnosticHint" },
                        TodoBgWARN   = { fg = "#ECEFF4", bg = "#EBCB8B", style = "bold" },
                        TodoFgWARN   = { link = "DiagnosticWarn" },
                        TodoSignWARN = { link = "DiagnosticWarn" },
                        TodoBgPERF   = { fg = "#ECEFF4", bg = "#A3BE8C", style = "bold" },
                        TodoFgPERF   = { fg = "#A3BE8C", bg = "NONE"    },
                        TodoSignPERF = { fg = "#A3BE8C", bg = "NONE"    },
                        TodoBgTODO   = { fg = "#ECEFF4", bg = "#88C0D0", style = "bold" },
                        TodoFgTODO   = { link = "DiagnosticInfo" },
                        TodoSignTODO = { link = "DiagnosticInfo" },
                        TodoBgHACK   = { fg = "#ECEFF4", bg = "#EBCB8B", style = "bold" },
                        TodoFgHACK   = { link = "DiagnosticWarn" },
                        TodoSignHACK = { link = "DiagnosticWarn" },
                    },
                    ts_rainbow = {
                        rainbowcol1 = { fg = "#5E81AC", bg = "NONE"    },
                        rainbowcol2 = { fg = "#BF616A", bg = "NONE"    },
                        rainbowcol3 = { fg = "#EBCB8B", bg = "NONE"    },
                        rainbowcol4 = { fg = "#A3BE8C", bg = "NONE"    },
                        rainbowcol5 = { fg = "#B48EAD", bg = "NONE"    },
                        rainbowcol6 = { fg = "#8FBCBB", bg = "NONE"    },
                        rainbowcol7 = { fg = "#D8DEE9", bg = "NONE"    },
                    },
                    which_key = {
                        WhichKey          = { fg = "#8FBCBB", bg = "NONE",   },
                        WhichKeyGroup     = { fg = "#88C0D0", bg = "NONE"    },
                        WhichKeyDesc      = { fg = "#D8DEE9", bg = "NONE",    style = "italic" },
                        WhichKeySeperator = { fg = "#88C0D0", bg = "NONE"    },
                        WhichKeyValue     = { link = "Comment" },
                        WhichKeyFloat     = { link = "Float" },
                    },
                },
            },
            dracula = {
                plugins = {
                    mini_cursorword = {
                        MiniCursorword        = { link = "Visual" },
                        MiniCursorwordCurrent = { fg = "NONE",    bg = "NONE",    style = "nocombine" },
                    },
                    notify = {
                        NotifyERRORBorder = { link = "DiagnosticError" },
                        NotifyWARNBorder  = { link = "DiagnosticWarn" },
                        NotifyINFOBorder  = { link = "DiagnosticInfo" },
                        NotifyDEBUGBorder = { link = "DiagnosticError" },
                        NotifyTRACEBorder = { link = "DiagnosticHint" },
                        NotifyERRORIcon   = { link = "DiagnosticError" },
                        NotifyWARNIcon    = { link = "DiagnosticWarn" },
                        NotifyINFOIcon    = { link = "DiagnosticInfo" },
                        NotifyDEBUGIcon   = { link = "DiagnosticError" },
                        NotifyTRACEIcon   = { link = "DiagnosticHint" },
                        NotifyERRORTitle  = { link = "DiagnosticError" },
                        NotifyWARNTitle   = { link = "DiagnosticWarn" },
                        NotifyINFOTitle   = { link = "DiagnosticInfo" },
                        NotifyDEBUGTitle  = { link = "DiagnosticError" },
                        NotifyTRACETitle  = { link = "DiagnosticHint" },
                        NotifyERRORBody   = { link = "Normal" },
                        NotifyWARNBody    = { link = "Normal" },
                        NotifyINFOBody    = { link = "Normal" },
                        NotifyDEBUGBody   = { link = "Normal" },
                        NotifyTRACEBody   = { link = "Normal" },
                    },
                    ts_rainbow = {
                        rainbowcol1 = { fg = "#6272A4", bg = "NONE"    },
                        rainbowcol2 = { fg = "#f8f8f2", bg = "NONE"    },
                        rainbowcol3 = { fg = "#ff79c6", bg = "NONE"    },
                        rainbowcol4 = { fg = "#8be9fd", bg = "NONE"    },
                        rainbowcol5 = { fg = "#f1fa8c", bg = "NONE"    },
                        rainbowcol6 = { fg = "#bd93f9", bg = "NONE"    },
                        rainbowcol7 = { fg = "#50fa7b", bg = "NONE"    },
                    },
                }
            }
        },
    },
    langs = {
        html = true,
        md   = true,
    },
    plugins = {
        treesitter = true,
        indentline = true,
        barbar     = true,
        bufferline = true,
        cmp        = true,
        gitsigns   = true,
        lsp        = true,
        telescope  = true,
    },
    enable_installer = false, -- enable installer module
})
