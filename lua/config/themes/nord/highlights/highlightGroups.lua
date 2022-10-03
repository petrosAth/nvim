local p = require("config.themes.nord.palette")
local M = {}

M.editor = {
    -- Editor
    Normal           = { fg = p.nord4,       bg = p.nord0                                          },
    NormalNC         = { fg = p.nord4,       bg = p.nord0dark                                      },
    ColorColumn      = { fg = p.none,        bg = p.nord0dark                                      },
    Cursor           = { reverse = true                                                         },
    lCursor          = { reverse = true                                                         },
    CursorIM         = { reverse = true                                                         },
    TermCursor       = { reverse = true                                                         },
    TermCursorNC     = { reverse = true                                                         },
    CursorLine       = { fg = p.none,        bg = p.nord1dark                                      },
    CursorColumn     = { link = "CursorLine"                                                       },
    CursorLineSign   = { link = "SignColumn"                                                       },
    CursorLineFold   = { link = "FoldColumn"                                                       },
    LineNrAbove      = { fg = p.nord3,       bg = p.none                                           },
    LineNr           = { fg = p.nord4,       bg = p.none                                           },
    LineNrBelow      = { fg = p.nord3,       bg = p.none                                           },
    MatchParen       = { fg = p.nord7,       bg = p.nord3light, bold = true                     },
    NonText          = { fg = p.nord2,       bg = p.none                                           },
    Conceal          = { fg = p.none,        bg = p.none                                           },
    Whitespace       = { fg = p.nord2,       bg = p.none                                           },
    Pmenu            = { fg = p.nord4,       bg = p.nord0darker                                    },
    PmenuSel         = { fg = p.nord8,       bg = p.nord3                                          },
    PmenuSbar        = { fg = p.nord4,       bg = p.nord1dark                                      },
    PmenuThumb       = { fg = p.nord8,       bg = p.nord2                                          },
    SpecialKey       = { fg = p.nord3,       bg = p.none                                           },
    SpellBad         = { fg = p.nord11,      bg = p.none,       undercurl = true, sp = p.nord11 },
    SpellCap         = { fg = p.nord13,      bg = p.none,       undercurl = true, sp = p.nord13 },
    SpellLocal       = { fg = p.nord5,       bg = p.none,       undercurl = true, sp = p.nord5  },
    SpellRare        = { fg = p.nord6,       bg = p.none,       undercurl = true, sp = p.nord6  },
    Visual           = { fg = p.none,        bg = p.nord3                                          },
    VisualNOS        = { fg = p.none,        bg = p.nord3                                          },
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
    ModeMsg          = { fg = p.nord4,       bg = p.none,       bold = true                     },
    MoreMsg          = { fg = p.nord13,      bg = p.none                                           },
    MsgArea          = { link = "Normal"                                                           },
    MsgSeparator     = { link = "StatusLine"                                                       },
    Question         = { fg = p.nord4,       bg = p.none                                           },
    StatusLine       = { fg = p.nord4,       bg = p.nord1                                          },
    StatusLineNC     = { fg = p.nord4dark,       bg = p.nord1                                          },
    StatusLineTerm   = { fg = p.nord4,       bg = p.nord1                                          },
    StatusLineTermNC = { fg = p.nord4dark,       bg = p.nord1                                          },
    WarningMsg       = { fg = p.nord13,      bg = p.nord0,      reverse = true                  },
    WildMenu         = { fg = p.nord1,       bg = p.nord8                                          },
    NormalFloat      = { fg = p.nord4,       bg = p.nord0darker                                    },
    FloatBorder      = { fg = p.nord0darker, bg = p.none,       reverse = true                  },
    -- Search
    Search           = { fg = p.nord8,       bg = p.nord0,      reverse = true                  },
    IncSearch        = { fg = p.nord6,       bg = p.nord10,     underline = true                },
    CurSearch        = { fg = p.nord6,       bg = p.nord10,     underline = true                },
    Substitute       = { fg = p.nord6,       bg = p.nord0,      reverse = true                  },
    -- Tabs
    TabLine          = { fg = p.nord4,       bg = p.nord1                                          },
    TabLineSel       = { fg = p.nord4,       bg = p.nord3light                                     },
    TabLineFill      = { fg = p.nord4dark,   bg = p.nord2                                          },
    -- Window
    Title            = { fg = p.nord4,       bg = p.none                                           },
    VertSplit        = { link = "WinSeparator"                                                     },
    WinSeparator     = { fg = p.nord1,       bg = p.nord0dark                                      },
    QuickFixLine     = { fg = p.nord0,       bg = p.nord8                                          },
    WinBar           = { fg = p.nord4,       bg = p.nord1dark                                      },
    WinBarNC         = { fg = p.nord4,       bg = p.nord1dark                                      },
    -- diff
    DiffText         = { fg = p.nord4,       bg = p.nord10,     bold = true                     },
    DiffAdd          = { fg = p.none,        bg = p.nord14dark                                     },
    DiffChange       = { fg = p.none,        bg = p.nord13dark                                     },
    DiffDelete       = { fg = p.none,        bg = p.nord11dark                                     },
    -- diff legacy
    diffAdded        = { link = "DiffAdd"                                                          },
    diffChanged      = { link = "DiffChange"                                                       },
    diffRemoved      = { link = "DiffDelete"                                                       },
    -- Yank
    Yank             = { fg = p.nord6,       bg = p.nord10                                         },
}

