-- vim.cmd([[
--     augroup ILLUMINATE
--         autocmd ColorScheme *
--                 \ highlight illuminatedWord cterm=underline ctermbg=238 gui=underline guibg=#424450 |
--                 \ highlight illuminatedCurWord cterm=underline gui=underline
--     augroup END
-- ]])
--
local g = vim.g

g.Illuminate_delay = 200 -- Time in milliseconds (default 0)
-- g.Illuminate_insert_mode_highlight = 1
g.Illuminate_ftblacklist = {
    "alpha",
    "minimap",
    "NvimTree",
    "Outline",
    "TelescopePrompt"
}
