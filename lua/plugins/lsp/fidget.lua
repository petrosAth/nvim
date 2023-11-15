local M = {}

function M.setup(icons, borders)
    local loaded, fidget = pcall(require, "fidget")
    if not loaded then
        USER.loading_error_msg("fidget.nvim")
        return
    end

    fidget.setup({
        progress = {
            display = {
                done_icon = icons.lsp.loaded[1],
                done_style = "FidgetDone",
                progress_icon = { pattern = icons.loading.sphere },
                progress_style = "FidgetProgress",
            },
        },
        notification = {
            view = {
                icon_separator = " ",
                group_separator = "╴╴╴╴╴╴╴╴╴╴",
                group_separator_hl = "Comment",
            },
            window = {
                normal_hl = "FidgetNormal",
                winblend = USER.styling.variables.transparency,
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
                x_padding = 0,
            },
        },
    })
end

return M
