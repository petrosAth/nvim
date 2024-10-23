local function setup(satellite)
    local icons = USER.styling.icons

    satellite.setup({
        winblend = USER.styling.variables.transparency,
        handlers = {
            cursor = {
                enable = false,
            },
            diagnostic = {
                signs = {
                    icons.lsp.diagnostics[1],
                    icons.lsp.diagnostics[1],
                    icons.lsp.diagnostics[1],
                },
            },
            gitsigns = {
                signs = {
                    add = icons.git.signs.satellite.add,
                    change = icons.git.signs.satellite.change,
                    delete = icons.git.signs.satellite.delete,
                },
            },
        },
    })
end

return {
    {
        -- satellite.nvim is a Neovim plugin that displays decorated scrollbars.
        "lewis6991/satellite.nvim",
        config = function()
            local loaded, satellite = pcall(require, "satellite")
            if not loaded then
                USER.loading_error_msg("satellite.nvim")
                return
            end

            setup(satellite)
        end,
    },
}
