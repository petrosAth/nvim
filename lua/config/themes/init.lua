local M = {}

function M.loadTerminalColors(themeName)
    local terminalColors = require("config.themes." .. themeName .. ".colors.terminal")

    terminalColors.load()
end

function M.loadHighlightGroups(themeName)
    local highlightGroups = require("config.themes." .. themeName .. ".colors.highlightGroups")

    for _, groups in pairs(highlightGroups) do
        for group, colors in pairs(groups) do
            vim.api.nvim_set_hl(0, group, colors)
        end
    end
end

function M.load(themeName)
    -- reset colors
    if vim.g.colors_name then
        vim.cmd("hi clear")
    end

    vim.o.termguicolors = true
    vim.g.colors_name = themeName

    M.loadTerminalColors(themeName)
    M.loadHighlightGroups(themeName)
end

return M
