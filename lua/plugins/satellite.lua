return {
    {
        -- satellite.nvim
        -- satellite.nvim is a Neovim plugin that displays decorated scrollbars.
        "git@github.com:petrosAth/satellite.nvim.git",
        config = function()
            local loaded, satellite = pcall(require, "satellite")
            if not loaded then
                USER.loading_error_msg("satellite.nvim")
                return
            end

            satellite.setup({
                current_only = false,
                winblend = USER.styling.variables.transparency,
                zindex = 40,
            })
        end,
    },
}
