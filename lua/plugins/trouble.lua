local function setup(trouble)
    local icons = USER.styling.icons
    local fillchars = icons.fillchars.global

    trouble.setup({
        auto_preview = false,
        win = {
            wo = {
                colorcolumn = "",
            },
        },
        icons = {
            indent = {
                top = "  ",
                middle = "  ",
                last = "  ",
                fold_open = fillchars.foldopen .. " ",
                fold_closed = fillchars.foldclose .. " ",
                ws = "  ",
            },
            folder_closed = icons.dir[1] .. " ",
            folder_open = icons.diropen[1] .. " ",
        },
    })
end

return {
    {
        -- A pretty list for showing diagnostics, references, telescope results, quickfix and location lists to help you
        -- solve all the trouble your code is causing.
        "folke/trouble.nvim",
        cmd = { "TroubleToggle", "Trouble" },
        config = function()
            local loaded, trouble = pcall(require, "trouble")
            if not loaded then
                USER.loading_error_msg("trouble.nvim")
                return
            end

            setup(trouble)
        end,
    },
}
