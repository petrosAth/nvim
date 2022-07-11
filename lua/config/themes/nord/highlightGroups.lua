local p = require("config.themes.nord.palette")
local highlightGroups = {}

highlightGroups.editor = {
    -- Editor
    Normal           = { fg = p.nord4,       bg = p.nord0                                          },
    NormalNC         = { fg = p.nord4,       bg = p.nord0dark                                      },
    ColorColumn      = { fg = p.none,        bg = p.nord0dark                                      },
    Cursor           = {                                        style = "reverse"                  },
    lCursor          = {                                        style = "reverse"                  },
    CursorIM         = {                                        style = "reverse"                  },
    TermCursor       = {                                        style = "reverse"                  },
    TermCursorNC     = {                                        style = "reverse"                  },
    CursorLine       = { fg = p.none,        bg = p.nord1dark                                      },
    CursorColumn     = { link = "CursorLine"                                                       },
    CursorLineSign   = { link = "SignColumn"                                                       },
    CursorLineFold   = { link = "FoldColumn"                                                       },
    LineNrAbove      = { fg = p.nord3,       bg = p.none                                           },
    LineNr           = { fg = p.nord4,       bg = p.none                                           },
    LineNrBelow      = { fg = p.nord3,       bg = p.none                                           },
    MatchParen       = { fg = p.nord8,       bg = p.nord3                                          },
    NonText          = { fg = p.nord2,       bg = p.none                                           },
    Conceal          = { fg = p.none,        bg = p.none                                           },
    Whitespace       = { fg = p.nord2,       bg = p.none                                           },
    Pmenu            = { fg = p.nord4,       bg = p.nord0darker                                    },
    PmenuSel         = { fg = p.nord8,       bg = p.nord3                                          },
    PmenuSbar        = { fg = p.nord4,       bg = p.nord1dark                                      },
    PmenuThumb       = { fg = p.nord8,       bg = p.nord2                                          },
    SpecialKey       = { fg = p.nord3,       bg = p.none                                           },
    SpellBad         = { fg = p.nord11,      bg = p.none,       style = "undercurl", sp = p.nord11 },
    SpellCap         = { fg = p.nord13,      bg = p.none,       style = "undercurl", sp = p.nord13 },
    SpellLocal       = { fg = p.nord5,       bg = p.none,       style = "undercurl", sp = p.nord5  },
    SpellRare        = { fg = p.nord6,       bg = p.none,       style = "undercurl", sp = p.nord6  },
    Visual           = { fg = p.none,        bg = p.nord2                                          },
    VisualNOS        = { fg = p.none,        bg = p.nord2                                          },
    -- Gutter
    CursorLineNr     = { fg = p.nord4,       bg = p.nord1dark                                      },
    Folded           = { fg = p.nord3,       bg = p.none                                           },
    FoldColumn       = { fg = p.nord3,       bg = p.none                                           },
    SignColumn       = { fg = p.nord1,       bg = p.none                                           },
    -- Navigation
    Directory        = { fg = p.nord8,       bg = p.none                                           },
    -- Prompt/Status
    EndOfBuffer      = { fg = p.nord1,       bg = p.none                                           },
    ErrorMsg         = { fg = p.nord4,       bg = p.nord11                                         },
    ModeMsg          = { fg = p.nord4,       bg = p.none                                           },
    MoreMsg          = { fg = p.nord8,       bg = p.none                                           },
    MsgArea          = { link = "Normal"                                                           },
    MsgSeparator     = { link = "StatusLine"                                                       },
    Question         = { fg = p.nord4,       bg = p.none                                           },
    StatusLine       = { fg = p.nord8,       bg = p.nord1                                          },
    StatusLineNC     = { fg = p.nord4,       bg = p.nord1                                          },
    StatusLineTerm   = { fg = p.nord8,       bg = p.nord1                                          },
    StatusLineTermNC = { fg = p.nord4,       bg = p.nord1                                          },
    WarningMsg       = { fg = p.nord13,      bg = p.nord0,      style = "reverse"                  },
    WildMenu         = { fg = p.nord1,       bg = p.nord8                                          },
    NormalFloat      = { fg = p.nord4,       bg = p.nord0darker                                    },
    FloatBorder      = { fg = p.nord0darker, bg = p.none,       style = "reverse"                  },
    -- Search
    Search           = { fg = p.nord8,       bg = p.nord0,      style = "reverse"                  },
    IncSearch        = { fg = p.nord6,       bg = p.nord10,     style = "underline"                },
    CurSearch        = { fg = p.nord6,       bg = p.nord10,     style = "underline"                },
    Substitute       = { fg = p.nord6,       bg = p.nord0,      style = "reverse"                  },
    -- Tabs
    TabLine          = { fg = p.nord6,       bg = p.nord3                                          },
    TabLineFill      = { fg = p.nord6,       bg = p.nord1                                          },
    TabLineSel       = { fg = p.nord8,       bg = p.nord1                                          },
    -- Window
    Title            = { fg = p.nord4,       bg = p.none                                           },
    VertSplit        = { fg = p.nord0,       bg = p.nord1                                          },
    WinSeparator     = { fg = p.nord0,       bg = p.nord1                                          },
    QuickFixLine     = { fg = p.nord0,       bg = p.nord8                                          },
    -- WinBar        = {                                                                           },
    -- WinBarNC      = {                                                                           },
    -- diff
    DiffText         = { fg = p.nord4,       bg = p.nord10,     style = "bold"                     },
    DiffAdd          = { fg = p.none,        bg = p.nord14dark                                     },
    DiffChange       = { fg = p.none,        bg = p.nord13dark                                     },
    DiffDelete       = { fg = p.none,        bg = p.nord11dark                                     },
    -- Yank
    Yank             = { fg = p.nord6,       bg = p.nord10                                         },
}