M.syntax = {
    Comment        = { fg = p.nord3light,                                       },

    Constant       = { fg = p.nord6                                             },
    String         = { fg = p.nord14,                  italic = true         },
    Character      = { fg = p.nord14                                            },
    Number         = { fg = p.nord15                                            },
    Boolean        = { fg = p.nord9,                   bold = true           },
    Float          = { fg = p.nord15                                            },

    Identifier     = { fg = p.nord4,                   },
    Variable       = { link = "Identifier"                                      },
    Function       = { fg = p.nord8,                   italic = true         },

    Statement      = { fg = p.nord9                                             },
    Conditional    = { fg = p.nord9,                   italic = true         },
    Repeat         = { fg = p.nord9                                             },
    Label          = { fg = p.nord9                                             },
    Operator       = { fg = p.nord9,                   },
    Keyword        = { fg = p.nord9,                   italic = true         },
    Exception      = { fg = p.nord9                                             },

    PreProc        = { fg = p.nord9,                   },
    Include        = { fg = p.nord9                                             },
    Define         = { fg = p.nord9                                             },
    Macro          = { link = "Define"                                          },
    PreCondit      = { link = "PreProc"                                         },

    Type           = { fg = p.nord9,                   },
    StorageClass   = { fg = p.nord9                                             },
    Structure      = { fg = p.nord9                                             },
    Typedef        = { fg = p.nord9                                             },

    Special        = { fg = p.nord4                                             },
    SpecialChar    = { fg = p.nord13                                            },
    Tag            = { fg = p.nord4                                             },
    Delimiter      = { fg = p.nord6                                             },
    SpecialComment = { fg = p.nord8,                   italic = true         },
    Debug          = { fg = p.nord11                                            },

    Underlined     = { fg = p.nord14,                  underline = true      },
    Ignore         = { fg = p.nord1                                             },
    Error          = { fg = p.nord11,     bg = p.none, bold = true, underline = true },
    Todo           = { fg = p.nord13,     bg = p.none                           },

    Decorator      = { fg = p.nord12                                            },
    Annotation     = { link = "Decorator"                                       },
}

M.lsp = {
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
    DiagnosticUnderlineError    = { fg = p.nord11, bg = p.none, undercurl = true,  sp = p.nord11 },
    DiagnosticUnderlineWarn     = { fg = p.nord13, bg = p.none, undercurl = true,  sp = p.nord13 },
    DiagnosticUnderlineInfo     = { fg = p.nord8,  bg = p.none, undercurl = true,  sp = p.nord8  },
    DiagnosticUnderlineHint     = { fg = p.nord10, bg = p.none, undercurl = true,  sp = p.nord10 },
    DiagnosticVirtualTextError  = { fg = p.nord11, bg = p.none, bold = true, italic = true               },
    DiagnosticVirtualTextWarn   = { fg = p.nord13, bg = p.none, bold = true, italic = true               },
    DiagnosticVirtualTextInfo   = { fg = p.nord8,  bg = p.none, bold = true, italic = true               },
    DiagnosticVirtualTextHint   = { fg = p.nord10, bg = p.none, bold = true, italic = true               },
    -- DocumentHighlight
    LspReferenceText            = { fg = p.none,   bg = p.nord3                                     },
    LspReferenceRead            = { fg = p.none,   bg = p.nord3                                     },
    LspReferenceWrite           = { fg = p.none,   bg = p.nord3                                     },
    -- Neovim LspSignatureHelp
    LspSignatureActiveParameter = { link = "Search"                                                 },
    -- lspinfo window
    LspInfoBorder               = { link = "FloatBorder"                                            },
}

