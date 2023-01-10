local function setup(dressing, borders, winblend)
    dressing.setup({
        input = {
            -- Set to false to disable the vim.ui.input implementation
            enabled = false,

            -- These are passed to nvim_open_win
            anchor = "SW",
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
            -- 'editor' and 'win' will default to being centered
            relative = "cursor",

            -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
            prefer_width = 40,
            width = nil,
            -- min_width and max_width can be a list of mixed types.
            -- min_width = {20, 0.2} means "the greater of 20 columns or 20% of total"
            max_width = { 140, 0.9 },
            min_width = { 20, 0.2 },

            -- Window transparency (0-100)
            win_options = {
                winblend = winblend,
            },
        },
        select = {
            -- Set to false to disable the vim.ui.select implementation
            enabled = true,

            -- Priority list of preferred vim.select implementations
            backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },

            -- Options for telescope selector
            -- These are passed into the telescope picker directly. Can be used like:
            -- telescope = require('telescope.themes').get_ivy({...})
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

            local winblend = USER.styling.variables.transparency
            local borders = USER.styling.borders
            setup(dressing, borders, winblend)
        end,
    },
}
