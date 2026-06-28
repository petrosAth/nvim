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
            backend = { "fzf_lua", "builtin", "nui" },
        },
    })
end

return {
    {
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
