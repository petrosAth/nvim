local function setup(satellite, icons)
    satellite.setup({
        current_only = false,
        winblend = USER.styling.variables.transparency,
        zindex = 40,
        handlers = {
            gitsigns = {
                signs = {
                    add = icons.add,
                    change = icons.change,
                    delete = icons.delete,
                },
            },
        },
    })
end

return {
    {
        -- satellite.nvim
        -- satellite.nvim is a Neovim plugin that displays decorated scrollbars.
        "lewis6991/satellite.nvim",
        config = function()
            local loaded, satellite = pcall(require, "satellite")
            if not loaded then
                USER.loading_error_msg("satellite.nvim")
                return
            end

            local icons = USER.styling.icons.git.signs.satellite
            setup(satellite, icons)
        end,
    },
}