highlightGroups.syntax = {
    Comment        = { fg = p.nord3light,                                       },

    Constant       = { fg = p.nord6                                             },
    String         = { fg = p.nord14,                  style = "italic"         },
    Character      = { fg = p.nord14                                            },
    Number         = { fg = p.nord15                                            },
    Boolean        = { fg = p.nord9,                   style = "bold"           },
    Float          = { fg = p.nord15                                            },

    Identifier     = { fg = p.nord4,                   style = p.none           },
    Variable       = { link = "Identifier"                                      },
    Function       = { fg = p.nord8,                   style = "italic"         },

    Statement      = { fg = p.nord9                                             },
    Conditional    = { fg = p.nord9,                   style = "italic"         },
    Repeat         = { fg = p.nord9                                             },
    Label          = { fg = p.nord9                                             },
    Operator       = { fg = p.nord9,                   style = p.none           },
    Keyword        = { fg = p.nord9,                   style = "italic"         },
    Exception      = { fg = p.nord9                                             },

    PreProc        = { fg = p.nord9,                   style = p.none           },
    Include        = { fg = p.nord9                                             },
    Define         = { fg = p.nord9                                             },
    Macro          = { link = "Define"                                          },
    PreCondit      = { link = "PreProc"                                         },

    Type           = { fg = p.nord9,                   style = p.none           },
    StorageClass   = { fg = p.nord9                                             },
    Structure      = { fg = p.nord9                                             },
    Typedef        = { fg = p.nord9                                             },

    Special        = { fg = p.nord4                                             },
    SpecialChar    = { fg = p.nord13                                            },
    Tag            = { fg = p.nord4                                             },
    Delimiter      = { fg = p.nord6                                             },
    SpecialComment = { fg = p.nord8,                   style = "italic"         },
    Debug          = { fg = p.nord11                                            },

    Underlined     = { fg = p.nord14,                  style = "underline"      },
    Ignore         = { fg = p.nord1                                             },
    Error          = { fg = p.nord11,     bg = p.none, style = "bold,underline" },
    Todo           = { fg = p.nord13,     bg = p.none                           },

    Decorator      = { fg = p.nord12                                            },
    Annotation     = { link = "Decorator"                                       },
}

