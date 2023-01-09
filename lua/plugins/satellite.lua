return {
    {
        "petrosAth/satellite.nvim",
        config = function()
            local loaded, satellite = pcall(require, "satellite")
            if not loaded then
                USER.loading_error_msg("satellite.nvim")
                return
            end

            satellite.setup({
                current_only = true,
                winblend = USER.styling.variables.transparency,
                zindex = 40,
                handlers = {
                    marks = {
                        enable = false,
                    },
                },
            })
        end,
    },
}
