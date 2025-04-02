local M = {}

function M.get_highlight_groups(palette)
    local p = palette
    local g = {}

    g.editor = {
        ColorColumn      = { bg = p.base_0 }, -- used for the columns set with 'colorcolumn'
        Conceal          = { fg = p.base_0 }, -- placeholder characters substituted for concealed text (see 'conceallevel')
        Cursor           = { reverse = true }, -- character under the cursor
        lCursor          = { link = "Cursor" }, -- the character under the cursor when |language-mapping| is used (see 'guicursor')
        CursorIM         = { link = "Cursor" }, -- like Cursor, but used when in IME mode |CursorIM|
        CursorColumn     = { link = "CursorLine" }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
        CursorLine       = { bg = p.base_2 }, -- Screen-line at the cursor, when 'cursorline' is set.  Low-priority if foreground (ctermfg OR guifg) is not set.
        CursorLineSign   = { link = "CursorLine" },
        CursorLineFold   = { link = "CursorLine" },
        CursorLineNr     = { fg = p.base_fg, bg = p.base_2 }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
        Directory        = { fg = p.blue_2 }, -- directory names (and other special names in listings)
        DiffAdd          = { sp = p.green_0 }, -- diff mode: Added line |diff.txt|
        diffAdded        = { link = "DiffAdd" },
        DiffChange       = { bg = p.yellow_0 }, -- diff mode: Changed line |diff.txt|
        diffChanged      = { link = "DiffChange" },
        DiffDelete       = { fg = p.red_2, bg = p.red_0 }, -- diff mode: Deleted line |diff.txt|
        diffRemoved      = { link = "DiffDelete" },
        DiffText         = { sp = p.yellow_0, underdashed = true }, -- diff mode: Changed text within a changed line |diff.txt|
        EndOfBuffer      = { fg = p.base_2 }, -- filler lines (~) after the end of the buffer.  By default, this is highlighted like |hl-NonText|.
        ErrorMsg         = { fg = p.red_2 }, -- error messages on the command line
        VertSplit        = { link = "WinSeparator" }, -- the column separating vertically split windows
        WinSeparator     = { fg = p.base_2 }, -- the column separating vertically split windows
        Folded           = { fg = p.base_fg, bg = p.blue_0 }, -- line used for closed folds
        FoldColumn       = { fg = p.base_03 }, -- 'foldcolumn'
        SignColumn       = { fg = p.base_2 }, -- column where |signs| are displayed
        Substitute       = { bg = p.base_0, fg = p.yellow_2, reverse = true }, -- |:substitute| replacement text highlighting
        LineNr           = { fg = p.base_04 }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
        LineNrAbove      = { link = "LineNr" },
        LineNrBelow      = { link = "LineNr" },
        MatchParen       = { fg = p.orange_2, bold = true, underline = true }, -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
        ModeMsg          = { fg = p.base_fg, bold = true }, -- 'showmode' message (e.g., "-- INSERT -- ")
        MsgArea          = { link = "Normal" }, -- Area for messages and cmdline
        MsgSeparator     = { link = "MoreMsg" },
        MoreMsg          = { fg = p.yellow_2 }, -- |more-prompt|
        NonText          = { fg = p.base_3 }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
        Normal           = { fg = p.base_fg, bg = p.base_bg }, -- normal text
        NormalNC         = { fg = p.base_fg, bg = p.base_bg }, -- normal text in non-current windows
        NormalFloat      = { fg = p.base_fg, bg = p.base_0 }, -- Normal text in floating windows.
        FloatBorder      = { fg = p.base_2, bg = p.base_0 },
        FloatTitle       = { fg = p.cyan_2, bg = p.base_2 },
        Pmenu            = { fg = p.base_fg, bg = p.base_0 }, -- Popup menu: normal item.
        PmenuSel         = { fg = p.cyan_2, bg = p.base_2 }, -- Popup menu: selected item.
        PmenuSbar        = { fg = p.base_fg, bg = p.base_0 }, -- Popup menu: scrollbar.
        PmenuThumb       = { fg = p.cyan_2, bg = p.base_4 }, -- Popup menu: Thumb of the scrollbar.
        Question         = { fg = p.blue_3 }, -- |hit-enter| prompt and yes/no questions
        QuickFixLine     = { fg = p.base_0, bg = p.cyan_2 }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
        Search           = { fg = p.cyan_2, bg = p.base_bg, reverse = true }, -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand out.
        IncSearch        = { fg = p.base_0, bg = p.yellow_2, underline = true }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
        CurSearch        = { link = "IncSearch" },
        SpecialKey       = { fg = p.base_4 }, -- Unprintable characters: text displayed differently from what it really is.  But not 'listchars' whitespace. |hl-Whitespace|
        SpellBad         = { sp = p.red_2, undercurl = true }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
        SpellCap         = { sp = p.yellow_2, undercurl = true }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
        SpellLocal       = { sp = p.cyan_2, undercurl = true }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
        SpellRare        = { sp = p.blue_2, undercurl = true }, -- Word that is recognized by the spellchecker as one that is hardly ever used.  |spell| Combined with the highlighting used otherwise.
        StatusLine       = { fg = p.base_fg, bg = p.base_2 }, -- status line of current window
        StatusLineNC     = { fg = p.base_03, bg = p.base_1 }, -- status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
        StatusLineTerm   = { link = "StatusLine" },
        StatusLineTermNC = { link = "StatusLineNC" },
        TabLine          = { fg = p.base_03, bg = p.base_3 }, -- tab pages line, not active tab page label
        TabLineFill      = { fg = p.base_03, bg = p.base_2 }, -- tab pages line, where there are no labels
        TabLineSel       = { fg = p.base_00, bg = p.base_4, bold = true }, -- tab pages line, active tab page label
        TermCursor       = { link = "Cursor" },
        TermCursorNC     = { link = "Cursor" },
        Title            = { fg = p.cyan_2, bold = true }, -- titles for output from ":set all", ":autocmd" etc.
        Visual           = { bg = p.base_4 }, -- Visual mode selection
        VisualNOS        = { bg = p.base_4 }, -- Visual mode selection when vim is "Not Owning the Selection".
        WarningMsg       = { fg = p.yellow_2, bg = p.base_bg, reverse = true }, -- warning messages
        Whitespace       = { fg = p.base_3 }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
        WildMenu         = { bg = p.base_4 }, -- current match in 'wildmenu' completion
        WinBar           = { fg = p.base_fg, bg = p.base_bg }, -- window bar
        WinBarNC         = { fg = p.base_03, bg = p.base_bg }, -- window bar in inactive windows
        Yank             = { fg = p.base_00, bg = p.blue_1 },
    }

    -- Source: https://neovim.io/doc/user/syntax.html#group-name
    g.syntax = {
        Comment        = { fg = p.base_04, italic = true }, -- any comment

        Constant       = { fg = p.base_fg, bold = true }, -- (preferred) any constant
        String         = { fg = p.green_2, italic = true }, -- a string constant: "this is a string"
        Character      = { link = "String" }, -- a character constant: 'c', '\n'
        Number         = { fg = p.green_3 }, -- a number constant: 234, 0xff
        Boolean        = { link = "Number" }, -- a floating point constant: 2.3e10
        Float          = { link = "Number" }, -- a boolean constant: TRUE, false

        Identifier     = { fg = p.base_fg }, -- (preferred) any variable name
        Function       = { fg = p.cyan_2 }, -- function name (also: methods for classes)

        Statement      = { fg = p.magenta_2 }, -- (preferred) any statement
        Conditional    = { link = "Statement" }, -- if, then, else, endif, switch, etc.
        Repeat         = { link = "Statement" }, -- for, do, while, etc.
        Label          = { link = "Statement" }, -- case, default, etc.

        Operator       = { fg = p.base_00 }, -- "sizeof", "+", "*", etc.
        Keyword        = { fg = p.blue_3, italic = true }, -- any other keyword
        Exception      = { link = "Keyword" }, -- try, catch, throw

        PreProc        = { fg = p.base_01, bold = true }, -- (preferred) generic Preprocessor
        Include        = { link = "PreProc" }, -- preprocessor #include
        Define         = { link = "PreProc" }, -- preprocessor #define
        Macro          = { link = "PreProc" }, -- same as Define
        PreCondit      = { link = "PreProc" }, -- preprocessor #if, #else, #endif, etc.

        Type           = { fg = p.violet_2 }, -- (preferred) int, long, char, etc.
        StorageClass   = { link = "Type" }, -- static, register, volatile, etc.
        Structure      = { link = "Type" }, -- struct, union, enum, etc.
        Typedef        = { link = "Type" }, -- A typedef

        Special        = { fg = p.orange_2 }, -- (preferred) any special symbol
        SpecialChar    = { link = "Special" }, -- special character in a constant
        Tag            = { fg = p.yellow_2 }, -- you can use CTRL-] on this
        Delimiter      = { fg = p.yellow_2 }, -- character that needs attention
        SpecialComment = { fg = p.base_04, bold = true }, -- special things inside a comment
        Debug          = { link = "Special" }, -- debugging statements

        Error          = { fg = p.red_2, bold = true }, -- (preferred) any erroneous construct
        Todo           = { fg = p.base_0, bg = p.cyan_2, bold = true }, -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX
        Underlined     = { underline = true }, -- (preferred) text that stands out, HTML links
    }

    g.lsp = {
        -- These groups are for the native LSP client. Some other LSP clients may
        -- use these groups, or use their own.
        LspReferenceText            = { link = "Visual" }, -- used for highlighting "text" references
        LspReferenceRead            = { link = "Visual" }, -- used for highlighting "read" references
        LspReferenceWrite           = { link = "Visual" }, -- used for highlighting "write" references
        LspSignatureActiveParameter = { bg = g.editor.Visual.bg, bold = true },
        LspCodeLens                 = { fg = g.syntax.Comment.fg },
        LspInlayHint                = { fg = p.base_04, bg = p.base_0 },
        LspInfoBorder               = { link = "FloatBorder" },
    }

    g.diagnostic = {
        DiagnosticError            = { fg = p.red_2 }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
        DiagnosticWarn             = { fg = p.yellow_2 }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
        DiagnosticInfo             = { fg = p.cyan_2 }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
        DiagnosticHint             = { fg = p.blue_2 }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
        DiagnosticOk               = { fg = p.green_2 },
        DiagnosticUnnecessary      = { fg = p.base_04 },
        DiagnosticDeprecated       = { fg = p.base_04, strikethrough = true },
        DiagnosticSignError        = { link = "DiagnosticError" },
        DiagnosticSignWarn         = { link = "DiagnosticWarn" },
        DiagnosticSignInfo         = { link = "DiagnosticInfo" },
        DiagnosticSignHint         = { link = "DiagnosticHint" },
        DiagnosticSignOk           = { link = "DiagnosticOk" },
        DiagnosticFloatingWarn     = { link = "DiagnosticError" },
        DiagnosticFloatingError    = { link = "DiagnosticWarn" },
        DiagnosticFloatingInfo     = { link = "DiagnosticInfo" },
        DiagnosticFloatingHint     = { link = "DiagnosticHint" },
        DiagnosticFloatingOk       = { link = "DiagnosticOk" },
        DiagnosticUnderlineError   = { undercurl = true, sp = p.red_2 },
        DiagnosticUnderlineWarn    = { undercurl = true, sp = p.yellow_2 },
        DiagnosticUnderlineInfo    = { undercurl = true, sp = p.cyan_2 },
        DiagnosticUnderlineHint    = { undercurl = true, sp = p.blue_2 },
        DiagnosticUnderlineOk      = { undercurl = true, sp = p.green_2 },
        DiagnosticVirtualTextError = { fg = p.red_2, bg = p.red_0, bold = true },
        DiagnosticVirtualTextWarn  = { fg = p.yellow_2, bg = p.yellow_0, bold = true },
        DiagnosticVirtualTextInfo  = { fg = p.cyan_2, bg = p.cyan_0, bold = true },
        DiagnosticVirtualTextHint  = { fg = p.blue_2, bg = p.blue_0, bold = true },
        DiagnosticVirtualTextOk    = { fg = p.green_2, bg = p.green_0, bold = true },
    }

    g.flash = {
        FlashPromptIcon = { fg = g.editor.MoreMsg.fg, bg = g.editor.StatusLine.bg },
        FlashPrompt     = { link = "MsgArea" },
        FlashCurrent    = { fg = p.yellow_2, bold = true, nocombine = true, reverse = true },
        FlashMatch      = { fg = p.cyan_2, nocombine = true },
        FlashLabel      = { fg = p.base_fg, nocombine = true },
        FlashBackdrop   = { link = "Comment" },
    }

    -- Source: https://neovim.io/doc/user/treesitter.html#treesitter-highlight
    g.treesitter = {
        ["@annotation"]                   = { fg = g.syntax.Type.fg, italic = true },
        ["@attribute"]                    = { link = "@annotation" }, -- attribute annotations (e.g. Python decorators, Rust lifetimes)
        ["@boolean"]                      = { link = "Boolean" }, -- boolean literals
        ["@character"]                    = { link = "Character" }, -- character literals
        ["@character.printf"]             = { link = "SpecialChar" },
        ["@character.special"]            = { link = "SpecialChar" }, -- special characters (e.g. wildcards)
        ["@comment"]                      = { link = "Comment" }, -- line and block comments
        ["@comment.documentation"]        = { link = "Comment" }, -- comments documenting code
        ["@comment.error"]                = { fg = p.base_0, bg = p.red_2, bold = true }, -- error-type comments (e.g. ERROR, FIXME, DEPRECATED)
        ["@comment.hint"]                 = { fg = p.base_0, bg = p.blue_2, bold = true },
        ["@comment.info"]                 = { fg = p.base_0, bg = p.cyan_2, bold = true },
        ["@comment.note"]                 = { fg = p.base_0, bg = p.blue_2, bold = true }, -- note-type comments (e.g. NOTE, INFO, XXX)
        ["@comment.todo"]                 = { link = "Todo" }, -- todo-type comments (e.g. TODO, WIP)
        ["@comment.warning"]              = { fg = p.base_0, bg = p.yellow_2, bold = true }, -- warning-type comments (e.g. WARNING, FIX, HACK)
        ["@constant"]                     = { link = "Constant" }, -- constant identifiers
        ["@constant.builtin"]             = { link = "Constant" }, -- built-in constant values
        ["@constant.macro"]               = { link = "Constant" }, -- constants defined by the preprocessor
        ["@constructor"]                  = { link = "Function" }, -- For constructor calls and definitions: `= { }` in Lua, and Java constructors.
        ["@constructor.tsx"]              = { link = "Function" },
        ["@diff.delta"]                   = { link = "DiffChange" }, -- changed text (for diff files)
        ["@diff.minus"]                   = { link = "DiffDelete" }, -- deleted text (for diff files)
        ["@diff.plus"]                    = { link = "DiffAdd" }, -- added text (for diff files)
        ["@function"]                     = { link = "Function" }, -- function definitions
        ["@function.builtin"]             = { link = "Function" }, -- built-in functions
        ["@function.call"]                = { link = "Function" }, -- function calls
        ["@function.macro"]               = { link = "Macro" }, -- preprocessor macros
        ["@function.method"]              = { link = "Function" }, -- method definitions
        ["@function.method.call"]         = { link = "Function" }, -- method calls
        ["@keyword"]                      = { link = "Keyword" }, -- For keywords that don't fall in previous categories.
        ["@keyword.conditional"]          = { link = "Conditional" }, -- keywords related to conditionals (e.g. if, else)
        ["@keyword.coroutine"]            = { link = "Keyword" }, -- keywords related to coroutines (e.g. go in Go, async/await in Python)
        ["@keyword.debug"]                = { link = "Debug" }, -- keywords related to debugging
        ["@keyword.directive"]            = { link = "PreProc" }, -- various preprocessor directives and shebangs
        ["@keyword.directive.define"]     = { link = "Define" }, -- preprocessor definition directives
        ["@keyword.exception"]            = { link = "Exception" }, -- keywords related to exceptions (e.g. throw, catch)
        ["@keyword.function"]             = { link = "Keyword" }, -- For keywords used to define a function.
        ["@keyword.import"]               = { link = "Keyword" }, -- keywords for including or exporting modules (e.g. import, from in Python)
        ["@keyword.operator"]             = { link = "Operator" }, -- operators that are English words (e.g. and, or)
        ["@keyword.repeat"]               = { link = "Repeat" }, -- keywords related to loops (e.g. for, while)
        ["@keyword.return"]               = { fg = p.blue_2 }, -- keywords like return and yield
        ["@keyword.storage"]              = { link = "StorageClass" },
        ["@label"]                        = { link = "Label" }, -- For labels: `label:` in C and `:label:` in Lua.
        ["@markup"]                       = { link = "@none" },
        ["@markup.emphasis"]              = { italic = true },
        ["@markup.environment"]           = { link = "Macro" },
        ["@markup.environment.name"]      = { link = "Type" },
        ["@markup.heading"]               = { link = "Title" }, -- headings, titles (including markers)
        ["@markup.heading.html"]          = { link = "Normal" }, -- headings, titles (including markers)
        ["@markup.heading.1.html"]        = { link = "Normal" }, -- headings, titles (including markers)
        ["@markup.heading.2.html"]        = { link = "Normal" }, -- headings, titles (including markers)
        ["@markup.heading.3.html"]        = { link = "Normal" }, -- headings, titles (including markers)
        ["@markup.heading.4.html"]        = { link = "Normal" }, -- headings, titles (including markers)
        ["@markup.heading.5.html"]        = { link = "Normal" }, -- headings, titles (including markers)
        ["@markup.italic"]                = { italic = true }, -- italic text
        ["@markup.link"]                  = { fg = p.blue_2 }, -- text references, footnotes, citations, etc.
        ["@markup.link.label"]            = { link = "@markup.link" }, -- link, reference descriptions
        ["@markup.link.label.html"]       = { link = "Normal" }, -- link, reference descriptions
        ["@markup.link.label.symbol"]     = { link = "@markup.link" },
        ["@markup.link.url"]              = { fg = g.syntax.Comment.fg, underline = true }, -- URL-style links
        ["@markup.list"]                  = { link = "Delimiter" }, -- For special punctutation that does not fall in the categories before.
        ["@markup.list.checked"]          = { fg = p.green_2 }, -- For brackets and parens.
        ["@markup.list.unchecked"]        = { fg = p.base_04 }, -- For brackets, parens and math environments (e.g. $ ... $ in LaTeX)
        ["@markup.math"]                  = { link = "Special" },
        ["@markup.raw"]                   = { link = "String" }, -- literal or verbatim text (e.g. inline code)
        ["@markup.raw.markdown_inline"]   = { bg = p.base_0, fg = p.blue_3 },
        ["@markup.strikethrough"]         = { strikethrough = true }, -- struck-through text
        ["@markup.strong"]                = { bold = true }, -- bold text
        ["@markup.underline"]             = { underline = true }, -- underlined text (only for literal underline markup!)
        ["@module"]                       = { link = "Include" }, -- modules or namespaces
        ["@module.builtin"]               = { fg = p.yellow_2 }, -- Variable names that are defined by the languages, like `this` or `self`.
        ["@none"]                         = {},
        ["@number"]                       = { link = "Number" }, -- numeric literals
        ["@number.float"]                 = { link = "Float" }, -- floating-point number literals
        ["@operator"]                     = { link = "Operator" }, -- For any operator: `+`, but also `->` and `*` in C.
        ["@property"]                     = { fg = p.cyan_3 }, -- the key in key/value pairs
        ["@punctuation.bracket"]          = { link = "Delimiter" }, -- For brackets and parens.
        ["@punctuation.delimiter"]        = { link = "Delimiter" }, -- For delimiters ie: `.`
        ["@punctuation.special"]          = { fg = p.orange_2 }, -- For special symbols (e.g. `{}` in string interpolation)
        ["@punctuation.special.markdown"] = { fg = p.orange_2, bold = true }, -- For special symbols (e.g. `{}` in string interpolation)
        ["@string"]                       = { link = "String" }, -- string literals
        ["@string.documentation"]         = { fg = p.yellow_1 }, -- string documenting code (e.g. Python docstrings)
        ["@string.escape"]                = { link = "Delimiter" }, -- For escape characters within a string.
        ["@string.regexp"]                = { fg = p.red_2 }, -- For regexes.
        ["@string.special"]               = { link = "Special" }, -- other special strings (e.g. dates)
        ["@string.special.path"]          = { link = "Directory" }, -- filenames
        ["@string.special.symbol"]        = { link = "SpecialChar" }, -- symbols or atoms
        ["@string.special.url"]           = { fg = g.syntax.Special.fg, underline = true }, -- URIs (e.g. hyperlinks)
        ["@string.special.url.comment"]   = { fg = g.syntax.Comment.fg, underline = true }, -- URIs (e.g. hyperlinks)
        ["@string.special.url.html"]      = { underline = true }, -- URIs (e.g. hyperlinks)
        ["@tag"]                          = { link = "Tag" }, -- XML-style tag names (e.g. in XML, HTML, etc.)
        ["@tag.attribute"]                = { link = "@attribute" }, -- XML-style tag attributes
        ["@tag.delimiter"]                = { link = "Delimiter" }, -- XML-style tag delimiters
        ["@tag.delimiter.tsx"]            = { link = "Delimiter" },
        ["@tag.delimiter.html"]           = { fg = p.dark_4 },
        ["@tag.html"]                     = { link = "Tag" },
        ["@tag.javascript"]               = { link = "Tag" },
        ["@tag.tsx"]                      = { link = "Tag" },
        ["@type"]                         = { link = "Type" }, -- type or class definitions and annotations
        ["@type.builtin"]                 = { link = "Type" }, -- built-in types
        ["@type.definition"]              = { link = "Typedef" }, -- identifiers in type definitions (e.g. typedef <type> <identifier> in C)
        ["@variable"]                     = { link = "Identifier" }, -- Any variable name that does not have another highlight.
        ["@variable.builtin"]             = { fg = g.syntax.Keyword.fg }, -- Variable names that are defined by the languages, like `this` or `self`.
        ["@variable.member"]              = { link = "@property" }, -- For fields.
        ["@variable.parameter"]           = { fg = g.syntax.PreProc.fg, italic = true }, -- For parameters of a function.
        ["@variable.parameter.builtin"]   = { link = "@variable.member" }, -- For builtin parameters of a function, e.g. "..." or Smali's p[1-99]
    }

    -- Source: https://neovim.io/doc/user/lsp.html#lsp-semantic-highlight
    g.semantic_tokens = {
        ["@lsp.type.boolean"]                      = { link = "@boolean" },
        ["@lsp.type.builtinType"]                  = { link = "@type.builtin" },
        ["@lsp.type.class"]                        = { link = "@function" },
        ["@lsp.type.comment"]                      = {--[[ link = "@comment" ]]}, -- prefer treesitter comment hl groups like note, todo etc
        ["@lsp.type.decorator"]                    = { link = "@annotation" },
        ["@lsp.type.deriveHelper"]                 = { link = "@attribute" },
        ["@lsp.type.enum"]                         = { link = "Structure" },
        ["@lsp.type.enumMember"]                   = { link = "@constant" },
        ["@lsp.type.escapeSequence"]               = { link = "@string.escape" },
        ["@lsp.type.formatSpecifier"]              = { link = "@markup.list" },
        ["@lsp.type.generic"]                      = { link = "@variable" },
        ["@lsp.type.interface"]                    = { link = "@type" },
        ["@lsp.type.keyword"]                      = { link = "@keyword" },
        ["@lsp.type.lifetime"]                     = { link = "@attribute" },
        ["@lsp.type.namespace"]                    = { link = "@module" },
        ["@lsp.type.number"]                       = { link = "@number" },
        ["@lsp.type.operator"]                     = { link = "@operator" },
        ["@lsp.type.parameter"]                    = { link = "@variable.parameter" },
        ["@lsp.type.property"]                     = { link = "@property" },
        ["@lsp.type.selfKeyword"]                  = { link = "@variable.builtin" },
        ["@lsp.type.selfTypeKeyword"]              = { link = "@variable.builtin" },
        ["@lsp.type.string"]                       = { link = "@string" },
        ["@lsp.type.typeAlias"]                    = { link = "@type.definition" },
        ["@lsp.type.unresolvedReference"]          = { undercurl = true, sp = p.red_2 },
        ["@lsp.type.variable"]                     = {}, -- use treesitter styles for regular variables
        ["@lsp.typemod.class.defaultLibrary"]      = { link = "@type.builtin" },
        ["@lsp.typemod.enum.defaultLibrary"]       = { link = "@type.builtin" },
        ["@lsp.typemod.enumMember.defaultLibrary"] = { link = "@constant.builtin" },
        ["@lsp.typemod.function.defaultLibrary"]   = { link = "@function.builtin" },
        ["@lsp.typemod.keyword.async"]             = { link = "@keyword.coroutine" },
        ["@lsp.typemod.keyword.injected"]          = { link = "@keyword" },
        ["@lsp.typemod.macro.defaultLibrary"]      = { link = "@function.builtin" },
        ["@lsp.typemod.method.defaultLibrary"]     = { link = "@function.builtin" },
        ["@lsp.typemod.operator.injected"]         = { link = "@operator" },
        ["@lsp.typemod.string.injected"]           = { link = "@string" },
        ["@lsp.typemod.struct.defaultLibrary"]     = { link = "@type.builtin" },
        ["@lsp.typemod.type.defaultLibrary"]       = { link = "@type.builtin" },
        ["@lsp.typemod.typeAlias.defaultLibrary"]  = { link = "@type.builtin" },
        ["@lsp.typemod.variable.callable"]         = { link = "@function" },
        ["@lsp.typemod.variable.defaultLibrary"]   = { link = "@module.builtin" },
        ["@lsp.typemod.variable.injected"]         = { link = "@variable" },
        ["@lsp.typemod.variable.static"]           = { link = "@constant" },
    }

    g.bars = {
        ModeInactive        = { fg = p.base_2, bg = p.cyan_2 },
        ModeVisual          = { fg = p.base_2, bg = p.yellow_2 },
        ModeReplace         = { fg = p.base_2, bg = p.red_2 },
        ModeNormal          = { fg = p.base_2, bg = p.cyan_2 },
        ModeInsert          = { fg = p.base_2, bg = p.base_fg },
        ModeCommand         = { fg = p.base_2, bg = p.violet_2 },
        ModeTerminal        = { fg = p.base_2, bg = p.orange_2 },
        BarUpdates          = { fg = p.violet_2 },
        BarModified         = { fg = p.yellow_2 },
        BarUnmodified       = { fg = p.base_1 },
        BarReadOnly         = { fg = p.base_00 },
        BarWindowNumber     = { fg = p.base_00 },
        BarCloseButton      = { fg = p.base_fg },
        BarCloseButtonNC    = { fg = p.base_03 },
        WinBar1             = { fg = p.base_fg, bg = p.base_4 },
        WinBar1NC           = { fg = p.base_03, bg = p.base_2 },
        StatusLine1         = { fg = p.base_fg, bg = p.base_4 },
        StatusLine2         = { fg = p.base_1, bg = p.base_4, bold = true },
        TabLineIndicator    = { fg = p.base_01, bg = p.base_4 },
        TabLineIndicatorSel = { fg = p.base_3, bg = p.cyan_2 },
    }

    g.plugins = {
        -- aerial.nvim
        AerialLine                    = { link = "CursorLine" },
        AerialLineNC                  = { bg = p.base_4 },

        -- alpha-nvim
        AlphaButtons                  = { fg = p.base_fg },
        AlphaButtonShortcuts          = { fg = p.cyan_2 },
        AlphaHeader                   = { fg = p.blue_3 },
        AlphaFooter                   = { fg = p.base_04 },

        -- codewindow.nvim
        CodewindowBackground          = { link = "NormalFloat" },
        CodewindowBorder              = { link = "FloatBorder" },
        CodewindowWarn                = { link = "DiagnosticWarn" },
        CodewindowError               = { link = "DiagnosticError" },
        CodewindowDeletion            = { link = "GitSignsDelete" },
        CodewindowAddition            = { link = "GitSignsAdd" },
        CodewindowUnderline           = { underline = true, sp = p.cyan_2 },

        -- diffview.nvim
        DiffviewNormal                = { link = "Normal" },
        DiffviewWinSeparator          = { link = "WinSeparator" },
        DiffviewVertSplit             = { link = "WinSeparator" },
        DiffviewEndOfBuffer           = { link = "EndOfBuffer" },
        DiffviewNonText               = { link = "NonText" },

        -- fidget.nvim
        FidgetProgress                = { fg = p.base_04 },
        FidgetDone                    = { fg = p.base_03 },
        FidgetNormal                  = { fg = p.base_04, bg = g.editor.NormalFloat.bg },

        -- gitsigns.nvim
        GitSignsCurrentLineBlame      = { fg = p.base_04, bold = true, italic = true },
        GitSignsAdd                   = { fg = p.green_2 },
        GitSignsChange                = { fg = p.yellow_2 },
        GitSignsChangedelete          = { fg = p.yellow_2 },
        GitSignsDelete                = { fg = p.red_2 },
        GitSignsTopDelete             = { fg = p.red_2 },
        GitSignsUntracked             = { fg = p.blue_2 },
        GitSignsAddCul                = { fg = p.green_2, bg = g.editor.CursorLine.bg },
        GitSignsChangeCul             = { fg = p.yellow_2, bg = g.editor.CursorLine.bg },
        GitSignsChangedeleteCul       = { fg = p.yellow_2, bg = g.editor.CursorLine.bg },
        GitSignsDeleteCul             = { fg = p.red_2, bg = g.editor.CursorLine.bg },
        GitSignsTopDeleteCul          = { fg = p.red_2, bg = g.editor.CursorLine.bg },
        GitSignsUntrackedCul          = { fg = p.blue_2, bg = g.editor.CursorLine.bg },
        GitSignsAddInline             = { bg = p.green_1 },
        GitSignsChangeInline          = { bg = p.yellow_1 },
        GitSignsChangedeleteInline    = { bg = p.yellow_1 },
        GitSignsDeleteInline          = { bg = p.red_1 },
        GitSignsTopDeleteInline       = { bg = p.red_1 },
        GitSignsUntrackedInline       = { bg = p.blue_1 },
        GitSignsAddLn                 = { bg = p.green_0 },
        GitSignsChangeLn              = { bg = p.yellow_0 },
        GitSignsChangedeleteLn        = { bg = p.yellow_0 },
        GitSignsDeleteLn              = { bg = p.red_0 },
        GitSignsTopDeleteLn           = { bg = p.red_0 },
        GitSignsUntrackedLn           = { fg = p.blue_0 },
        GitSignsAddNr                 = { fg = p.green_2 },
        GitSignsChangeNr              = { fg = p.yellow_2 },
        GitSignsChangedeleteNr        = { fg = p.yellow_2 },
        GitSignsDeleteNr              = { fg = p.red_2 },
        GitSignsTopDeleteNr           = { fg = p.red_2 },
        GitSignsUntrackedNr           = { fg = p.blue_2 },
        GitSignsStagedAddCul          = { fg = p.green_1, bg = g.editor.CursorLine.bg },
        GitSignsStagedChangeCul       = { fg = p.yellow_1, bg = g.editor.CursorLine.bg },
        GitSignsStagedChangedeleteCul = { fg = p.yellow_1, bg = g.editor.CursorLine.bg },
        GitSignsStagedDeleteCul       = { fg = p.red_1, bg = g.editor.CursorLine.bg },
        GitSignsStagedTopdeleteCul    = { fg = p.red_1, bg = g.editor.CursorLine.bg },
        GitSignsStagedUntrackedCul    = { fg = p.blue_1, bg = g.editor.CursorLine.bg },

        -- hop.nvim
        HopNextKey                    = { fg = p.cyan_2, bold = true, nocombine = true },
        HopNextKey1                   = { fg = p.cyan_2, nocombine = true },
        HopNextKey2                   = { fg = p.base_fg, nocombine = true },
        HopUnmatched                  = { fg = p.base_4, nocombine = true },

        -- hydra.nvim
        HydraHint                     = { link = "NormalFloat" },
        HydraAmaranth                 = { fg = p.orange_2 },
        HydraTeal                     = { fg = p.cyan_2 },
        HydraPink                     = { fg = p.violet_2 },
        HydraBlue                     = { fg = p.blue_2 },
        HydraRed                      = { fg = p.red_2 },

        -- incline.nvim
        InclineNormal                 = { fg = p.nord5, bg = p.base_4 },
        InclineNormalNC               = { link = "InclineNormal" },

        -- indent-blankline.nvim
        IblIndent                     = { fg = p.base_2 },
        IblWhitespace                 = { link = "Whitespace" },
        IblScope                      = { fg = p.violet_2 },

        -- lazy.nvim
        LazyButton                    = { link = "Tabline" },
        LazyDimmed                    = { link = "Comment" },
        LazyH1                        = { link = "Title" },
        LazyH2                        = { fg = g.editor.Title.fg },
        LazyReasonCmd                 = { link = "Delimiter" },
        LazyReasonEvent               = { link = "Conditional" },
        LazyReasonPlugin              = { link = "Keyword" },
        LazyReasonRequire             = { link = "Special" },
        LazySpecial                   = { link = "@markup.list.checked" },

        -- leap.nvim
        LeapMatch                     = { fg = p.yellow_2, underline = true, nocombine = true },
        LeapLabelPrimary              = { fg = g.editor.Normal.bg, bg = g.editor.Normal.fg, nocombine = true },
        LeapLabelSecondary            = { fg = p.base_0, bg = p.base_03, bold = true, nocombine = true },
        LeapLabelSelected             = { fg = p.base_0, bg = p.blue_2 },
        LeapBackdrop                  = { fg = p.base_03 },

        -- nvim-lightbulb
        LightBulbSign                 = { fg = p.yellow_2 },
        LightBulbVirtualText          = { fg = p.yellow_2 },
        LightBulbFloatWin             = { fg = p.yellow_2 },
        LightBulbNumber               = { fg = p.yellow_2 },
        LightBulbLine                 = { fg = p.yellow_2 },

        -- mason.nvim
        MasonHeading                  = { link = "Title" },
        MasonHighlight                = { link = "@markup.list.checked" },
        MasonMuted                    = { link = "@markup.list.unchecked" },

        -- mini.nvim
        MiniCursorword                = { link = "Visual" },
        MiniCursorwordCurrent         = { bold = true },

        -- mini.animate
        MiniAnimateNormalFloat        = { fg = g.editor.Normal.fg, bg = g.editor.SignColumn.fg },

        -- nvim-cmp
        CmpGhostText                  = { fg = p.cFill5, bold = true },

        CmpItemMenu                   = { fg = p.cFill5 },

        CmpItemAbbr                   = { fg = p.base_fg },
        CmpItemAbbrDeprecated         = { link = "DiagnosticDeprecated" },
        CmpItemAbbrMatch              = { fg = p.blue_2, bold = true },
        CmpItemAbbrMatchFuzzy         = { link = "CmpItemAbbrMatch" },

        CmpItemKind                   = { fg = g.editor.Normal.fg },
        CmpItemKindTypeParameter      = { link = "@variable.parameter" },
        CmpItemKindConstructor        = { link = "@constructor" },
        CmpItemKindEnum               = { link = "Structure" },
        CmpItemKindEnumMember         = { link = "Constant" },
        CmpItemKindReference          = { link = "@attribute" },
        CmpItemKindInterface          = { link = "@type" },
        CmpItemKindClass              = { link = "@function" },
        CmpItemKindVariable           = { link = "@variable" },
        CmpItemKindProperty           = { link = "@property" },
        CmpItemKindOperator           = { link = "@operator" },
        CmpItemKindFunction           = { link = "@function" },
        CmpItemKindConstant           = { link = "@constant" },
        CmpItemKindSnippet            = { link = "Statement" },
        CmpItemKindKeyword            = { link = "@keyword" },
        CmpItemKindStruct             = { link = "Structure" },
        CmpItemKindModule             = { link = "@module" },
        CmpItemKindMethod             = { link = "@function" },
        CmpItemKindFolder             = { link = "Directory" },
        CmpItemKindFile               = { link = "Directory" },
        CmpItemKindValue              = { link = "@keyword" },
        CmpItemKindField              = { link = "@variable.member" },
        CmpItemKindUnit               = { link = "@number" },
        CmpItemKindText               = { link = "@string" },

        -- glance.nvim
        GlancePreviewNormal           = { fg = p.base_fg, bg = p.base_0 },
        GlancePreviewMatch            = { bg = p.base_2 },
        GlancePreviewCursorLine       = { link = "CursorLine" },
        GlancePreviewSignColumn       = { link = "SignColumn" },
        GlancePreviewEndOfBuffer      = { fg = g.editor.EndOfBuffer.fg, bg = p.base_0 },
        GlancePreviewLineNr           = { link = "LineNr" },
        GlancePreviewBorderBottom     = { fg = g.editor.FloatBorder.fg, bg = p.base_0 },
        GlanceWinBarFilename          = { fg = p.base_fg, bg = p.base_2, bold = true },
        GlanceWinBarFilepath          = { fg = p.blue_3, bg = p.base_2 },
        GlanceWinBarTitle             = { fg = p.cyan_2, bg = p.base_3, bold = true },
        GlanceListNormal              = { fg = p.base_fg, bg = p.base_0 },
        GlanceListFilename            = { link = "Define" },
        GlanceListFilepath            = { link = "Comment" },
        GlanceListCount               = { link = "Number" },
        GlanceListMatch               = { fg = p.cyan_2, bg = p.cFill1 },
        GlanceListCursorLine          = { link = "CursorLine" },
        GlanceListEndOfBuffer         = { fg = p.blue_3, bg = p.base_0 },
        GlanceListBorderBottom        = { fg = g.editor.FloatBorder.fg, bg = p.base_0 },
        GlanceFoldIcon                = { link = "FoldColumn" },
        GlanceIndent                  = { link = "FoldColumn" },
        GlanceBorderTop               = { link = "FloatBorder" },

        -- nvim-hlslens
        HlSearchNear                  = { link = "IncSearch" },
        HlSearchLensNear              = { fg = p.base_0, bg = p.base_fg },
        HlSearchLensNearMotion        = { fg = p.base_00, bg = p.yellow_1 },
        HlSearchLensNearIndex         = { fg = p.base_00, bg = p.yellow_0 },
        HlSearchLensNearMotionEdge    = { fg = p.yellow_1 },
        HlSearchLensNearIndexEdge     = { fg = p.yellow_0 },
        HlSearchLensNearSepLeft       = { fg = p.yellow_1 },
        HlSearchLensNearSepRight      = { fg = p.yellow_0 },
        HlSearchLens                  = { fg = p.base_0, bg = p.base_04 },
        HlSearchLensMotion            = { fg = p.base_00, bg = p.cyan_1 },
        HlSearchLensIndex             = { fg = p.base_00, bg = p.cyan_0 },
        HlSearchLensMotionEdge        = { fg = p.cyan_1 },
        HlSearchLensIndexEdge         = { fg = p.cyan_0 },
        HlSearchLensSepLeft           = { fg = p.cyan_1 },
        HlSearchLensSepRight          = { fg = p.cyan_0 },
        HlSearchFloat                 = { link = "IncSearch" },

        -- nvim-navic
        NavicSeparator                = { link = "Winbar" },
        NavicText                     = { link = "Normal" },

        NavicIconsArray               = { link = "@variable.member" },
        NavicIconsBoolean             = { link = "@boolean" },
        NavicIconsClass               = { link = "@function" },
        NavicIconsConstant            = { link = "@constant" },
        NavicIconsConstructor         = { link = "@constructor" },
        NavicIconsEnum                = { link = "Structure" },
        NavicIconsEnumMember          = { link = "Constant" },
        NavicIconsEvent               = { link = "@keyword" },
        NavicIconsField               = { link = "@variable.member" },
        NavicIconsFile                = { link = "Directory" },
        NavicIconsFunction            = { link = "@function" },
        NavicIconsInterface           = { link = "@type" },
        NavicIconsKey                 = { link = "@keyword" },
        NavicIconsMethod              = { link = "@function" },
        NavicIconsModule              = { link = "@include" },
        NavicIconsNamespace           = { link = "@module" },
        NavicIconsNull                = { link = "@comment" },
        NavicIconsNumber              = { link = "@number" },
        NavicIconsObject              = { link = "@type" },
        NavicIconsOperator            = { link = "@operator" },
        NavicIconsPackage             = { link = "@include" },
        NavicIconsProperty            = { link = "@property" },
        NavicIconsString              = { link = "@string" },
        NavicIconsStruct              = { link = "Structure" },
        NavicIconsTypeParameter       = { link = "@variable.parameter" },
        NavicIconsVariable            = { link = "@variable" },

        -- nvim-notify
        NotifyERRORTitle              = { fg = p.red_2, bg = g.editor.NormalFloat.bg },
        NotifyWARNTitle               = { fg = p.yellow_2, bg = g.editor.NormalFloat.bg },
        NotifyINFOTitle               = { fg = p.cyan_2, bg = g.editor.NormalFloat.bg },
        NotifyDEBUGTitle              = { fg = p.orange_2, bg = g.editor.NormalFloat.bg },
        NotifyTRACETitle              = { fg = p.blue_2, bg = g.editor.NormalFloat.bg },
        NotifyERRORIcon               = { fg = p.red_2, bg = g.editor.NormalFloat.bg },
        NotifyWARNIcon                = { fg = p.yellow_2, bg = g.editor.NormalFloat.bg },
        NotifyINFOIcon                = { fg = p.cyan_2, bg = g.editor.NormalFloat.bg },
        NotifyDEBUGIcon               = { fg = p.orange_2, bg = g.editor.NormalFloat.bg },
        NotifyTRACEIcon               = { fg = p.blue_2, bg = g.editor.NormalFloat.bg },
        NotifyERRORBorder             = { link = "FloatBorder" },
        NotifyWARNBorder              = { link = "FloatBorder" },
        NotifyINFOBorder              = { link = "FloatBorder" },
        NotifyDEBUGBorder             = { link = "FloatBorder" },
        NotifyTRACEBorder             = { link = "FloatBorder" },
        NotifyERRORBody               = { link = "NormalFloat" },
        NotifyWARNBody                = { link = "NormalFloat" },
        NotifyINFOBody                = { link = "NormalFloat" },
        NotifyDEBUGBody               = { link = "NormalFloat" },
        NotifyTRACEBody               = { link = "NormalFloat" },

        -- nvim-scrollbar
        ScrollBarHandle               = { bg = p.base_3 },
        ScrollBarError                = { link = "DiagnosticError" },
        ScrollBarWarn                 = { link = "DiagnosticWarn" },
        ScrollBarInfo                 = { link = "DiagnosticInfo" },
        ScrollBarHint                 = { link = "DiagnosticHint" },
        ScrollBarMisc                 = { fg = p.base_fg },
        ScrollBarSearch               = { link = "Search" },

        -- rainbow-delimiters.nvim
        rainbowclr1                   = { fg = g.syntax.Delimiter.fg },
        rainbowclr2                   = { fg = p.magenta_2 },
        rainbowclr3                   = { fg = p.yellow_2 },
        rainbowclr4                   = { fg = p.red_2 },

        -- nvim-windowpicker
        WindowPicker                  = { fg = p.base_0, bg = p.cyan_2, bold = true },
        WindowPickerNC                = { link = "WindowPicker" },

        -- neo-tree.nvim
        NeoTreeNormal                 = { link = "Normal" },
        NeoTreeNormalNC               = { link = "NormalNC" },
        NeoTreeFloatBorder            = { fg = g.editor.FloatBorder.fg, bg = p.base_0 },
        NeoTreeFloatTitle             = { fg = p.cyan_2, bg = p.base_3, bold = true },
        NeoTreeWinSeparator           = { link = "WinSeparator" },
        NeoTreeCursorLine             = { link = "CursorLine" },

        NeoTreeTabActive              = { fg = p.base_fg, bg = p.cFill5 },
        NeoTreeTabInactive            = { fg = p.base_fg, bg = p.base_3 },
        NeoTreeTabBarBackground       = { link = "StatusLine" },
        NeoTreeTabSeparatorActive     = { fg = p.base_2, bg = p.cFill5 },
        NeoTreeTabSeparatorInactive   = { fg = p.base_2, bg = p.base_3 },

        NeoTreeRootName               = { fg = p.base_00, bold = true, italic = true },
        NeoTreeIndentMarker           = { link = "FoldColumn" },
        NeoTreeFileNameOpened         = { bold = true, nocombine = true },
        NeoTreeBufferNumber           = { fg = p.base_00 },
        NeoTreeDotfile                = { fg = p.cFill5 },
        NeoTreeSymbolicLinkTarget     = { fg = p.violet_2, bold = true },

        NeoTreeMessage                = { fg = p.magenta_2 },
        NeoTreeDimText                = { fg = p.base_4 },
        NeoTreeFadeText1              = { link = "NeoTreeDotfile" },
        NeoTreeFadeText2              = { link = "NeoTreeDimText" },

        NeoTreeModified               = { link = "GitSignsChange" },
        NeoTreeGitAdded               = { link = "GitSignsAdd" },
        NeoTreeGitModified            = { link = "GitSignsChange" },
        NeoTreeGitDeleted             = { link = "GitSignsDelete" },
        NeoTreeGitRenamed             = { link = "NeoTreeGitModified" },
        NeoTreeGitUntracked           = { fg = p.blue_2 },
        NeoTreeGitIgnored             = { link = "NeoTreeDotfile" },
        NeoTreeGitUnstaged            = { link = "NeoTreeGitModified" },
        NeoTreeGitStaged              = { link = "NeoTreeGitAdded" },
        NeoTreeGitConflict            = { fg = p.orange_2 },

        -- null-ls.nvim
        NullLsInfoSources             = { link = "Title" },
        NullLsInfoHeader              = { link = "Label" },
        NullLsInfoBorder              = { link = "FloatBorder" },
        NullLsInfoTitle               = { link = "Type" },

        -- symbols-outline.nvim
        SymbolsOutlineConnector       = { link = "FoldColumn" },

        -- snacks.nvim
        SnacksNotifierTitleError      = { fg = p.red_2, bg = g.editor.Normal.bg },
        SnacksNotifierTitleWarn       = { fg = p.yellow_2, bg = g.editor.Normal.bg },
        SnacksNotifierTitleInfo       = { fg = p.cyan_2, bg = g.editor.Normal.bg },
        SnacksNotifierTitleDebug      = { fg = p.orange_2, bg = g.editor.Normal.bg },
        SnacksNotifierTitleTrace      = { fg = p.blue_2, bg = g.editor.Normal.bg },
        SnacksNotifierIconError       = { fg = p.red_2, bg = g.editor.Normal.bg },
        SnacksNotifierIconWarn        = { fg = p.yellow_2, bg = g.editor.Normal.bg },
        SnacksNotifierIconInfo        = { fg = p.cyan_2, bg = g.editor.Normal.bg },
        SnacksNotifierIconDebug       = { fg = p.orange_2, bg = g.editor.Normal.bg },
        SnacksNotifierIconTrace       = { fg = p.blue_2, bg = g.editor.Normal.bg },
        SnacksNotifierBorderError     = { fg = p.red_2, bg = g.editor.Normal.bg },
        SnacksNotifierBorderWarn      = { fg = p.yellow_2, bg = g.editor.Normal.bg },
        SnacksNotifierBorderInfo      = { fg = p.cyan_2, bg = g.editor.Normal.bg },
        SnacksNotifierBorderDebug     = { fg = p.orange_2, bg = g.editor.Normal.bg },
        SnacksNotifierBorderTrace     = { fg = p.blue_2, bg = g.editor.Normal.bg },
        SnacksNotifierError           = { link = "Normal" },
        SnacksNotifierWarn            = { link = "Normal" },
        SnacksNotifierInfo            = { link = "Normal" },
        SnacksNotifierDebug           = { link = "Normal" },
        SnacksNotifierTrace           = { link = "Normal" },
        SnacksIndent                  = { fg = p.base_2 },
        SnacksIndent1                 = { fg = p.base_2 },
        SnacksIndent2                 = { fg = p.base_3 },
        SnacksIndent3                 = { fg = p.base_2 },
        SnacksIndent4                 = { fg = p.base_4 },
        SnacksIndent5                 = { fg = p.base_2 },
        SnacksIndent6                 = { fg = p.base_4 },
        SnacksIndent7                 = { fg = p.base_2 },
        SnacksIndent8                 = { fg = p.base_4 },
        SnacksIndentBlank             = { link = "Whitespace" },
        SnacksIndentScope             = { fg = p.violet_2 },

        -- quickscope.lua
        QuickScopePrimary             = { fg = p.base_0, bg = p.yellow_2, underline = true, reverse = true },
        QuickScopeSecondary           = { fg = p.base_0, bg = p.magenta_2, underline = true, reverse = true },

        -- satellite.nvim
        SatelliteBar                  = { bg = p.base_4 },
        SatelliteDiagnosticError      = { link = "DiagnosticSignError" },
        SatelliteDiagnosticWarn       = { link = "DiagnosticWarn" },
        SatelliteDiagnosticInfo       = { link = "DiagnosticInfo" },
        SatelliteDiagnosticHint       = { link = "DiagnosticHint" },
        SatelliteGitSignsDelete       = { link = "GitSignsDelete" },
        SatelliteGitSignsChange       = { link = "GitSignsChange" },
        SatelliteGitSignsAdd          = { link = "GitSignsAdd" },
        SatelliteQuickfix             = { link = "WarningMsg" },
        SatelliteSearch               = { fg = p.cyan_2 },
        SatelliteCursor               = { fg = p.base_fg },
        SatelliteMark                 = { fg = p.base_03 },

        -- telescope.nvim
        TelescopePromptPrefix         = { fg = p.base_fg, bold = true },
        TelescopePromptCounter        = { link = "Number" },

        TelescopeNormal               = { fg = p.base_fg, bg = p.base_0 },
        TelescopeResultsNormal        = { fg = p.blue_3, bg = p.base_0 },
        TelescopePreviewNormal        = { fg = p.base_fg, bg = p.base_0 },
        TelescopePromptNormal         = { fg = p.base_00, bg = p.base_2 },

        TelescopeResultsTitle         = { fg = p.cyan_2, bg = g.editor.FloatBorder.fg, bold = true },
        TelescopePreviewTitle         = { fg = p.blue_3, bg = g.editor.FloatBorder.fg, bold = true },
        TelescopePromptTitle          = { fg = p.base_fg, bg = g.editor.FloatBorder.fg, bold = true },

        TelescopeResultsBorder        = { fg = g.editor.FloatBorder.fg, bg = p.base_0 },
        TelescopePreviewBorder        = { fg = g.editor.FloatBorder.fg, bg = p.base_0 },
        TelescopePromptBorder         = { fg = g.editor.FloatBorder.fg, bg = p.base_2 },

        TelescopeMultiSelection       = { fg = p.base_00, bg = p.base_3 },
        TelescopeMultiIcon            = { fg = p.base_00, bg = p.base_3 },
        TelescopeSelectionCaret       = { link = "TelescopeSelectionCaret" },
        TelescopeSelection            = { link = "PmenuSel" },
        TelescopeMatching             = { fg = p.base_00 },

        -- todo-comments.nvim
        TodoBgFIX                     = { fg = p.base_0, bg = g.diagnostic.DiagnosticError.fg, bold = true },
        TodoFgFIX                     = { link = "DiagnosticError" },
        TodoSignFIX                   = { link = "DiagnosticError" },
        TodoBgNOTE                    = { fg = p.base_0, bg = g.diagnostic.DiagnosticHint.fg, bold = true },
        TodoFgNOTE                    = { link = "DiagnosticHint" },
        TodoSignNOTE                  = { link = "DiagnosticHint" },
        TodoBgWARN                    = { fg = p.base_0, bg = g.diagnostic.DiagnosticWarn.fg, bold = true },
        TodoFgWARN                    = { link = "DiagnosticWarn" },
        TodoSignWARN                  = { link = "DiagnosticWarn" },
        TodoBgPERF                    = { fg = p.base_0, bg = p.green_2, bold = true },
        TodoFgPERF                    = { fg = p.green_2 },
        TodoSignPERF                  = { fg = p.green_2 },
        TodoBgTODO                    = { fg = p.base_0, bg = g.diagnostic.DiagnosticInfo.fg, bold = true },
        TodoFgTODO                    = { link = "DiagnosticInfo" },
        TodoSignTODO                  = { link = "DiagnosticInfo" },
        TodoBgHACK                    = { fg = p.base_0, bg = g.diagnostic.DiagnosticWarn.fg, bold = true },
        TodoFgHACK                    = { link = "DiagnosticWarn" },
        TodoSignHACK                  = { link = "DiagnosticWarn" },

        -- trouble.nvim
        TroubleNormal                 = { link = "Normal" },
        TroubleNormalNC               = { link = "NormalNC" },
        TroubleFoldIcon               = { link = "FoldColumn" },
        TroubleIndent                 = { link = "FoldColumn" },

        -- vim-illuminate
        IlluminatedWordText           = { link = "LspReferenceText" },
        IlluminatedWordRead           = { link = "LspReferenceRead" },
        IlluminatedWordWrite          = { link = "LspReferenceWrite" },

        -- which-key.nvim
        WhichKey                      = { fg = p.base_fg, bold = true },
        WhichKeyBorder                = { link = "FloatBorder" },
        WhichKeyGroup                 = { fg = p.blue_2, bold = true },
        WhichKeyDesc                  = { fg = p.blue_3 },
        WhichKeySeparator             = { fg = p.base_4 },
        WhichKeyValue                 = { link = "Comment" },
        WhichKeyFloat                 = { link = "NormalFloat" },

        -- yeet.nvim
        YeetTitle                     = { fg = g.editor.Title.fg, bg = p.base_3, bold = g.editor.Title.bold },
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
