local function setup(dressing)
    local winblend = USER.styling.variables.transparency
    local borders = USER.styling.borders

    dressing.setup({
        input = {
            enabled = false,
            border = {
                borders.default.tl,
                borders.default.t,
                borders.default.tr,
                borders.default.r,
                borders.default.br,
                borders.default.b,
                borders.default.bl,
                borders.default.l,
            },
            relative = "cursor",
            prefer_width = 40,
            width = nil,
            max_width = { 140, 0.9 },
            min_width = { 20, 0.2 },
            win_options = {
                winblend = winblend,
            },
        },
        select = {
            enabled = true,
            backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },
            telescope = require("telescope.themes").get_dropdown({
                previewer = false,
                results_title = false,
                layout_strategy = "vertical",
                layout_config = {
                    prompt_position = "top",
                    width = {
                        0.6,
                        min = 90,
                        max = 110,
                    },
                    height = {
                        0.5,
                        min = 20,
                        max = 40,
                    },
                },
                borderchars = {
                    prompt = {
                        borders.default.t,
                        borders.default.r,
                        borders.none.b,
                        borders.default.l,
                        borders.default.tl,
                        borders.default.tr,
                        borders.default.r,
                        borders.default.l,
                    },
                    results = {
                        borders.default.t,
                        borders.default.r,
                        borders.default.b,
                        borders.default.l,
                        borders.default.tl,
                        borders.default.tr,
                        borders.default.br,
                        borders.default.bl,
                    },
                    preview = {
                        borders.default.t,
                        borders.default.r,
                        borders.none.b,
                        borders.default.l,
                        borders.default.tl,
                        borders.default.tr,
                        borders.default.r,
                        borders.default.l,
                    },
                },
            }),
        },
    })
end

return {
    {
        -- Dressing.nvim
        -- Neovim plugin to improve the default vim.ui interfaces
        "stevearc/dressing.nvim",
        config = function()
            local loaded, dressing = pcall(require, "dressing")
            if not loaded then
                USER.loading_error_msg("dressing.nvim")
                return
            end

            setup(dressing)
        end,
    },
}
