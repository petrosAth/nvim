local function setup(satellite, icons)
    satellite.setup({
        current_only = false,
        winblend = USER.styling.variables.transparency,
        zindex = 40,
        handlers = {
            diagnostic = {
                signs = {
                    icons.lsp.diagnostics[1],
                    icons.lsp.diagnostics[1],
                    icons.lsp.diagnostics[1],
                },
            },
            gitsigns = {
                signs = {
                    add = icons.git.signs.add,
                    change = icons.git.signs.change,
                    delete = icons.git.signs.delete,
                },
            },
        },
    })
end

local function add_autocmd()
    local augroup = vim.api.nvim_create_augroup
    local autocmd = vim.api.nvim_create_autocmd

    local RefreshScrollBar = augroup("RefreshScrollBar", { clear = true })
    autocmd({ "BufEnter", "BufLeave", "FocusGained", "FocusLost", "WinEnter", "WinLeave" }, {
        group = RefreshScrollBar,
        desc = "Refresh satellite while navigating through Neovim.",
        command = "SatelliteRefresh",
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

            local icons = USER.styling.icons
            setup(satellite, icons)
            add_autocmd()
        end,
    },
}