highlightGroups.lsp = {
    DiagnosticError             = { fg = p.nord11, bg = p.none                                      },
    DiagnosticWarn              = { fg = p.nord13, bg = p.none                                      },
    DiagnosticInfo              = { fg = p.nord8,  bg = p.none                                      },
    DiagnosticHint              = { fg = p.nord10, bg = p.none                                      },
    DiagnosticSignError         = { link = "DiagnosticError"                                        },
    DiagnosticSignWarn          = { link = "DiagnosticWarn"                                         },
    DiagnosticSignInfo          = { link = "DiagnosticInfo"                                         },
    DiagnosticSignHint          = { link = "DiagnosticHint"                                         },
    DiagnosticDefaultError      = { link = "DiagnosticError"                                        },
    DiagnosticDefaultWarn       = { link = "DiagnosticWarn"                                         },
    DiagnosticDefaultInfo       = { link = "DiagnosticInfo"                                         },
    DiagnosticDefaultHint       = { link = "DiagnosticHint"                                         },
    DiagnosticFloatingWarn      = { link = "DiagnosticError"                                        },
    DiagnosticFloatingError     = { link = "DiagnosticWarn"                                         },
    DiagnosticFloatingInfo      = { link = "DiagnosticInfo"                                         },
    DiagnosticFloatingHint      = { link = "DiagnosticHint"                                         },
    DiagnosticUnderlineError    = { fg = p.nord11, bg = p.none, style = "undercurl",  sp = p.nord11 },
    DiagnosticUnderlineWarn     = { fg = p.nord13, bg = p.none, style = "undercurl",  sp = p.nord13 },
    DiagnosticUnderlineInfo     = { fg = p.nord8,  bg = p.none, style = "undercurl",  sp = p.nord8  },
    DiagnosticUnderlineHint     = { fg = p.nord10, bg = p.none, style = "undercurl",  sp = p.nord10 },
    DiagnosticVirtualTextError  = { fg = p.nord11, bg = p.none, style = "bold,italic"               },
    DiagnosticVirtualTextWarn   = { fg = p.nord13, bg = p.none, style = "bold,italic"               },
    DiagnosticVirtualTextInfo   = { fg = p.nord8,  bg = p.none, style = "bold,italic"               },
    DiagnosticVirtualTextHint   = { fg = p.nord10, bg = p.none, style = "bold,italic"               },
    -- DocumentHighlight
    LspReferenceText            = { fg = p.none,   bg = p.nord3                                     },
    LspReferenceRead            = { fg = p.none,   bg = p.nord3                                     },
    LspReferenceWrite           = { fg = p.none,   bg = p.nord3                                     },
    -- Neovim LspSignatureHelp
    LspSignatureActiveParameter = { fg = p.nord8,  bg = p.none                                      },
}

