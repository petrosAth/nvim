local M = {}

function M.setup()
    local loaded, notify = pcall(require, "notify")
    if not loaded then
        USER.loading_error_msg("nvim-notify")
        return
    end

    local i = USER.styling.icons
    local b = USER.styling.borders.default

    notify.setup({
        -- Animation style (see below for details)
        stages = "slide",

        -- Function called when a new window is opened, use for changing win settings/config
        on_open = function(win)
            if vim.api.nvim_win_is_valid(win) then
                vim.api.nvim_win_set_config(win, {
                    border = {
                        { b.tl, "FloatBorder" },
                        { b.t, "FloatBorder" },
                        { b.tr, "FloatBorder" },
                        { b.r, "FloatBorder" },
                        { b.br, "FloatBorder" },
                        { b.b, "FloatBorder" },
                        { b.bl, "FloatBorder" },
                        { b.l, "FloatBorder" },
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
            ERROR = i.lsp.error[1],
            WARN = i.lsp.warn[1],
            INFO = i.lsp.info[1],
            DEBUG = i.bug[1],
            TRACE = i.location[1],
        },
    })

    vim.notify = notify
end

return M
