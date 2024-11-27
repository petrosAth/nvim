local M = {}

function M.setup()
    local loaded, nvim_lightbulb = pcall(require, "nvim-lightbulb")
    if not loaded then
        USER.loading_error_msg("nvim-lightbulb")
        return
    end

    local icons = USER.styling.icons

    nvim_lightbulb.setup({
        code_lenses = true,
        sign = {
            enabled = true,
            text = icons.lsp.action[1],
            lens_text = "🔎",
        },
        virtual_text = {
            enabled = true,
            text = icons.lsp.action[1],
            lens_text = "🔎",
        },
        autocmd = {
            enabled = true,
        },
        ignore = {
            clients = {},
            ft = {},
        },
    })
end

return M
