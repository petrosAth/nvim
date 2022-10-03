-- Source:
-- https://github.com/shaunsingh/nord.nvim/blob/db98740c9429232508a25a98b7d41705f4d2fc1c/lua/nord/util.lua

local theme = {}

-- Go trough the table and highlight the group with the color values
theme.highlight = function(group, color)
    local style = color.style and "gui=" .. color.style or "gui=NONE"
    local fg = color.fg and "guifg=" .. color.fg or "guifg=NONE"
    local bg = color.bg and "guibg=" .. color.bg or "guibg=NONE"
    local sp = color.sp and "guisp=" .. color.sp or ""

    local hl = "highlight " .. group .. " " .. style .. " " .. fg .. " " .. bg .. " " .. sp

    vim.cmd(hl)
    if color.link then
        vim.cmd("highlight! link " .. group .. " " .. color.link)
    end
end

-- Only define nord if it's the active colorscheme
function theme.loadColorScheme()
    if vim.g.colors_name ~= "nord" then
        vim.cmd([[autocmd! nord]])
        vim.cmd([[augroup! nord]])
    end
end

function theme.loadTerminalColors(themeName)
    local terminalColors = require("config.themes." .. themeName .. ".highlights.terminal")

    terminalColors.load()
end

function theme.loadHighlightGroups(themeName)
    local highlightGroups = require("config.themes." .. themeName .. ".highlights.highlightGroups")

    for _, groups in pairs(highlightGroups) do
        for group, colors in pairs(groups) do
            -- theme.highlight(group, colors)
            vim.api.nvim_set_hl(0, group, colors)
        end
    end
end

function theme.load(themeName)
    vim.cmd("hi clear")
    if vim.fn.exists("syntax_on") then
        vim.cmd("syntax reset")
    end

    vim.o.termguicolors = true
    vim.g.colors_name = themeName

    theme.loadTerminalColors(themeName)

    theme.loadHighlightGroups(themeName)
end

return theme
