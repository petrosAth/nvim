local function setup(yeet)
    local borders = USER.styling.borders.default
    local width = math.min(math.ceil(0.8 * vim.o.columns), 100)
    local height = math.min(math.ceil(0.8 * vim.o.lines), 20)

    yeet.setup({
        cache_window_opts = {
            relative = "editor",
            row = (vim.o.lines - height) * 0.5,
            col = (vim.o.columns - width) * 0.5,
            width = width,
            height = height,
            border = {
                borders.tl,
                borders.t,
                borders.tr,
                borders.r,
                borders.br,
                borders.b,
                borders.bl,
                borders.l,
            },
            title = { { " Command Cache ", "YeetTitle" } },
            title_pos = "center",
        },
    })
end

return {
    "samharju/yeet.nvim",
    dependencies = {
        -- Neovim plugin to improve the default vim.ui interfaces
        "stevearc/dressing.nvim",
    },
    version = "*",
    cmd = "Yeet",
    config = function()
        local loaded, yeet = pcall(require, "yeet")
        if not loaded then
            USER.loading_error_msg("yeet.nvim")
            return
        end

        setup(yeet)
    end,
}
