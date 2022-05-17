require("neoscroll").setup({
    easing_function = "quadratic", -- Default easing function (`quadratic`, `cubic`, `quartic`, `quintic`, `circular`, `sine`)
})

local t = {}

t["<C-u>"] = { "scroll", { "-vim.wo.scroll",                  "true",  "100" }}
t["<C-d>"] = { "scroll", { "vim.wo.scroll",                   "true",  "100" }}
t["<C-b>"] = { "scroll", { "-vim.api.nvim_win_get_height(0)", "true",  "100" }}
t["<C-f>"] = { "scroll", { "vim.api.nvim_win_get_height(0)",  "true",  "100" }}
t["<C-y>"] = { "scroll", { "-0.10",                           "false", "100" }}
t["<C-e>"] = { "scroll", { "0.10",                            "false", "100" }}
t["G"]     = { "scroll", { "vim.fn.line('$')",                "true",  "1"   }}
t["gg"]    = { "gg",     {                                             "1"   }}
t["zt"]    = { "zt",     {                                             "100" }}
t["zz"]    = { "zz",     {                                             "100" }}
t["zb"]    = { "zb",     {                                             "100" }}

require("neoscroll.config").set_mappings(t)
