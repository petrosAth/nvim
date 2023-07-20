local function setup(notify)
    local icons = USER.styling.icons
    local borders = USER.styling.borders.default

    notify.setup({
        -- Animation style (see below for details)
        stages = "slide",

        -- Function called when a new window is opened, use for changing win settings/config
        on_open = function(win)
            if vim.api.nvim_win_is_valid(win) then
                vim.api.nvim_win_set_config(win, {
                    border = {
                        { borders.tl, "FloatBorder" },
                        { borders.t, "FloatBorder" },
                        { borders.tr, "FloatBorder" },
                        { borders.r, "FloatBorder" },
                        { borders.br, "FloatBorder" },
                        { borders.b, "FloatBorder" },
                        { borders.bl, "FloatBorder" },
                        { borders.l, "FloatBorder" },
                    },
                })
            end
        end,

        -- Default timeout for notifications
        timeout = 1000,

        -- For stages that change opacity this is treated as the highlight behind the window
        -- Set this to either a highlight group or an RGB hex value e.g. "#000000"
        background_colour = "Normal",

        -- Minimum width for notification windows
        minimum_width = 50,

        -- Icons for the different levels
        icons = {
            ERROR = icons.lsp.error[1],
            WARN = icons.lsp.warn[1],
            INFO = icons.lsp.info[1],
            DEBUG = icons.bug[1],
            TRACE = icons.location[1],
        },
    })
end

return {
    {
        -- nvim-notify
        -- A fancy, configurable, notification manager for NeoVim
        "rcarriga/nvim-notify",
        config = function()
            local loaded, notify = pcall(require, "notify")
            if not loaded then
                USER.loading_error_msg("nvim-notify")
                return
            end

            setup(notify)

            vim.notify = notify
        end,
    },
}
