local function setup(flash)
    flash.setup({
        labels = "fjdkslaruvmgheiwoxqpbnz",
        search = {
            incremental = false,
            exclude = {
                "notify",
                "cmp_menu",
                "noice",
                "flash_prompt",
                function(win)
                    -- exclude non-focusable windows
                    return not vim.api.nvim_win_get_config(win).focusable
                end,
            },
        },
        jump = {
            autojump = true,
        },
        highlight = {
            -- show a backdrop with hl FlashBackdrop
            backdrop = true,
            -- Highlight the search matches
            matches = true,
            -- extmark priority
            priority = 5000,
            groups = {
                match = "FlashMatch",
                current = "FlashCurrent",
                backdrop = "FlashBackdrop",
                label = "FlashLabel",
            },
        },
        -- You can override the default options for a specific mode.
        -- Use it with `require("flash").jump({mode = "forward"})`
        ---@type table<string, Flash.Config>
        modes = {
            char = {
                jump_labels = function(motion)
                    return false
                    -- return vim.v.count == 0 and motion:find("[ftFT]")
                end,
            },
        },
        char = {
            enabled = false,
        },
        -- options for the floating window that shows the prompt,
        -- for regular jumps
        prompt = {
            prefix = { { "󰉁 ", "FlashPromptIcon" } },
        },
    })
end

return {
    {
        -- flash.nvim
        -- Navigate your code with search labels, enhanced character motions and Treesitter integration
        "folke/flash.nvim",
        enabled = false,
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
