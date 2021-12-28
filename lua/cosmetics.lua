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
    git      = {
        staged    = { "", "" },
        unstaged  = { "", "" },
        untracked = { "", "ﮛ" },
        deleted   = { "", "" },
        renamed   = { "" }
    },
    loading  = {
        circle = {
            "◝", "◞", "◟", "◜"
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
        tab       = { "··" },          -- Two or three characters to be used to show a tab
        lead      = { "·" },           -- Character to show for leading spaces
        eol       = { "﬋" }            -- Character to show at the end of each line
    }
}

-- Table containing borders
M.border = {
    table    = { tl = "╭",  t = "─", tr = "╮",  r = "│", br = "╯",  b = "─", bl = "╰",  l = "│", ml = "├", mr = "┤" },
    single   = { tl = "┌",  t = "─", tr = "┐",  r = "│", br = "┘",  b = "─", bl = "└",  l = "│", ml = "├", mr = "┤" },
    round    = { tl = "╭",  t = "─", tr = "╮",  r = "│", br = "╯",  b = "─", bl = "╰",  l = "│", ml = "├", mr = "┤" },
    double   = { tl = "╔",  t = "═", tr = "╗",  r = "║", br = "╝",  b = "═", bl = "╚",  l = "║", ml = "╟", mr = "╢",      "╠",      "╣", },
    box      = { tl = "▛",  t = "▀", tr = "▜",  r = "▐", br = "▟",  b = "▄", bl = "▙",  l = "▌" }
}

vim.cmd [[autocmd ColorScheme * highlight NormalFloat guibg=none]]
vim.cmd [[autocmd ColorScheme * highlight FloatBorder guibg=none]]

-- Borders for LSP popup windows
local borders = {
    { M.border.table.tl, "FloatBorder" },
    { M.border.table.t,  "FloatBorder" },
    { M.border.table.tr, "FloatBorder" },
    { M.border.table.r,  "FloatBorder" },
    { M.border.table.br, "FloatBorder" },
    { M.border.table.b,  "FloatBorder" },
    { M.border.table.bl, "FloatBorder" },
    { M.border.table.l,  "FloatBorder" },
}

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...) opts = opts or {}
opts.border = opts.border or borders return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

function M.dracula()
	-- Set theme
	vim.cmd([[colorscheme dracula]])
end

return M
