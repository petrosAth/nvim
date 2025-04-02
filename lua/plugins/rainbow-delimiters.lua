local function setup(rainbow_delimiters)
    vim.g.rainbow_delimiters = {
        strategy = {
            [""] = function()
                if vim.fn.line("$") > 10000 then return nil end

                return rainbow_delimiters.strategy["global"]
            end,
            html = function() return nil end,
            htmldjango = function() return nil end,
        },
        query = {
            [""] = "rainbow-delimiters",
        },
        highlight = {
            "rainbowclr1",
            "rainbowclr2",
            "rainbowclr3",
            "rainbowclr4",
        },
    }
end

return {
    -- Rainbow delimiters for Neovim with Tree-sitter
    "hiphish/rainbow-delimiters.nvim",
    event = { "BufReadPost" },
    dependencies = {
        -- The goal of nvim-treesitter is both to provide a simple and easy way to use the interface for tree-sitter in
        -- Neovim and to provide some basic functionality such as highlighting based on it
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        local loaded, rainbow_delimiters = pcall(require, "rainbow-delimiters")
        if not loaded then
            USER.loading_error_msg("rainbow-delimiters.nvim")
            return
        end

        setup(rainbow_delimiters)
    end,
}
