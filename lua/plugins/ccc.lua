local function setup(ccc)
    ccc.setup({
        highlighter = { auto_enable = true },
        pickers = {
            ccc.picker.custom_entries({
                draculaFg = "#f8f8f2",
                draculaFgDark = "#d8d8d3",
                draculaFgDarker = "#8f98b7",
                draculaComment = "#6272a4",
                draculaSelection = "#44475a",
                draculaBgLighter = "#3c3f50",
                draculaBgLight = "#333544",
                draculaBg = "#282a36",
                draculaBgDark = "#232531",
                draculaBgDarker = "#1e202b",
                draculaCyan = "#8be9fd",
                draculaGreen = "#50fa7b",
                draculaOrange = "#ffb86c",
                draculaPink = "#ff79c6",
                draculaPurple = "#bd93f9",
                draculaRed = "#ff5555",
                draculaYellow = "#f1fa8c",
                nord0darker = "#242933",
                nord0dark = "#2a303b",
                nord0 = "#2e3440",
                nord1dark = "#353b4a",
                nord1 = "#3b4252",
                nord2 = "#434c5e",
                nord3 = "#4c566a",
                nord3light = "#626e87",
                nord4dark = "#8695b3",
                nord4 = "#d8dee9",
                nord5 = "#e5e9f0",
                nord6 = "#eceff4",
                nord7 = "#8fbcbb",
                nord8 = "#88c0d0",
                nord9 = "#81a1c1",
                nord10 = "#5e81ac",
                nord11darker = "#3d3944",
                nord11dark = "#4b3d48",
                red = "#bf616a",
                nord12 = "#d08770",
                nord13darker = "#414348",
                nord13dark = "#54524f",
                nord13 = "#ebcb8b",
                nord14darker = "#3a4248",
                nord14dark = "#45504f",
                nord14 = "#a3be8c",
                nord15 = "#b48ead",
            }),
        },
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
