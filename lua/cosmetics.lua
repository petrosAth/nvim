local M = {}

-- Table containing variables
M.variables = {
    transparency = 5
}

-- Table containing icons
M.icon = {
    error    = { "", "", "", "", "", "" },
    warn     = { "", "", "", "", "", "" },
    hint     = { "", "", "", "", "", "" },
    info     = { "", "", "", "", "", "" },
    action   = { "", "", "", "", "", "" },
    close    = { "", "" },
    delete   = { "", "" },
    pending  = { "", "", },
    done     = { "", "", "" },
    def      = { "", "", "", "硫"},
    edit     = { "", "", "" },
    prompt   = { "❯", "", "", "❯" },
    location = { "", "", "", "" },
    misc     = { "", "", "", "", "", "" },
    bug      = { "", "", "" },
    folderop = { "", "", "" },
    foldercl = { "", "", "" },
    arrowl   = { "", "", "", "", "" },
    arrowr   = { "", "", "", "", "" },
    arrowu   = { "", "", "", "", "" },
    arrowd   = { "", "", "", "", "" },
    loading  = {
        circle = {
            -- "◝", "◞", "◟", "◜"
            "", "", "", "", "", ""
        },
        braille = {
            "⣷", "⣯", "⣟", "⡿", "⢿", "⣻", "⣽", "⣾"
        },
        sphere = {
            "", "", "", "", "", "", "",
            "", "", "", "", "", "", "",
            "", "", "", "", "", "", "",
            "", "", "", "", "", "", "",
        }
    },
    -- Fillchar and listchar icons
    nvim_ui  = {
        stl       = { " " },           -- ' ' or '^' -- statusline of the current window
        stlnc     = { " " },           -- ' ' or '=' -- statusline of the non-current windows
        vert      = { "▌", "▏", "▌", "│", "┃", "▕", "▐", "░", "▒", "▓", "█" }, -- '│' or '|' -- vertical separators |:vsplit|
        fold      = { " " },           -- '·' or '-' -- filling 'foldtext'
        foldopen  = { "", "" },      -- '-'        -- mark the beginning of a fold
        foldclose = { "", "", "" }, -- '+'        -- show a closed fold
        foldsep   = { "", "" },      -- '│' or '|' -- open fold middle marker
        diff      = { "-" },           -- '-'        -- deleted lines of the 'diff' option
        msgsep    = { " " },           -- ' '        -- message separator 'display'
        eob       = { "-" },           -- '~'        -- empty lines at the end of a buffer
        tab       = { "──" },          -- Two or three characters to be used to show a tab
        lead      = { " " },           -- Character to show for leading spaces
        eol       = { "﬋" }            -- Character to show at the end of each line
    }
}

-- Table containing borders
M.border = {
    table    = { tl = "┌",  t = "─", tr = "┐",  r = "│", br = "┘",  b = "─", bl = "└",  l = "│", ml = "├", mr = "┤" },
    single   = { tl = "┌",  t = "─", tr = "┐",  r = "│", br = "┘",  b = "─", bl = "└",  l = "│", ml = "├", mr = "┤" },
    round    = { tl = "╭",  t = "─", tr = "╮",  r = "│", br = "╯",  b = "─", bl = "╰",  l = "│", ml = "├", mr = "┤" },
    double   = { tl = "╔",  t = "═", tr = "╗",  r = "║", br = "╝",  b = "═", bl = "╚",  l = "║", ml = "╟", mr = "╢",      "╠",      "╣", },
    box      = { tl = "▛",  t = "▀", tr = "▜",  r = "▐", br = "▟",  b = "▄", bl = "▙",  l = "▌" }
}

