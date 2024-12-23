local M = {}

function M.loadTerminalColors(palette)
    local terminalColors = require("themes.terminal")

    terminalColors.load(palette.terminal)
end

function M.loadHighlightGroups(palette)
    local highlightGroups = require("themes.highlightGroups")

    highlightGroups.load(palette.base)
end

function M.load(themeName)
    local palette = require(string.format("themes.palettes.%s", themeName))

    -- reset colors
    if vim.g.colors_name then
        vim.cmd("hi clear")
    end

    vim.g.colors_name = themeName

    M.loadTerminalColors(palette)
    M.loadHighlightGroups(palette)
end

return M
