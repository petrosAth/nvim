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
                fold_open = string.format("%s ", fillchars.foldopen),
                fold_closed = string.format("%s ", fillchars.foldclose),
                ws = "  ",
            },
            folder_closed = string.format("%s ", icons.dir[1]),
            folder_open = string.format("%s ", icons.diropen[1]),
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