require("themer").setup({
    colorscheme = "nord", -- default colorscheme
    transparent = false,
    term_colors = true,
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
                    ColorColumn      = { fg = "NONE",    bg = "#3B4252" },
                    Cursor           = { fg = "#2E3440", bg = "#D8DEE9" },
                    CursorLine       = { fg = "NONE",    bg = "#3B4252" },
                    Error            = { fg = "#D8DEE9", bg = "#BF616A" },
                    iCursor          = { fg = "#2E3440", bg = "#D8DEE9" },
                    LineNrAbove      = { fg = "#4C566A", bg = "NONE"    },
                    LineNr           = { fg = "#D8DEE9", bg = "NONE"    },
                    LineNrBelow      = { fg = "#4C566A", bg = "NONE"    },
                    MatchParen       = { fg = "#88C0D0", bg = "#4C566A" },
                    NonText          = { fg = "#434C5E", bg = "NONE",    style = "NONE" },
                    Normal           = { fg = "#D8DEE9", bg = "#2E3440" },
                    NormalNC         = { fg = "#D8DEE9", bg = "#2A303C" },
                    Pmenu            = { fg = "#D8DEE9", bg = "#434C5E", style = "NONE" },
                    PmenuSbar        = { fg = "#D8DEE9", bg = "#434C5E" },
                    PmenuSel         = { fg = "#88C0D0", bg = "#4C566A" },
                    PmenuThumb       = { fg = "#88C0D0", bg = "#4C566A" },
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
                    CursorColumn     = { fg = "NONE",    bg = "#3B4252" },
                    CursorLineNr     = { fg = "#D8DEE9", bg = "#3B4252", style = "NONE" },
                    Folded           = { fg = "#2E3440", bg = "#434C5E", style = "bold" },
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
                    StatusLine       = { fg = "#88C0D0", bg = "#2a303c", style = "NONE" },
                    StatusLineNC     = { fg = "#D8DEE9", bg = "#2a303c", style = "NONE" },
                    StatusLineTerm   = { fg = "#88C0D0", bg = "#2a303c", style = "NONE" },
                    StatusLineTermNC = { fg = "#D8DEE9", bg = "#2a303c", style = "NONE" },
                    WarningMsg       = { fg = "#2E3440", bg = "#EBCB8B" },
                    WildMenu         = { fg = "#3B4252", bg = "#88C0D0" },
                    -- Search
                    Search           = { fg = "#88C0D0", bg = "#3B4252", style = "reverse" },
                    IncSearch        = { fg = "#ECEFF4", bg = "#5E81AC", style = "underline" },
                    -- Tabs
                    TabLine          = { fg = "#ECEFF4", bg = "#4C566A", style = "NONE" },
                    TabLineFill      = { fg = "#ECEFF4", bg = "#3B4252", style = "NONE" },
                    TabLineSel       = { fg = "#88C0D0", bg = "#3B4252", style = "NONE" },
                    -- Window
                    Title            = { fg = "#D8DEE9", bg = "NONE",    style = "NONE" },
                    VertSplit        = { fg = "#2a303c", bg = "#2a303c" },
                    -- Plugins
                    -- bufferline
                    offsetTitleBar            = { fg = "#ECEFF4", bg = "#4C566A" },
                    -- gitsigns
                    GitSignsCurrentLineBlame  = { fg = "#4C566A", bg = "NONE"    },
                    GitSignsAdd               = { fg = "#A3BE8C", bg = "NONE"    },
                    GitSignsAddNr             = { fg = "#A3BE8C", bg = "#3B4252" },
                    GitSignsAddLn             = { fg = "#A3BE8C", bg = "NONE"    },
                    GitSignsChange            = { fg = "#EBCB8B", bg = "NONE"    },
                    GitSignsChangeNr          = { fg = "#EBCB8B", bg = "#3B4252" },
                    GitSignsChangeLn          = { fg = "#EBCB8B", bg = "NONE"    },
                    GitSignsDelete            = { fg = "#BF616A", bg = "NONE"    },
                    GitSignsDeleteNr          = { fg = "#BF616A", bg = "#3B4252" },
                    GitSignsDeleteLn          = { fg = "#BF616A", bg = "NONE"    },
                    -- hop
                    HopNextKey   = { fg = "#D8DEE9", bg = "NONE",    style = "bold" },
                    HopNextKey1  = { fg = "#88C0D0", bg = "NONE",    style = "bold" },
                    HopNextKey2  = { fg = "#D8DEE9", bg = "NONE" },
                    HopUnmatched = { fg = "#4C566A", bg = "NONE" },
                    -- lualine
                    lualineDiagnosticError    = { fg = "#BF616A", bg = "#3B4252" },
                    lualineDiagnosticWarn     = { fg = "#EBCB8B", bg = "#3B4252" },
                    lualineDiagnosticInfo     = { fg = "#88C0D0", bg = "#3B4252" },
                    lualineDiagnosticHint     = { fg = "#5E81AC", bg = "#3B4252" },
                    -- mini cursorword
                    MiniCursorword            = { link = "Visual" },
                    MiniCursorwordCurrent     = { fg = "NONE",    bg = "NONE",     style = "nocombine" },
                    -- nvim-tree
                    NvimTreeNormalNC          = { link = "NormalNC"              },
                    NvimTreeSignColumn        = { fg = "#3B4252", bg = "NONE"    },
                    NvimTreeRootFolder        = { fg = "#88C0D0", bg = "NONE",     style = "bold" },
                    NvimTreeFolderIcon        = { fg = "#D8DEE9", bg = "NONE"    },
                    NvimTreeFolderName        = { fg = "#5E81AC", bg = "NONE"    },
                    NvimTreeEmptyFolderName   = { fg = "#4C566A", bg = "NONE"    },
                    NvimTreeOpenedFolderName  = { fg = "#81a1c1", bg = "NONE"    },
                    NvimTreeIndentMarker      = { fg = "#4C566A", bg = "NONE"    },
                    NvimTreeOpenedFile        = { fg = "#81A1C1", bg = "NONE"    },
                    NvimTreeExecFile          = { fg = "#88C0D0", bg = "NONE"    },
                    NvimTreeSpecialFile       = { fg = "#81A1C1", bg = "NONE"   , style = "underline" },
                    NvimTreeGitNew            = { fg = "#A3BE8C", bg = "NONE"    },
                    NvimTreeGitDirty          = { fg = "#EBCB8B", bg = "NONE"    },
                    NvimTreeImageFile         = { fg = "#B48EAD", bg = "NONE"    },
                    NvimTreeWindowPicker      = { fg = "#3b4252", bg = "#88C0D0" },
                    LspDiagnosticsError       = { link = "DiagnosticError" },
                    LspDiagnosticsWarning     = { link = "DiagnosticWarn" },
                    LspDiagnosticsHint        = { link = "DiagnosticInfo" },
                    LspDiagnosticsInformation = { link = "DiagnosticHint" },
                    -- nvim-ts-rainbow
                    rainbowcol1               = { fg = "#5E81AC", bg = "NONE"    },
                    rainbowcol2               = { fg = "#BF616A", bg = "NONE"    },
                    rainbowcol3               = { fg = "#EBCB8B", bg = "NONE"    },
                    rainbowcol4               = { fg = "#A3BE8C", bg = "NONE"    },
                    rainbowcol5               = { fg = "#B48EAD", bg = "NONE"    },
                    rainbowcol6               = { fg = "#8FBCBB", bg = "NONE"    },
                    rainbowcol7               = { fg = "#D8DEE9", bg = "NONE"    },
                    -- quick-scope
                    QuickScopeSecondary       = { fg = "#EBCB8B", bg = "NONE"    },
                    QuickScopePrimary         = { fg = "#B48EAD", bg = "NONE"    },
                    -- todo-comment
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
                    -- which-key
                    WhichKey                  = { fg = "#8FBCBB", bg = "NONE",   },
                    WhichKeyGroup             = { fg = "#88C0D0", bg = "NONE"    },
                    WhichKeyDesc              = { fg = "#D8DEE9", bg = "NONE",    style = "italic" },
                    WhichKeySeperator         = { fg = "#88C0D0", bg = "NONE"    },
                    WhichKeyValue             = { link = "Comment" },
                    WhichKeyFloat             = { link = "Float" },
                },
                plugins = {
                    cmp = {
                        CmpItemMenu = { fg = "#81A1C1", bg = "NONE"    },
                        CmpItemKind = { fg = "#88C0D0", bg = "NONE"    },
                        CmpItemAbbr = { fg = "#D8DEE9", bg = "NONE"    },
                    },
                    indentline = {
                        IndentBlanklineContextChar        = { fg = "#8FBCBB", bg = "NONE"    },
                        IndentBlanklineContextStart       = { fg = "#8FBCBB", bg = "NONE"    },
                        IndentBlanklineSpaceCharBlankline = { fg = "#3B4252", bg = "NONE"    },
                        IndentBlanklineSpaceChar          = { fg = "#3B4252", bg = "NONE"    },
                        IndentBlanklineChar               = { fg = "#3B4252", bg = "NONE"    },
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
                    telescope = {
                        TelescopePromptBorder =   { link = "Float" },
                        TelescopeResultsBorder =  { link = "Float" },
                        TelescopePreviewBorder =  { fg = "#88C0D0", bg = "NONE"    },
                        TelescopeSelectionCaret = { fg = "#88C0D0", bg = "#2E3440" },
                        TelescopeSelection =      { fg = "#88C0D0", bg = "#2E3440" },
                        TelescopeMatching =       { fg = "#5E81AC", bg = "#2E3440" },
                    }
                },
            },
        },
    },
    langs = {
        html = true,
        md = true,
    },

    plugins = {
        treesitter = true,
        indentline = true,
        barbar = true,
        bufferline = true,
        cmp = true,
        gitsigns = true,
        lsp = true,
        telescope = true,
    },
    enable_installer = false, -- enable installer module
})

return M
