local nvim_web_devicons_loaded, nvim_web_devicons = pcall(require, "nvim-web-devicons")

if not nvim_web_devicons_loaded then
    require("notify")("nvim-web-devicons plugin is missing", "error", { title = "nvim-web-devicons" })
    return
end

nvim_web_devicons.setup({
    -- your personnal icons can go here (to override)
    -- you can specify color or cterm_color instead of specifying both of them
    -- DevIcon will be appended to `name`
    -- override = {
    --     zsh = {
    --         icon = "",
    --         color = "#428850",
    --         cterm_color = "65",
    --         name = "Zsh",
    --     },
    -- },
    -- globally enable default icons (default to false)
    -- will get overriden by `get_icons` option
    default = false,
})