highlightGroups.plugins = {
    -- alpha-nvim
    AlphaButtons         = { fg = p.nord4,      bg = p.none },
    AlphaButtonShortcuts = { fg = p.nord8,      bg = p.none },
    AlphaHeader          = { fg = p.nord9,      bg = p.none },
    AlphaFooter          = { fg = p.nord3light, bg = p.none },

    -- bufferline.nvim
    BufferLineDiagnostic                = { fg = p.nord4dark, bg = p.nord2                      },
    BufferLineDiagnosticVisible         = { fg = p.nord4,     bg = p.nord3                      },
    BufferLineDiagnosticSelected        = { fg = p.nord6,     bg = p.nord3light                 },
    BufferLineErrorDiagnostic           = { fg = p.nord11,    bg = p.nord2                      },
    BufferLineErrorDiagnosticVisible    = { fg = p.nord11,    bg = p.nord3                      },
    BufferLineErrorDiagnosticSelected   = { fg = p.nord11,    bg = p.nord3light                 },
    BufferLineError                     = { fg = p.nord4dark, bg = p.nord2                      },
    BufferLineErrorVisible              = { fg = p.nord4,     bg = p.nord3                      },
    BufferLineErrorSelected             = { fg = p.nord6,     bg = p.nord3light                 },
    BufferLineWarningDiagnostic         = { fg = p.nord13,    bg = p.nord2                      },
    BufferLineWarningDiagnosticVisible  = { fg = p.nord13,    bg = p.nord3                      },
    BufferLineWarningDiagnosticSelected = { fg = p.nord13,    bg = p.nord3light                 },
    BufferLineWarning                   = { fg = p.nord4dark, bg = p.nord2                      },
    BufferLineWarningVisible            = { fg = p.nord4,     bg = p.nord3                      },
    BufferLineWarningSelected           = { fg = p.nord6,     bg = p.nord3light                 },
    BufferLineInfoDiagnostic            = { fg = p.nord8,     bg = p.nord2                      },
    BufferLineInfoDiagnosticVisible     = { fg = p.nord8,     bg = p.nord3                      },
    BufferLineInfoDiagnosticSelected    = { fg = p.nord8,     bg = p.nord3light                 },
    BufferLineInfo                      = { fg = p.nord4dark, bg = p.nord2                      },
    BufferLineInfoVisible               = { fg = p.nord4,     bg = p.nord3                      },
    BufferLineInfoSelected              = { fg = p.nord6,     bg = p.nord3light                 },
    BufferLineHintDiagnostic            = { fg = p.nord10,    bg = p.nord2                      },
    BufferLineHintDiagnosticVisible     = { fg = p.nord10,    bg = p.nord3                      },
    BufferLineHintDiagnosticSelected    = { fg = p.nord10,    bg = p.nord3light                 },
    BufferLineHint                      = { fg = p.nord4dark, bg = p.nord2                      },
    BufferLineHintVisible               = { fg = p.nord4,     bg = p.nord3                      },
    BufferLineHintSelected              = { fg = p.nord6,     bg = p.nord3light                 },
    BufferLineGroupSeparator            = { fg = p.nord1,     bg = p.nord3                      },
    BufferLineGroupLabel                = { fg = p.nord1,     bg = p.nord8                      },
    BufferLineNumbers                   = { fg = p.nord4dark, bg = p.nord2                      },
    BufferLineNumbersVisible            = { fg = p.nord1,     bg = p.nord4dark                  },
    BufferLineNumbersSelected           = { fg = p.nord1,     bg = p.nord8                      },
    BufferLineBuffer                    = { fg = p.nord4dark, bg = p.nord2                      },
    BufferLineBufferVisible             = { fg = p.nord4,     bg = p.nord3                      },
    BufferLineBufferSelected            = { fg = p.nord6,     bg = p.nord3light                 },
    BufferLineTab                       = { fg = p.nord4dark, bg = p.nord2                      },
    BufferLineTabSelected               = { fg = p.nord6,     bg = p.nord3light                 },
    BufferLineTabClose                  = { fg = p.nord4dark, bg = p.nord2                      },
    BufferLineCloseButton               = { fg = p.nord4dark, bg = p.nord2                      },
    BufferLineCloseButtonVisible        = { fg = p.nord4,     bg = p.nord3                      },
    BufferLineCloseButtonSelected       = { fg = p.nord6,     bg = p.nord3light                 },
    BufferLineSeparator                 = { fg = p.nord1,     bg = p.nord1                      },
    BufferLineSeparatorVisible          = { fg = p.nord1,     bg = p.nord1                      },
    BufferLineSeparatorSelected         = { fg = p.nord1,     bg = p.nord1                      },
    BufferLineDuplicate                 = { fg = p.nord6,     bg = p.nord2,      style = "bold" },
    BufferLineDuplicateVisible          = { fg = p.nord6,     bg = p.nord3,      style = "bold" },
    BufferLineDuplicateSelected         = { fg = p.nord6,     bg = p.nord3light, style = "bold" },
    BufferLineModified                  = { fg = p.nord13,    bg = p.nord2                      },
    BufferLineModifiedVisible           = { fg = p.nord13,    bg = p.nord3                      },
    BufferLineModifiedSelected          = { fg = p.nord13,    bg = p.nord3light                 },
    BufferLinePick                      = { fg = p.nord12,    bg = p.none                       },
    BufferLinePickVisible               = { fg = p.nord12,    bg = p.none                       },
    BufferLinePickSelected              = { fg = p.nord12,    bg = p.none                       },
    BufferLineIndicatorVisible          = { fg = p.nord1,     bg = p.nord4dark                  },
    BufferLineIndicatorSelected         = { fg = p.nord8,     bg = p.nord1                      },
    BufferLineBackground                = { fg = p.nord4dark, bg = p.nord2                      },
    BufferLineFill                      = { fg = p.nord6,     bg = p.nord1,      style = "bold" },

    -- nvim-cmp
    CmpGhostText                    = { fg = p.nord3light, bg = p.none, style = "bold"          },

    CmpItemMenuDefault              = { fg = p.nord3light, bg = p.none                          },

    CmpItemAbbrDefault              = { fg = p.nord4,      bg = p.none                          },
    CmpItemAbbrDeprecatedDefault    = { fg = p.nord12,     bg = p.none, style = "strikethrough" },
    CmpItemAbbrMatchDefault         = { fg = p.nord10,     bg = p.none, style = "bold"          },
    CmpItemAbbrMatchFuzzyDefault    = { link = "CmpItemAbbrMatch"                               },

    CmpItemKindTypeParameterDefault = { link = "TSParameter"                                    },
    CmpItemKindConstructorDefault   = { link = "TSConstructor"                                  },
    CmpItemKindEnumDefault          = { link = "TSStructure"                                    },
    CmpItemKindEnumMemberDefault    = { link = "TSStructure"                                    },
    CmpItemKindReferenceDefault     = { link = "TSParameterReference"                           },
    CmpItemKindInterfaceDefault     = { link = "StorageClass"                                   },
    CmpItemKindClassDefault         = { link = "StorageClass"                                   },
    CmpItemKindVariableDefault      = { link = "TSVariable"                                     },
    CmpItemKindPropertyDefault      = { link = "TSProperty"                                     },
    CmpItemKindOperatorDefault      = { link = "TSOperator"                                     },
    CmpItemKindFunctionDefault      = { link = "TSFunction"                                     },
    CmpItemKindConstantDefault      = { link = "TSConstant"                                     },
    CmpItemKindSnippetDefault       = { fg = p.nord14,     bg = p.none                          },
    CmpItemKindKeywordDefault       = { link = "TSKeyword"                                      },
    CmpItemKindStructDefault        = { link = "TSStructure"                                    },
    CmpItemKindModuleDefault        = { link = "TSNamespace"                                    },
    CmpItemKindMethodDefault        = { link = "TSMethod"                                       },
    CmpItemKindFolderDefault        = { link = "Directory"                                      },
    CmpItemKindFileDefault          = { link = "Directory"                                      },
    CmpItemKindValueDefault         = { link = "TSKeyword"                                      },
    CmpItemKindFieldDefault         = { link = "TSField"                                        },
    CmpItemKindUnitDefault          = { link = "TSNumber"                                       },
    CmpItemKindTextDefault          = { link = "TSText"                                         },
    CmpItemKindDefault              = { link = "Normal"                                         },

    -- diffview.nvim
    DiffviewVertSplit    = { fg = p.nord1, bg = p.nord13   },
    DiffviewWinSeparator = { link = "DiffviewVertSplit"    },

    -- gitsigns.nvim
    GitSignsCurrentLineBlame = { fg = p.nord15, bg = p.none,        style = "bold,italic" },
    GitSignsAdd              = { fg = p.nord14, bg = p.none                               },
    GitSignsAddNr            = { fg = p.nord14, bg = p.nord1                              },
    GitSignsAddLn            = { fg = p.none,   bg = p.nord14darker                       },
    GitSignsChange           = { fg = p.nord13, bg = p.none                               },
    GitSignsChangeNr         = { fg = p.nord13, bg = p.nord1                              },
    GitSignsChangeLn         = { fg = p.none,   bg = p.nord13darker                       },
    GitSignsDelete           = { fg = p.nord11, bg = p.none                               },
    GitSignsDeleteNr         = { fg = p.nord11, bg = p.nord1                              },
    GitSignsDeleteLn         = { fg = p.none,   bg = p.nord11darker                       },
    GitSignsAddInline        = { fg = p.none,   bg = p.nord14dark                         },
    GitSignsChangeInline     = { fg = p.none,   bg = p.nord13dark                         },
    GitSignsDeleteInline     = { fg = p.none,   bg = p.nord11dark                         },

    -- incline.nvim
    InclineNormal   = { fg = p.nord5, bg = p.nord3 },
    InclineNormalNC = { link = "InclineNormal"     },

    -- indent-blankline.nvim
    IndentBlanklineContextChar        = { fg = p.nord7, bg = p.none                                    },
    IndentBlanklineContextStart       = { fg = p.none,  bg = p.none, style = "underline", sp = p.nord7 },
    IndentBlanklineSpaceCharBlankline = { fg = p.nord1, bg = p.none                                    },
    IndentBlanklineSpaceChar          = { fg = p.nord1, bg = p.none                                    },
    IndentBlanklineChar               = { fg = p.nord1, bg = p.none                                    },

    -- nvim-hlslens
    HlSearchNear     = { link = "IncSearch"                                },
    HlSearchLensNear = { fg = p.nord4,      bg = p.none, style = "reverse" },
    HlSearchLens     = { fg = p.nord3light, bg = p.none, style = "reverse" },
    HlSearchFloat    = { link = "IncSearch"                                },

    -- hop.nvim
    HopNextKey   = { fg = p.nord8, bg = p.none, style = "bold" },
    HopNextKey1  = { fg = p.nord8, bg = p.none                 },
    HopNextKey2  = { fg = p.nord4, bg = p.none                 },
    HopUnmatched = { fg = p.nord3, bg = p.none                 },

    -- lualine.nvim
    lualineDiagnosticError = { fg = p.nord11, bg = p.nord1  },
    lualineDiagnosticWarn  = { fg = p.nord13, bg = p.nord1  },
    lualineDiagnosticInfo  = { fg = p.nord8,  bg = p.nord1  },
    lualineDiagnosticHint  = { fg = p.nord10, bg = p.nord1  },
    lualineModifiedFile    = { fg = p.nord13, bg = p.nord3  },
    lualineHydraMode       = { fg = p.nord1,  bg = p.nord15 },

    -- mini.nvim
    MiniCursorword        = { link = "Visual" },
    MiniCursorwordCurrent = { style = "bold"  },

    -- nvim-notify
    NotifyERRORTitle  = { link = "DiagnosticError" },
    NotifyWARNTitle   = { link = "DiagnosticWarn"  },
    NotifyINFOTitle   = { link = "DiagnosticInfo"  },
    NotifyDEBUGTitle  = { link = "DiagnosticError" },
    NotifyTRACETitle  = { link = "DiagnosticHint"  },
    NotifyERRORIcon   = { link = "DiagnosticError" },
    NotifyWARNIcon    = { link = "DiagnosticWarn"  },
    NotifyINFOIcon    = { link = "DiagnosticInfo"  },
    NotifyDEBUGIcon   = { link = "DiagnosticError" },
    NotifyTRACEIcon   = { link = "DiagnosticHint"  },
    NotifyERRORBorder = { link = "DiagnosticError" },
    NotifyWARNBorder  = { link = "DiagnosticWarn"  },
    NotifyINFOBorder  = { link = "DiagnosticInfo"  },
    NotifyDEBUGBorder = { link = "DiagnosticError" },
    NotifyTRACEBorder = { link = "DiagnosticHint"  },
    NotifyERRORBody   = { link = "Pmenu"           },
    NotifyWARNBody    = { link = "Pmenu"           },
    NotifyINFOBody    = { link = "Pmenu"           },
    NotifyDEBUGBody   = { link = "Pmenu"           },
    NotifyTRACEBody   = { link = "Pmenu"           },

    -- nvim-tree.lua
    NvimTreeNormalNC          = { link = "NormalNC"                               },
    NvimTreeSignColumn        = { fg = p.nord1,  bg = p.none                      },
    NvimTreeRootFolder        = { fg = p.nord8,  bg = p.none, style = "bold"      },
    NvimTreeFolderIcon        = { fg = p.nord4,  bg = p.none                      },
    NvimTreeFolderName        = { fg = p.nord10, bg = p.none                      },
    NvimTreeEmptyFolderName   = { fg = p.nord3,  bg = p.none                      },
    NvimTreeOpenedFolderName  = { fg = p.nord9,  bg = p.none                      },
    NvimTreeIndentMarker      = { fg = p.nord3,  bg = p.none                      },
    NvimTreeOpenedFile        = { fg = p.nord9,  bg = p.none                      },
    NvimTreeExecFile          = { fg = p.nord8,  bg = p.none                      },
    NvimTreeSpecialFile       = { fg = p.nord9,  bg = p.none, style = "underline" },
    NvimTreeGitNew            = { fg = p.nord14, bg = p.none                      },
    NvimTreeGitDirty          = { fg = p.nord13, bg = p.none                      },
    NvimTreeImageFile         = { fg = p.nord15, bg = p.none                      },
    NvimTreeWindowPicker      = { fg = p.nord1,  bg = p.nord8                     },
    LspDiagnosticsError       = { link = "DiagnosticError"                        },
    LspDiagnosticsWarning     = { link = "DiagnosticWarn"                         },
    LspDiagnosticsHint        = { link = "DiagnosticHint"                         },
    LspDiagnosticsInformation = { link = "DiagnosticInfo"                         },

    -- quickscope.lua
    QuickScopePrimary   = { fg = p.nord13, bg = p.nord0, style = "underline,nocombine" },
    QuickScopeSecondary = { fg = p.nord15, bg = p.nord0, style = "bold,nocombine"      },

    -- nvim-scrollbar
    ScrollBarHandle = { fg = p.none,  bg = p.nord2 },
    ScrollBarError  = { link = "DiagnosticError"   },
    ScrollBarWarn   = { link = "DiagnosticWarn"    },
    ScrollBarInfo   = { link = "DiagnosticInfo"    },
    ScrollBarHint   = { link = "DiagnosticHint"    },
    ScrollBarMisc   = { fg = p.nord4, bg = p.none  },
    ScrollBarSearch = { link = "Search"            },

    -- satellite.nvim
    ScrollView = { link = "Visual"           },
    SearchSV   = { fg = p.nord8, bg = p.none },

    -- telescope.nvim
    TelescopePromptPrefix   = { fg = p.nord4, bg = p.none,       style = "bold" },
    TelescopePromptCounter  = { fg = p.nord0, bg = p.none,       style = "bold" },

    TelescopeNormal         = { fg = p.nord4, bg = p.nord0darker                },
    TelescopeResultsNormal  = { fg = p.nord4, bg = p.none                       },
    TelescopePreviewNormal  = { fg = p.nord4, bg = p.none                       },
    TelescopePromptNormal   = { fg = p.nord6, bg = p.nord2                      },

    TelescopeResultsTitle   = { fg = p.nord8, bg = p.nord2,      style = "bold" },
    TelescopePreviewTitle   = { fg = p.nord9, bg = p.nord2,      style = "bold" },
    TelescopePromptTitle    = { fg = p.nord4, bg = p.nord2,      style = "bold" },

    TelescopeResultsBorder  = { fg = p.nord2, bg = p.none                       },
    TelescopePreviewBorder  = { fg = p.nord2, bg = p.none                       },
    TelescopePromptBorder   = { fg = p.nord2, bg = p.nord2                      },

    TelescopeMultiSelection = { fg = p.nord6, bg = p.nord2                      },
    TelescopeMultiIcon      = { fg = p.nord6, bg = p.nord2                      },
    TelescopeSelectionCaret = { fg = p.nord8, bg = p.nord1                      },
    TelescopeSelection      = { link = "TelescopeSelectionCaret"                },
    TelescopeMatching       = { fg = p.nord6, bg = p.none                       },

    -- todo-comments.nvim
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
    TodoFgPERF   = { fg = p.nord14, bg = p.none                   },
    TodoSignPERF = { fg = p.nord14, bg = p.none                   },
    TodoBgTODO   = { fg = p.nord6,  bg = p.nord8,  style = "bold" },
    TodoFgTODO   = { link = "DiagnosticInfo"                      },
    TodoSignTODO = { link = "DiagnosticInfo"                      },
    TodoBgHACK   = { fg = p.nord6,  bg = p.nord13, style = "bold" },
    TodoFgHACK   = { link = "DiagnosticWarn"                      },
    TodoSignHACK = { link = "DiagnosticWarn"                      },

    -- nvim-ts-rainbow
    rainbowcol1 = { fg = p.nord10, bg = p.none },
    rainbowcol2 = { fg = p.nord11, bg = p.none },
    rainbowcol3 = { fg = p.nord13, bg = p.none },
    rainbowcol4 = { fg = p.nord14, bg = p.none },
    rainbowcol5 = { fg = p.nord15, bg = p.none },
    rainbowcol6 = { fg = p.nord7,  bg = p.none },
    rainbowcol7 = { fg = p.nord4,  bg = p.none },

    -- which-key.nvim
    WhichKey          = { fg = p.nord4,  bg = p.none, style = "bold" },
    WhichKeyGroup     = { fg = p.nord10, bg = p.none, style = "bold" },
    WhichKeyDesc      = { fg = p.nord9,  bg = p.none                 },
    WhichKeySeperator = { fg = p.nord3,  bg = p.none                 },
    WhichKeyValue     = { link = "Comment"                           },
    WhichKeyFloat     = { link = "NormalFloat"                       },
}

