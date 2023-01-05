local M = {}

function M.setup()
    local loaded, neoscroll = pcall(require, "neoscroll")
    if not loaded then
        USER.loading_error_msg("neoscroll.nvim")
        return
    end

    neoscroll.setup({
        easing_function = "quadratic", -- Default easing function (`quadratic`, `cubic`, `quartic`, `quintic`, `circular`, `sine`)
    })

    local t = {}

    t["<C-y>"] = { "scroll", { "-0.10",                           "false", "80"  }}
    t["<C-e>"] = { "scroll", { "0.10",                            "false", "80"  }}
    t["<C-u>"] = { "scroll", { "-vim.wo.scroll",                  "true",  "150" }}
    t["<C-d>"] = { "scroll", { "vim.wo.scroll",                   "true",  "150" }}
    t["<C-b>"] = { "scroll", { "-vim.api.nvim_win_get_height(0)", "true",  "300" }}
    t["<C-f>"] = { "scroll", { "vim.api.nvim_win_get_height(0)",  "true",  "300" }}
    -- t["G"]     = { "scroll", { "vim.fn.line('$')",                "true",  "1"   }}
    -- t["gg"]    = { "gg",     {                                             "1"   }}
    t["zt"]    = { "zt",     {                                             "150" }}
    t["zz"]    = { "zz",     {                                             "150" }}
    t["zb"]    = { "zb",     {                                             "150" }}

    require("neoscroll.config").set_mappings(t)
end

return M
