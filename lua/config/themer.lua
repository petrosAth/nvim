-- Palettes
local p = {
    -- Color palettes
    -- Dracula
    draculaFg        = "#F8F8F2",
    draculaBglighter = "#424450",
    draculaBglight   = "#343746",
    draculaBg        = "#282A36",
    draculaBgdark    = "#21222C",
    draculaBgdarker  = "#191A21",
    draculaComment   = "#6272A4",
    draculaSelection = "#44475A",
    draculaSubtle    = "#424450",
    draculaCyan      = "#8BE9FD",
    draculaGreen     = "#50FA7B",
    draculaOrange    = "#FFB86C",
    draculaPink      = "#FF79C6",
    draculaPurple    = "#BD93F9",
    draculaRed       = "#FF5555",
    draculaYellow    = "#F1FA8C",
    -- Nord
    nord0darker      = "#242a35",
    nord0dark        = "#2A303C",
    nord0            = "#2E3441", -- Change from #2E3440 to avoid transparency
    nord1dark        = "#343b49",
    nord1            = "#3B4252",
    nord2            = "#434C5E",
    nord3            = "#4C566A",
    nord3light       = "#616E88",
    nord4            = "#D8DEE9",
    nord5            = "#E5E9F0",
    nord6            = "#ECEFF4",
    nord7            = "#8FBCBB",
    nord8            = "#88C0D0",
    nord9            = "#81A1C1",
    nord10           = "#5E81AC",
    nord11darker     = "#443844",
    nord11dark       = "#543d48",
    nord11           = "#BF616A",
    nord12           = "#D08770",
    nord13darker     = "#4d4a48",
    nord13dark       = "#635b4f",
    nord13           = "#EBCB8B",
    nord14darker     = "#3e4748",
    nord14dark       = "#4b564f",
    nord14           = "#A3BE8C",
    nord15           = "#B48EAD",
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
                    ColorColumn      = { fg = "none",        bg = p.nord2                                           },
                    Comment          = { fg = p.nord3light,  bg = "none"                                            },
                    Cursor           = { fg = p.nord0,       bg = p.nord4                                           },
                    CursorLine       = { fg = "none",        bg = p.nord1dark                                       },
                    CursorColumn     = { fg = "none",        bg = p.nord1dark                                       },
                    Error            = { fg = p.nord4,       bg = p.nord11                                          },
                    iCursor          = { fg = p.nord0,       bg = p.nord4                                           },
                    LineNrAbove      = { fg = p.nord3,       bg = "none"                                            },
                    LineNr           = { fg = p.nord4,       bg = "none"                                            },
                    LineNrBelow      = { fg = p.nord3,       bg = "none"                                            },
                    MatchParen       = { fg = p.nord8,       bg = p.nord3                                           },
                    NonText          = { fg = p.nord2,       bg = "none",        style = "none"                     },
                    Normal           = { fg = p.nord4,       bg = p.nord0                                           },
                    NormalNC         = { fg = p.nord4,       bg = p.nord0dark                                       },
                    Pmenu            = { fg = p.nord4,       bg = p.nord0darker, style = "none"                     },
                    PmenuSel         = { fg = p.nord8,       bg = p.nord3                                           },
                    PmenuSbar        = { fg = p.nord4,       bg = p.nord1                                           },
                    PmenuThumb       = { fg = p.nord8,       bg = p.nord3light                                      },
                    SpecialKey       = { fg = p.nord3,       bg = "none"                                            },
                    SpellBad         = { fg = p.nord11,      bg = p.nord0,       style = "undercurl", sp = p.nord11 },
                    SpellCap         = { fg = p.nord13,      bg = p.nord0,       style = "undercurl", sp = p.nord13 },
                    SpellLocal       = { fg = p.nord5,       bg = p.nord0,       style = "undercurl", sp = p.nord5  },
                    SpellRare        = { fg = p.nord6,       bg = p.nord0,       style = "undercurl", sp = p.nord6  },
                    Visual           = { fg = "none",        bg = p.nord2                                           },
                    VisualNOS        = { fg = "none",        bg = p.nord2                                           },
                    -- Neovim
                    healthError      = { fg = p.nord11,      bg = p.nord1                                           },
                    healthSuccess    = { fg = p.nord14,      bg = p.nord1                                           },
                    healthWarning    = { fg = p.nord13,      bg = p.nord1                                           },
                    TermCursorNC     = { fg = "none",        bg = p.nord1                                           },
                    -- Gutter
                    CursorLineNr     = { fg = p.nord4,       bg = p.nord1dark,   style = "none"                     },
                    Folded           = { fg = p.nord3light,  bg = "none",        style = "bold"                     },
                    FoldColumn       = { fg = p.nord3light,  bg = "none"                                            },
                    SignColumn       = { fg = p.nord1,       bg = "none"                                            },
                    -- Navigation
                    Directory        = { fg = p.nord8,       bg = "none"                                            },
                    -- Prompt/Status
                    EndOfBuffer      = { fg = p.nord1,       bg = "none",        style = "none"                     },
                    ErrorMsg         = { fg = p.nord4,       bg = p.nord11                                          },
                    ModeMsg          = { fg = p.nord4,       bg = "none"                                            },
                    MoreMsg          = { fg = p.nord8,       bg = "none"                                            },
                    Question         = { fg = p.nord4,       bg = "none",        style = "none"                     },
                    StatusLine       = { fg = p.nord8,       bg = p.nord1,       style = "none"                     },
                    StatusLineNC     = { fg = p.nord4,       bg = p.nord1,       style = "none"                     },
                    StatusLineTerm   = { fg = p.nord8,       bg = p.nord1,       style = "none"                     },
                    StatusLineTermNC = { fg = p.nord4,       bg = p.nord1,       style = "none"                     },
                    WarningMsg       = { fg = p.nord0,       bg = p.nord13                                          },
                    WildMenu         = { fg = p.nord1,       bg = p.nord8                                           },
                    NormalFloat      = { fg = p.nord4,       bg = p.nord0darker                                     },
                    FloatBorder      = { fg = p.nord0,       bg = p.nord0darker                                     },
                    -- Search
                    Search           = { fg = p.nord8,       bg = p.nord0,       style = "reverse"                  },
                    IncSearch        = { fg = p.nord6,       bg = p.nord10,      style = "underline"                },
                    -- Tabs
                    TabLine          = { fg = p.nord6,       bg = p.nord3,       style = "none"                     },
                    TabLineFill      = { fg = p.nord6,       bg = p.nord1,       style = "none"                     },
                    TabLineSel       = { fg = p.nord8,       bg = p.nord1,       style = "none"                     },
                    -- Window
                    Title            = { fg = p.nord4,       bg = "none",        style = "none"                     },
                    VertSplit        = { fg = p.nord1,       bg = "none"                                            },
                    -- diff
                    DiffText         = { fg = p.nord4,       bg = p.nord10,      style = "bold"                     },
                    DiffAdd          = { fg = "none",        bg = p.nord14dark                                      },
                    DiffChange       = { fg = "none",        bg = p.nord13dark                                      },
                    DiffDelete       = { fg = "none",        bg = p.nord11dark                                      },
                    -- Language
                    -- Boolean          = { fg = p.nord9,       bg = "none",                                           },
                    -- Character        = { fg = p.nord14,      bg = "none",                                           },
                    Conceal          = { fg = p.nord0darker, bg = "none"                                            },
                    -- Conditional      = { fg = p.nord9,       bg = "none",                                           },
                    -- Constant         = { fg = p.nord4,       bg = "none",                                           },
                    -- Decorator        = { fg = p.nord12,      bg = "none",                                           },
                    -- Define           = { fg = p.nord9,       bg = "none",                                           },
                    -- Delimiter        = { fg = p.nord6,       bg = "none",                                           },
                    -- Exception        = { fg = p.nord9,       bg = "none",                                           },
                    -- Float            = { fg = p.nord15,      bg = "none",                                           },
                    -- Function         = { fg = p.nord8,       bg = "none",                                           },
                    -- Identifier       = { fg = p.nord4,       bg = "none",        style = "none"                     },
                    -- Include          = { fg = p.nord9,       bg = "none",                                           },
                    -- Keyword          = { fg = p.nord9,       bg = "none",                                           },
                    -- Label            = { fg = p.nord9,       bg = "none",                                           },
                    -- Number           = { fg = p.nord15,      bg = "none",                                           },
                    -- Operator         = { fg = p.nord9,       bg = "none",        style = "none"                     },
                    -- PreProc          = { fg = p.nord9,       bg = "none",        style = "none"                     },
                    -- Repeat           = { fg = p.nord9,       bg = "none",                                           },
                    -- Special          = { fg = p.nord4,       bg = "none",                                           },
                    -- SpecialChar      = { fg = p.nord13,      bg = "none",                                           },
                    -- SpecialComment   = { fg = p.nord8,       bg = "none",        style = "italic"                   },
                    -- Statement        = { fg = p.nord9,       bg = "none",                                           },
                    -- StorageClass     = { fg = p.nord9,       bg = "none",                                           },
                    -- String           = { fg = p.nord14,      bg = "none",                                           },
                    -- Structure        = { fg = p.nord9,       bg = "none",                                           },
                    -- Tag              = { fg = p.nord4,       bg = "none",                                           },
                    -- Todo             = { fg = p.nord13,      bg = "none",                                           },
                    -- Type             = { fg = p.nord9,       bg = "none",        style = "none"                     },
                    -- Typedef          = { fg = p.nord9,       bg = "none",                                           },
                    -- Annotation       = { link = "Decorator"                                                         },
                    -- Macro            = { link = "Define"                                                            },
                    -- PreCondit        = { link = "PreProc"                                                           },
                    -- Variable         = { link = "Identifier"                                                        },
                },
                plugins = {
                    alpha = {
                        AlphaButtons         = { fg = p.nord4, bg = "none" },
                        AlphaButtonShortcuts = { fg = p.nord8, bg = "none" },
                        AlphaHeader          = { fg = p.nord9, bg = "none" },
                        AlphaFooter          = { fg = p.nord3, bg = "none" },
                    },
                    bufferline = {
                        BufferLineDiagnostic                = { fg = p.nord4,  bg = p.nord3                      },
                        BufferLineDiagnosticVisible         = { fg = p.nord6,  bg = p.nord3light                 },
                        BufferLineDiagnosticSelected        = { fg = p.nord1,  bg = p.nord9                      },
                        BufferLineErrorDiagnostic           = { fg = p.nord11, bg = p.nord3                      },
                        BufferLineErrorDiagnosticVisible    = { fg = p.nord11, bg = p.nord3light                 },
                        BufferLineErrorDiagnosticSelected   = { fg = p.nord11, bg = p.nord9                      },
                        BufferLineError                     = { fg = p.nord4,  bg = p.nord3                      },
                        BufferLineErrorVisible              = { fg = p.nord6,  bg = p.nord3light                 },
                        BufferLineErrorSelected             = { fg = p.nord1,  bg = p.nord9                      },
                        BufferLineWarningDiagnostic         = { fg = p.nord13, bg = p.nord3                      },
                        BufferLineWarningDiagnosticVisible  = { fg = p.nord13, bg = p.nord3light                 },
                        BufferLineWarningDiagnosticSelected = { fg = p.nord13, bg = p.nord9                      },
                        BufferLineWarning                   = { fg = p.nord4,  bg = p.nord3                      },
                        BufferLineWarningVisible            = { fg = p.nord6,  bg = p.nord3light                 },
                        BufferLineWarningSelected           = { fg = p.nord1,  bg = p.nord9                      },
                        BufferLineInfoDiagnostic            = { fg = p.nord8,  bg = p.nord3                      },
                        BufferLineInfoDiagnosticVisible     = { fg = p.nord8,  bg = p.nord3light                 },
                        BufferLineInfoDiagnosticSelected    = { fg = p.nord8,  bg = p.nord9                      },
                        BufferLineInfo                      = { fg = p.nord4,  bg = p.nord3                      },
                        BufferLineInfoVisible               = { fg = p.nord6,  bg = p.nord3light                 },
                        BufferLineInfoSelected              = { fg = p.nord1,  bg = p.nord9                      },
                        BufferLineHintDiagnostic            = { fg = p.nord10, bg = p.nord3                      },
                        BufferLineHintDiagnosticVisible     = { fg = p.nord10, bg = p.nord3light                 },
                        BufferLineHintDiagnosticSelected    = { fg = p.nord10, bg = p.nord9                      },
                        BufferLineHint                      = { fg = p.nord4,  bg = p.nord3                      },
                        BufferLineHintVisible               = { fg = p.nord6,  bg = p.nord3light                 },
                        BufferLineHintSelected              = { fg = p.nord1,  bg = p.nord9                      },
                        BufferLineGroupSeparator            = { fg = p.nord1,  bg = p.nord3                      },
                        BufferLineGroupLabel                = { fg = p.nord1,  bg = p.nord8                      },
                        BufferLineNumbers                   = { fg = p.nord4,  bg = p.nord3                      },
                        BufferLineNumbersVisible            = { fg = p.nord6,  bg = p.nord3light                 },
                        BufferLineNumbersSelected           = { fg = p.nord1,  bg = p.nord9                      },
                        BufferLineBuffer                    = { fg = p.nord4,  bg = p.nord3                      },
                        BufferLineBufferVisible             = { fg = p.nord6,  bg = p.nord3light                 },
                        BufferLineBufferSelected            = { fg = p.nord1,  bg = p.nord9                      },
                        BufferLineTab                       = { fg = p.nord4,  bg = p.nord3                      },
                        BufferLineTabSelected               = { fg = p.nord1,  bg = p.nord9                      },
                        BufferLineTabClose                  = { fg = p.nord4,  bg = p.nord3                      },
                        BufferLineCloseButton               = { fg = p.nord4,  bg = p.nord3                      },
                        BufferLineCloseButtonVisible        = { fg = p.nord6,  bg = p.nord3light                 },
                        BufferLineCloseButtonSelected       = { fg = p.nord1,  bg = p.nord9                      },
                        BufferLineSeparator                 = { fg = p.nord1,  bg = p.nord3                      },
                        BufferLineSeparatorVisible          = { fg = p.nord1,  bg = p.nord3light                 },
                        BufferLineSeparatorSelected         = { fg = p.nord1,  bg = p.nord9                      },
                        BufferLineDuplicate                 = { fg = p.nord6,  bg = p.nord3,      style = "bold" },
                        BufferLineDuplicateVisible          = { fg = p.nord6,  bg = p.nord3light, style = "bold" },
                        BufferLineDuplicateSelected         = { fg = p.nord6,  bg = p.nord9,      style = "bold" },
                        BufferLineModified                  = { fg = p.nord13, bg = p.nord3                      },
                        BufferLineModifiedVisible           = { fg = p.nord13, bg = p.nord3light                 },
                        BufferLineModifiedSelected          = { fg = p.nord13, bg = p.nord9                      },
                        BufferLinePick                      = { fg = p.nord12, bg = p.nord0                      },
                        BufferLinePickVisible               = { fg = p.nord12, bg = p.nord0                      },
                        BufferLinePickSelected              = { fg = p.nord12, bg = p.nord0                      },
                        BufferLineIndicatorSelected         = { fg = p.nord1,  bg = p.nord9                      },
                        BufferLineBackground                = { fg = p.nord4,  bg = p.nord3                      },
                        BufferLineFill                      = { fg = p.nord6,  bg = p.nord1,      style = "bold" },
                    },
                    cmp = {
                        CmpGhostText          = { fg = p.nord3light, bg = "none", style = "bold"          },

                        CmpItemKind           = { fg = p.nord4,      bg = "none"                          },
                        CmpItemMenu           = { fg = p.nord3light, bg = "none"                          },
                        CmpItemAbbr           = { fg = p.nord4,      bg = "none"                          },
                        CmpItemAbbrDeprecated = { fg = p.nord12,     bg = "none", style = "strikethrough" },
                        CmpItemAbbrMatch      = { fg = p.nord10,     bg = "none", style = "bold"          },
                        CmpItemAbbrMatchFuzzy = { link = "CmpItemAbbrMatch"                               },

                        CmpItemKindSnippet    = { fg = p.nord14,     bg = "none"                          },

                        CmpItemKindFile       = { fg = p.nord13,     bg = "none"                          },
                        CmpItemKindFolder     = { link = "CmpItemKindFile"                                },
                    },
                    dressing = {
                        FloatTitle = { link = "NormalFloat" },
                    },
                    gitsigns = {
                        GitSignsCurrentLineBlame = { fg = p.nord15, bg = "none",      style = "italic,bold" },
                        GitSignsAdd              = { fg = p.nord14, bg = "none"                             },
                        GitSignsAddNr            = { fg = p.nord14, bg = p.nord1                            },
                        GitSignsAddLn            = { fg = "none",   bg = "#3e4748"                          },
                        GitSignsChange           = { fg = p.nord13, bg = "none"                             },
                        GitSignsChangeNr         = { fg = p.nord13, bg = p.nord1                            },
                        GitSignsChangeLn         = { fg = "none",   bg = "#4d4a48"                          },
                        GitSignsDelete           = { fg = p.nord11, bg = "none"                             },
                        GitSignsDeleteNr         = { fg = p.nord11, bg = p.nord1                            },
                        GitSignsDeleteLn         = { fg = "none",   bg = "#443844"                          },
                        GitSignsAddInline        = { fg = "none",   bg = p.nord14dark                       },
                        GitSignsChangeInline     = { fg = "none",   bg = p.nord13dark                       },
                        GitSignsDeleteInline     = { fg = "none",   bg = p.nord11dark                       },
                    },
                    indentline = {
                        IndentBlanklineContextChar        = { fg = p.nord7, bg = "none" },
                        IndentBlanklineContextStart       = { fg = p.nord7, bg = "none" },
                        IndentBlanklineSpaceCharBlankline = { fg = p.nord1, bg = "none" },
                        IndentBlanklineSpaceChar          = { fg = p.nord1, bg = "none" },
                        IndentBlanklineChar               = { fg = p.nord1, bg = "none" },
                    },
                    hlslens = {
                        HlSearchNear     = { link = "IncSearch"                             },
                        HlSearchLens     = { link = "Search"                                },
                        HlSearchLensNear = { fg = p.nord10, bg = p.nord0, style = "reverse" },
                        HlSearchFloat    = { link = "IncSearch"                             },
                    },
                    hop = {
                        HopNextKey   = { fg = p.nord8, bg = "none", style = "bold" },
                        HopNextKey1  = { fg = p.nord8, bg = "none"                 },
                        HopNextKey2  = { fg = p.nord4, bg = "none"                 },
                        HopUnmatched = { fg = p.nord3, bg = "none"                 },
                    },
                    lsp = {
                        -- Neovim Diagnostics API
                        DiagnosticError             = { fg = p.nord11,     bg = "none"                        },
                        DiagnosticWarn              = { fg = p.nord13,     bg = "none"                        },
                        DiagnosticInfo              = { fg = p.nord8,      bg = "none"                        },
                        DiagnosticHint              = { fg = p.nord10,     bg = "none"                        },
                        -- Neovim DocumentHighlight
                        LspReferenceText            = { fg = "none",       bg = p.nord3                       },
                        LspReferenceRead            = { fg = "none",       bg = p.nord3                       },
                        LspReferenceWrite           = { fg = "none",       bg = p.nord3                       },
                        -- Neovim lspconfig
                        LspCodeLens                 = { fg = p.nord3light, bg = "none"                        },
                        DiagnosticSignError         = { link = "DiagnosticError"                              },
                        DiagnosticSignWarn          = { link = "DiagnosticWarn"                               },
                        DiagnosticSignInfo          = { link = "DiagnosticInfo"                               },
                        DiagnosticSignHint          = { link = "DiagnosticHint"                               },
                        DiagnosticDefaultError      = { link = "DiagnosticError"                              },
                        DiagnosticDefaultWarn       = { link = "DiagnosticWarn"                               },
                        DiagnosticDefaultInfo       = { link = "DiagnosticInfo"                               },
                        DiagnosticDefaultHint       = { link = "DiagnosticHint"                               },
                        DiagnosticUnderlineError    = { fg = p.nord11,     bg = "none", style = "undercurl"   },
                        DiagnosticUnderlineWarn     = { fg = p.nord13,     bg = "none", style = "undercurl"   },
                        DiagnosticUnderlineInfo     = { fg = p.nord8,      bg = "none", style = "undercurl"   },
                        DiagnosticUnderlineHint     = { fg = p.nord10,     bg = "none", style = "undercurl"   },
                        DiagnosticVirtualTextError  = { fg = p.nord11,     bg = "none", style = "italic,bold" },
                        DiagnosticVirtualTextWarn   = { fg = p.nord13,     bg = "none", style = "italic,bold" },
                        DiagnosticVirtualTextInfo   = { fg = p.nord8,      bg = "none", style = "italic,bold" },
                        DiagnosticVirtualTextHint   = { fg = p.nord10,     bg = "none", style = "italic,bold" },
                        -- Neovim LspSignatureHelp
                        LspSignatureActiveParameter = { fg = p.nord8,      bg = "none"                        },
                    },
                    lualine = {
                        lualineDiagnosticError = { fg = p.nord11, bg = p.nord1 },
                        lualineDiagnosticWarn  = { fg = p.nord13, bg = p.nord1 },
                        lualineDiagnosticInfo  = { fg = p.nord8,  bg = p.nord1 },
                        lualineDiagnosticHint  = { fg = p.nord10, bg = p.nord1 },
                    },
                    mini_cursorword = {
                        MiniCursorword        = { link = "Visual"                               },
                        MiniCursorwordCurrent = { fg = "none", bg = "none", style = "nocombine" },
                    },
                    notify = {
                        NotifyERRORTitle  = { fg = p.nord11, bg = p.nord0darker },
                        NotifyWARNTitle   = { fg = p.nord13, bg = p.nord0darker },
                        NotifyINFOTitle   = { fg = p.nord8,  bg = p.nord0darker },
                        NotifyDEBUGTitle  = { fg = p.nord11, bg = p.nord0darker },
                        NotifyTRACETitle  = { fg = p.nord10, bg = p.nord0darker },
                        NotifyERRORIcon   = { link = "NotifyERRORTitle"         },
                        NotifyWARNIcon    = { link = "NotifyWARNTitle"          },
                        NotifyINFOIcon    = { link = "NotifyINFOTitle"          },
                        NotifyDEBUGIcon   = { link = "NotifyDEBUGTitle"         },
                        NotifyTRACEIcon   = { link = "NotifyTRACETitle"         },
                        NotifyERRORBorder = { link = "NotifyERRORTitle"         },
                        NotifyWARNBorder  = { link = "NotifyWARNTitle"          },
                        NotifyINFOBorder  = { link = "NotifyINFOTitle"          },
                        NotifyDEBUGBorder = { link = "NotifyDEBUGTitle"         },
                        NotifyTRACEBorder = { link = "NotifyTRACETitle"         },
                        NotifyERRORBody   = { link = "Pmenu"                    },
                        NotifyWARNBody    = { link = "Pmenu"                    },
                        NotifyINFOBody    = { link = "Pmenu"                    },
                        NotifyDEBUGBody   = { link = "Pmenu"                    },
                        NotifyTRACEBody   = { link = "Pmenu"                    },
                    },
                    nvim_tree = {
                        NvimTreeNormalNC          = { link = "NormalNC"                               },
                        NvimTreeSignColumn        = { fg = p.nord1,  bg = "none"                      },
                        NvimTreeRootFolder        = { fg = p.nord8,  bg = "none", style = "bold"      },
                        NvimTreeFolderIcon        = { fg = p.nord4,  bg = "none"                      },
                        NvimTreeFolderName        = { fg = p.nord10, bg = "none"                      },
                        NvimTreeEmptyFolderName   = { fg = p.nord3,  bg = "none"                      },
                        NvimTreeOpenedFolderName  = { fg = p.nord9,  bg = "none"                      },
                        NvimTreeIndentMarker      = { fg = p.nord3,  bg = "none"                      },
                        NvimTreeOpenedFile        = { fg = p.nord9,  bg = "none"                      },
                        NvimTreeExecFile          = { fg = p.nord8,  bg = "none"                      },
                        NvimTreeSpecialFile       = { fg = p.nord9,  bg = "none", style = "underline" },
                        NvimTreeGitNew            = { fg = p.nord14, bg = "none"                      },
                        NvimTreeGitDirty          = { fg = p.nord13, bg = "none"                      },
                        NvimTreeImageFile         = { fg = p.nord15, bg = "none"                      },
                        NvimTreeWindowPicker      = { fg = p.nord1,  bg = p.nord8                     },
                        LspDiagnosticsError       = { link = "DiagnosticError"                        },
                        LspDiagnosticsWarning     = { link = "DiagnosticWarn"                         },
                        LspDiagnosticsHint        = { link = "DiagnosticInfo"                         },
                        LspDiagnosticsInformation = { link = "DiagnosticHint"                         },
                    },
                    quick_scope = {
                        QuickScopePrimary   = { fg = p.nord13, bg = p.nord0, style = "underline" },
                        QuickScopeSecondary = { fg = p.nord15, bg = p.nord0, style = "bold"      },
                    },
                    scrollbar = {
                        ScrollBarHandle = { fg = "none", bg = p.nord3light },
                    },
                    telescope = {
                        TelescopePromptPrefix   = { fg = p.nord4, bg = "none",       style = "bold" },
                        TelescopePromptCounter  = { fg = p.nord0, bg = "none",       style = "bold" },

                        TelescopeNormal         = { fg = p.nord4, bg = p.nord0darker                },
                        TelescopeResultsNormal  = { fg = p.nord4, bg = p.nord0                      },
                        TelescopePreviewNormal  = { fg = p.nord4, bg = p.nord0                      },
                        TelescopePromptNormal   = { fg = p.nord6, bg = p.nord2                      },

                        TelescopeResultsTitle   = { fg = p.nord8, bg = p.nord2,      style = "bold" },
                        TelescopePreviewTitle   = { fg = p.nord9, bg = p.nord2,      style = "bold" },
                        TelescopePromptTitle    = { fg = p.nord4, bg = p.nord2,      style = "bold" },

                        TelescopeResultsBorder  = { fg = p.nord2, bg = p.nord0                      },
                        TelescopePreviewBorder  = { fg = p.nord2, bg = p.nord0                      },
                        TelescopePromptBorder   = { fg = p.nord2, bg = p.nord2                      },

                        TelescopeMultiSelection = { fg = p.nord6, bg = p.nord2                      },
                        TelescopeMultiIcon      = { fg = p.nord6, bg = p.nord2                      },
                        TelescopeSelectionCaret = { fg = p.nord8, bg = p.nord1                      },
                        TelescopeSelection      = { link = "TelescopeSelectionCaret"                },
                        TelescopeMatching       = { fg = p.nord6, bg = "none"                       },
                    },
                    todo = {
                        TodoBgFIX    = { fg = p.nord6,  bg = p.nord11, style = "bold" },
                        TodoFgFIX    = { link = "DiagnosticError"                     },
                        TodoSignFIX  = { link = "DiagnosticError"                     },
                        TodoBgNOTE   = { fg = p.nord6,  bg = p.nord10, style = "bold" },
                        TodoFgNOTE   = { link = "DiagnosticHint"                      },
                        TodoSignNOTE = { link = "DiagnosticHint"                      },
                        TodoBgWARN   = { fg = p.nord6,  bg = p.nord13, style = "bold" },
                        TodoFgWARN   = { link = "DiagnosticWarn"                      },
                        TodoSignWARN = { link = "DiagnosticWarn"                      },
                        TodoBgPERF   = { fg = p.nord6,  bg = p.nord14, style = "bold" },
                        TodoFgPERF   = { fg = p.nord14, bg = "none"                   },
                        TodoSignPERF = { fg = p.nord14, bg = "none"                   },
                        TodoBgTODO   = { fg = p.nord6,  bg = p.nord8,  style = "bold" },
                        TodoFgTODO   = { link = "DiagnosticInfo"                      },
                        TodoSignTODO = { link = "DiagnosticInfo"                      },
                        TodoBgHACK   = { fg = p.nord6,  bg = p.nord13, style = "bold" },
                        TodoFgHACK   = { link = "DiagnosticWarn"                      },
                        TodoSignHACK = { link = "DiagnosticWarn"                      },
                    },
                    ts_rainbow = {
                        rainbowcol1 = { fg = p.nord10, bg = "none" },
                        rainbowcol2 = { fg = p.nord11, bg = "none" },
                        rainbowcol3 = { fg = p.nord13, bg = "none" },
                        rainbowcol4 = { fg = p.nord14, bg = "none" },
                        rainbowcol5 = { fg = p.nord15, bg = "none" },
                        rainbowcol6 = { fg = p.nord7,  bg = "none" },
                        rainbowcol7 = { fg = p.nord4,  bg = "none" },
                    },
                    which_key = {
                        WhichKey          = { fg = p.nord4,  bg = "none", style = "bold" },
                        WhichKeyGroup     = { fg = p.nord10, bg = "none", style = "bold" },
                        WhichKeyDesc      = { fg = p.nord9,  bg = "none"                 },
                        WhichKeySeperator = { fg = p.nord3,  bg = "none"                 },
                        WhichKeyValue     = { link = "Comment"                           },
                        WhichKeyFloat     = { link = "NormalFloat"                       },
                    },
                },
            },
            dracula = {
                plugins = {
                    mini_cursorword = {
                        MiniCursorword        = { link = "Visual"                               },
                        MiniCursorwordCurrent = { fg = "none", bg = "none", style = "nocombine" },
                    },
                    notify = {
                        NotifyERRORBorder = { link = "DiagnosticError" },
                        NotifyWARNBorder  = { link = "DiagnosticWarn"  },
                        NotifyINFOBorder  = { link = "DiagnosticInfo"  },
                        NotifyDEBUGBorder = { link = "DiagnosticError" },
                        NotifyTRACEBorder = { link = "DiagnosticHint"  },
                        NotifyERRORIcon   = { link = "DiagnosticError" },
                        NotifyWARNIcon    = { link = "DiagnosticWarn"  },
                        NotifyINFOIcon    = { link = "DiagnosticInfo"  },
                        NotifyDEBUGIcon   = { link = "DiagnosticError" },
                        NotifyTRACEIcon   = { link = "DiagnosticHint"  },
                        NotifyERRORTitle  = { link = "DiagnosticError" },
                        NotifyWARNTitle   = { link = "DiagnosticWarn"  },
                        NotifyINFOTitle   = { link = "DiagnosticInfo"  },
                        NotifyDEBUGTitle  = { link = "DiagnosticError" },
                        NotifyTRACETitle  = { link = "DiagnosticHint"  },
                        NotifyERRORBody   = { link = "Normal"          },
                        NotifyWARNBody    = { link = "Normal"          },
                        NotifyINFOBody    = { link = "Normal"          },
                        NotifyDEBUGBody   = { link = "Normal"          },
                        NotifyTRACEBody   = { link = "Normal"          },
                    },
                    ts_rainbow = {
                        rainbowcol1 = { fg = p.draculaComment, bg = "none" },
                        rainbowcol2 = { fg = p.draculaFg,      bg = "none" },
                        rainbowcol3 = { fg = p.draculaPink,    bg = "none" },
                        rainbowcol4 = { fg = p.draculaCyan,    bg = "none" },
                        rainbowcol5 = { fg = p.draculaYellow,  bg = "none" },
                        rainbowcol6 = { fg = p.draculaPurple,  bg = "none" },
                        rainbowcol7 = { fg = p.draculaGreen,   bg = "none" },
                    },
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
