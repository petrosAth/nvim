local function setup(ccc)
    ccc.setup({
        highlighter = { auto_enable = true },
    })
end

return {
    {
        -- ccc.nvim
        -- Super powerful color picker / colorizer plugin.
        "uga-rosa/ccc.nvim",
        config = function()
            local loaded, ccc = pcall(require, "ccc")
            if not loaded then
                USER.loading_error_msg("ccc.nvim")
                return
            end

            setup(ccc)
        end,
    },
}