M.plugins = {
    -- alpha-nvim
    AlphaButtons         = { fg = p.nord4,      bg = p.none },
    AlphaButtonShortcuts = { fg = p.nord8,      bg = p.none },
    AlphaHeader          = { fg = p.nord9,      bg = p.none },
    AlphaFooter          = { fg = p.nord3light, bg = p.none },

    -- diffview.nvim
    DiffviewVertSplit    = { fg = p.nord1, bg = p.nord13   },
    DiffviewWinSeparator = { link = "DiffviewVertSplit"    },

    -- gitsigns.nvim
    GitSignsCurrentLineBlame = { fg = p.nord15, bg = p.none,        bold = true, italic = true },
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
    IndentBlanklineContextStart       = { fg = p.none,  bg = p.none, underline = true, sp = p.nord7 },
    IndentBlanklineSpaceCharBlankline = { fg = p.nord1, bg = p.none                                    },
    IndentBlanklineSpaceChar          = { fg = p.nord1, bg = p.none                                    },
    IndentBlanklineChar               = { fg = p.nord1, bg = p.none                                    },

    -- hop.nvim
    HopNextKey   = { fg = p.nord8, bg = p.none, bold = true },
    HopNextKey1  = { fg = p.nord8, bg = p.none                 },
    HopNextKey2  = { fg = p.nord4, bg = p.none                 },
    HopUnmatched = { fg = p.nord3, bg = p.none                 },

    -- mini.nvim
    MiniCursorword        = { link = "Visual" },
    MiniCursorwordCurrent = { bold = true  },

    -- nvim-cmp
    CmpGhostText             = { fg = p.nord3light, bold = true          },

    CmpItemMenu              = { fg = p.nord3light                                       },

    CmpItemAbbr              = { fg = p.nord4                                            },
    CmpItemAbbrDeprecated    = { fg = p.nord12,      strikethrough = true },
    CmpItemAbbrMatch         = { fg = p.nord10,      bold = true          },
    CmpItemAbbrMatchFuzzy    = { link = "CmpItemAbbrMatch"                               },

    CmpItemKind              = { link = "Normal"                                         },
    CmpItemKindTypeParameter = { link = "TSParameter"                                    },
    CmpItemKindConstructor   = { link = "TSConstructor"                                  },
    CmpItemKindEnum          = { link = "Structure"                                    },
    CmpItemKindEnumMember    = { link = "Structure"                                    },
    CmpItemKindReference     = { link = "TSParameterReference"                           },
    CmpItemKindInterface     = { link = "StorageClass"                                   },
    CmpItemKindClass         = { link = "StorageClass"                                   },
    CmpItemKindVariable      = { link = "TSVariable"                                     },
    CmpItemKindProperty      = { link = "TSProperty"                                     },
    CmpItemKindOperator      = { link = "TSOperator"                                     },
    CmpItemKindFunction      = { link = "TSFunction"                                     },
    CmpItemKindConstant      = { link = "TSConstant"                                     },
    CmpItemKindSnippet       = { fg = p.nord14                                           },
    CmpItemKindKeyword       = { link = "TSKeyword"                                      },
    CmpItemKindStruct        = { link = "Structure"                                    },
    CmpItemKindModule        = { link = "TSNamespace"                                    },
    CmpItemKindMethod        = { link = "TSMethod"                                       },
    CmpItemKindFolder        = { link = "Directory"                                      },
    CmpItemKindFile          = { link = "Directory"                                      },
    CmpItemKindValue         = { link = "TSKeyword"                                      },
    CmpItemKindField         = { link = "TSField"                                        },
    CmpItemKindUnit          = { link = "TSNumber"                                       },
    CmpItemKindText          = { link = "TSText"                                         },

    -- nvim-hlslens
    HlSearchNear     = { link = "IncSearch"                                },
    HlSearchLensNear = { fg = p.nord4,      bg = p.none, reverse = true },
    HlSearchLens     = { fg = p.nord3light, bg = p.none, reverse = true },
    HlSearchFloat    = { link = "IncSearch"                                },

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

    -- nvim-scrollbar
    ScrollBarHandle = { fg = p.none,  bg = p.nord2 },
    ScrollBarError  = { link = "DiagnosticError"   },
    ScrollBarWarn   = { link = "DiagnosticWarn"    },
    ScrollBarInfo   = { link = "DiagnosticInfo"    },
    ScrollBarHint   = { link = "DiagnosticHint"    },
    ScrollBarMisc   = { fg = p.nord4, bg = p.none  },
    ScrollBarSearch = { link = "Search"            },

    -- nvim-ts-rainbow
    rainbowcol1 = { fg = p.nord10, bg = p.none },
    rainbowcol2 = { fg = p.nord11, bg = p.none },
    rainbowcol3 = { fg = p.nord13, bg = p.none },
    rainbowcol4 = { fg = p.nord14, bg = p.none },
    rainbowcol5 = { fg = p.nord15, bg = p.none },
    rainbowcol6 = { fg = p.nord7,  bg = p.none },
    rainbowcol7 = { fg = p.nord4,  bg = p.none },

    --nvim-windowpicker
    WindowPicker   = { fg = p.nord6, bg = p.nord3light, bold = true },
    WindowPickerNC = { fg = p.nord6, bg = p.nord3light, bold = true },

    -- neo-tree.nvim
    NeoTreeNormal               = { link = "Normal"                                                  },
    NeoTreeNormalNC             = { link = "NormalNC"                                                },
    NeoTreePreview              = { fg    = p.nord4,         bg = p.nord3light                       },
    NeoTreeFloatBorder          = { fg    = p.nord2,         bg = p.nord0                            },
    NeoTreeFloatTitle           = { fg    = p.nord8,         bg = p.nord2,     bold = true        },

    NeoTreeTabActive            = { fg    = p.nord4,         bg = p.nord3light                       },
    NeoTreeTabInactive          = { fg    = p.nord4,         bg = p.nord2                            },
    NeoTreeTabBarBackground     = { link = "StatusLine"                                              },
    NeoTreeTabSeparatorActive   = { fg    = p.nord3,         bg = p.nord3light                       },
    NeoTreeTabSeparatorInactive = { fg    = p.nord1,         bg = p.nord2                            },

    NeoTreeRootName             = { fg    = p.nord6,         bg = p.none,      bold = true, italic = true },
    NeoTreeIndentMarker         = { link = "FoldColumn"                                              },
    NeoTreeFileNameOpened       = { bold = true, nocombine = true                                         },
    NeoTreeBufferNumber         = { fg    = p.nord6,         bg = p.none                             },
    NeoTreeDotfile              = { fg    = p.nord3light,    bg = p.none                             },
    NeoTreeSymbolicLinkTarget   = { fg    = p.nord7,         bg = p.none,      bold = true        },

    NeoTreeMessage              = { fg    = p.nord15,        bg = p.none                             },
    NeoTreeDimText              = { fg    = p.nord3,         bg = p.none                             },
    NeoTreeFadeText1            = { link = "NeoTreeDotfile"                                          },
    NeoTreeFadeText2            = { link = "NeoTreeDimText"                                          },

    NeoTreeModified             = { link = "GitSignsChange"                                          },
    NeoTreeGitAdded             = { link = "GitSignsAdd"                                             },
    NeoTreeGitModified          = { link = "GitSignsChange"                                          },
    NeoTreeGitDeleted           = { link = "GitSignsDelete"                                          },
    NeoTreeGitRenamed           = { link = "NeoTreeGitModified"                                      },
    NeoTreeGitUntracked         = { fg    = p.nord10,        bg = p.none                             },
    NeoTreeGitIgnored           = { link = "NeoTreeDotfile"                                          },
    NeoTreeGitUnstaged          = { link = "NeoTreeGitModified"                                      },
    NeoTreeGitStaged            = { link = "NeoTreeGitAdded"                                         },
    NeoTreeGitConflict          = { fg    = p.nord12,        bg = p.none                             },

    -- quickscope.lua
    QuickScopePrimary   = { fg = p.nord13, bg = p.nord0, underline = true, nocombine = true },
    QuickScopeSecondary = { fg = p.nord15, bg = p.nord0, bold = true, nocombine = true      },

    -- satellite.nvim
    ScrollView = { fg = p.none,  bg = p.nord3 },
    SearchSV   = { fg = p.nord8, bg = p.none  },

    -- telescope.nvim
    TelescopePromptPrefix   = { fg = p.nord4, bg = p.none,       bold = true },
    TelescopePromptCounter  = { fg = p.nord7, bg = p.none,       bold = true },

    TelescopeNormal         = { fg = p.nord4, bg = p.nord0darker                },
    TelescopeResultsNormal  = { fg = p.nord9, bg = p.none                       },
    TelescopePreviewNormal  = { fg = p.nord4, bg = p.nord0                      },
    TelescopePromptNormal   = { fg = p.nord6, bg = p.nord0                      },

    TelescopeResultsTitle   = { fg = p.nord8, bg = p.nord2,      bold = true },
    TelescopePreviewTitle   = { fg = p.nord9, bg = p.nord2,      bold = true },
    TelescopePromptTitle    = { fg = p.nord4, bg = p.nord2,      bold = true },

    TelescopeResultsBorder  = { fg = p.nord2, bg = p.none                       },
    TelescopePreviewBorder  = { fg = p.nord2, bg = p.nord0                      },
    TelescopePromptBorder   = { fg = p.nord2, bg = p.nord0                      },

    TelescopeMultiSelection = { fg = p.nord6, bg = p.nord2                      },
    TelescopeMultiIcon      = { fg = p.nord6, bg = p.nord2                      },
    TelescopeSelectionCaret = { fg = p.nord8, bg = p.nord1                      },
    TelescopeSelection      = { link = "TelescopeSelectionCaret"                },
    TelescopeMatching       = { fg = p.nord6, bg = p.none                       },

    -- todo-comments.nvim
    TodoBgFIX    = { fg = p.nord6,  bg = p.nord11, bold = true },
    TodoFgFIX    = { link = "DiagnosticError"                     },
    TodoSignFIX  = { link = "DiagnosticError"                     },
    TodoBgNOTE   = { fg = p.nord6,  bg = p.nord10, bold = true },
    TodoFgNOTE   = { link = "DiagnosticHint"                      },
    TodoSignNOTE = { link = "DiagnosticHint"                      },
    TodoBgWARN   = { fg = p.nord6,  bg = p.nord13, bold = true },
    TodoFgWARN   = { link = "DiagnosticWarn"                      },
    TodoSignWARN = { link = "DiagnosticWarn"                      },
    TodoBgPERF   = { fg = p.nord6,  bg = p.nord14, bold = true },
    TodoFgPERF   = { fg = p.nord14, bg = p.none                   },
    TodoSignPERF = { fg = p.nord14, bg = p.none                   },
    TodoBgTODO   = { fg = p.nord6,  bg = p.nord8,  bold = true },
    TodoFgTODO   = { link = "DiagnosticInfo"                      },
    TodoSignTODO = { link = "DiagnosticInfo"                      },
    TodoBgHACK   = { fg = p.nord6,  bg = p.nord13, bold = true },
    TodoFgHACK   = { link = "DiagnosticWarn"                      },
    TodoSignHACK = { link = "DiagnosticWarn"                      },

    -- vim-illuminate
    IlluminatedWordText  = { link = "Visual" },
    IlluminatedWordRead  = { link = "Visual" },
    IlluminatedWordWrite = { link = "Visual" },

    -- which-key.nvim
    WhichKey          = { fg = p.nord4,  bg = p.none, bold = true },
    WhichKeyBorder    = { link = "FloatBorder" },
    WhichKeyGroup     = { fg = p.nord10, bg = p.none, bold = true },
    WhichKeyDesc      = { fg = p.nord9,  bg = p.none                 },
    WhichKeySeparator = { fg = p.nord3,  bg = p.none                 },
    WhichKeyValue     = { link = "Comment"                           },
    WhichKeyFloat     = { link = "NormalFloat"                       },

    -- hydra.nvim
    HydraHint     = { link = "NormalFloat"       },
    HydraAmaranth = { fg = p.nord12, bg = p.none },
    HydraTeal     = { fg = p.nord7,  bg = p.none },
    HydraPink     = { fg = p.nord15, bg = p.none },
    HydraBlue     = { fg = p.nord10, bg = p.none },
    HydraRed      = { fg = p.nord11, bg = p.none }
}

M.treesitter = {
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

    TSNamespace          = { fg = p.nord4,              italic = true },
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
    TSMethod             = { fg = p.nord7,              italic = true },
    TSProperty           = { fg = p.nord10,             italic = true },

    TSType               = { link = "Type"                               },
    TSTypeBuiltin        = { link = "Type"                               },
    TSStructure          = { link = "Structure"                          },

    TSPunctDelimiter     = { fg = p.nord8                                },
    TSPunctBracket       = { fg = p.nord8                                },
    TSPunctSpecial       = { fg = p.nord8                                },
    TSTag                = { link = "Tag"                                },
    TSTagDelimiter       = { link = "TSTag"                              },

    TSAnnotation         = { link = "Annotation"                         },
    TSEmphasis           = { italic = true                            },
    TSStrong             = { bold = true                              },
    TSUnderline          = { underline = true                         },
    -- TSError              = { link = "Error"                              },

    TSAttribute          = { fg = p.nord15                               },
    TSParameter          = { fg = p.nord10                               },
    TSParameterReference = { fg = p.nord10                               },
    TSSymbol             = { fg = p.nord15                               },
    TSTitle              = { fg = p.nord9, bg = p.none, bold = true   },
    TSURI                = { fg = p.nord10                               },
}

return M
