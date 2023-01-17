local t = {
    ["<C-y>"] = { "scroll", { "-0.10", "false", "80" } },
    ["<C-e>"] = { "scroll", { "0.10", "false", "80" } },
    ["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "150" } },
    ["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "150" } },
    ["<C-b>"] = { "scroll", { "-vim.api.nvim_win_get_height(0)", "true", "300" } },
    ["<C-f>"] = { "scroll", { "vim.api.nvim_win_get_height(0)", "true", "300" } },
    -- ["G"] = { "scroll", { "vim.api.nvim_buf_line_count(0)", "true", "1000" } },
    -- ["gg"] = { "scroll", { "-vim.api.nvim_buf_line_count(0)", "true", "1000" } },
    ["zt"] = { "zt", { "150" } },
    ["zz"] = { "zz", { "150" } },
    ["zb"] = { "zb", { "150" } },
}

return {
    {
        -- Neoscroll
        -- Smooth scrolling neovim plugin written in lua
        "karb94/neoscroll.nvim",
        enabled = false,
        config = function()
            local loaded, neoscroll = pcall(require, "neoscroll")
            if not loaded then
                USER.loading_error_msg("neoscroll.nvim")
                return
            end

            neoscroll.setup({
                easing_function = "quintic", -- Default easing function (`quadratic`, `cubic`, `quartic`, `quintic`, `circular`, `sine`)
            })

            require("neoscroll.config").set_mappings(t)
        end,
    },
}