highlightGroups.treesitter = {
    TSComment            = { link = "Comment"                            },

    TSConstant           = { link = "Constant"                           },
    TSConstBuiltin       = { link = "Constant"                           },
    TSConstructor        = { fg = p.nord9                                },
    TSConstMacro         = { link = "Constant"                           },
    TSField              = { fg = p.nord4                                },
    TSString             = { link = "String"                             },
    TSStringRegex        = { link = "SpecialChar"                        },
    TSStringEscape       = { fg = p.nord15                               },
    TSCharacter          = { link = "Character"                          },
    TSText               = { fg = p.nord4                                },
    TSTextReference      = { fg = p.nord15                               },
    TSLiteral            = { fg = p.nord4                                },
    TSNumber             = { link = "Number"                             },
    TSBoolean            = { link = "Boolean"                            },
    TSFloat              = { link = "Float"                              },

    TSNamespace          = { fg = p.nord4,              style = "italic" },
    TSVariable           = { link = "Variable"                           },
    TSVariableBuiltin    = { link = "Keyword"                            },
    TSFunction           = { link = "Function"                           },
    TSFuncBuiltin        = { link = "Function"                           },
    TSFuncMacro          = { link = "Function"                           },

    TSConditional        = { link = "Conditional"                        },
    TSRepeat             = { link = "Repeat"                             },
    TSLabel              = { link = "Label"                              },
    TSOperator           = { link = "Operator"                           },
    TSKeyword            = { link = "Keyword"                            },
    TSKeywordFunction    = { link = "Keyword"                            },
    TSKeywordReturn      = { link = "Keyword"                            },
    TSKeywordOperator    = { link = "Keyword"                            },
    TSException          = { link = "Exception"                          },

    TSInclude            = { fg = p.nord9                                },
    TSMethod             = { fg = p.nord7,              style = "italic" },
    TSProperty           = { fg = p.nord10,             style = "italic" },

    TSType               = { link = "Type"                               },
    TSTypeBuiltin        = { link = "Type"                               },
    TSStructure          = { link = "Structure"                          },

    TSPunctDelimiter     = { fg = p.nord8                                },
    TSPunctBracket       = { fg = p.nord8                                },
    TSPunctSpecial       = { fg = p.nord8                                },
    TSTag                = { link = "Tag"                                },
    TSTagDelimiter       = { link = "TSTag"                              },

    TSAnnotation         = { link = "Annotation"                         },
    TSEmphasis           = { style = "Italic"                            },
    TSStrong             = { style = "Bold"                              },
    TSUnderline          = { style = "Underline"                         },
    -- TSError              = { link = "Error"                              },

    TSAttribute          = { fg = p.nord15                               },
    TSParameter          = { fg = p.nord10                               },
    TSParameterReference = { fg = p.nord10                               },
    TSSymbol             = { fg = p.nord15                               },
    TSTitle              = { fg = p.nord9, bg = p.none, style = "bold"   },
    TSURI                = { fg = p.nord10                               },
}

return highlightGroups
