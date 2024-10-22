local function setup(flash)
    flash.setup({
        labels = "fjdkslaruvmgheiwoxqpbnz",
        search = {
            exclude = {
                "notify",
                "cmp_menu",
                "noice",
                "flash_prompt",
                function(win) return not vim.api.nvim_win_get_config(win).focusable end,
            },
        },
        jump = {
            autojump = true,
        },
        prompt = {
            prefix = { { "󰉁 ", "FlashPromptIcon" } },
        },
    })
end

return {
    {
        -- Navigate your code with search labels, enhanced character motions and Treesitter integration
        "folke/flash.nvim",
        event = "VeryLazy",
        config = function()
            local loaded, flash = pcall(require, "flash")
            if not loaded then
                USER.loading_error_msg("flash.nvim")
                return
            end

            setup(flash)
        end,
    },
}
