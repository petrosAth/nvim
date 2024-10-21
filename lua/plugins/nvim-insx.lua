local function use_cj_as_cr(insx)
    local function map(open, close)
        local esc = insx.helper.regex.esc
        insx.add(
            "<C-j>",
            require("insx.recipe.fast_break")({
                open_pat = esc(open),
                close_pat = esc(close),
                arguments = true,
                html_attrs = true,
                html_tags = true,
            })
        )
    end

    for open, close in pairs({
        ["("] = ")",
        ["["] = "]",
        ["{"] = "}",
    }) do
        map(open, close)
    end

    insx.add(
        "<C-j>",
        require("insx.recipe.fast_break")({
            open_pat = [[```\w*]],
            close_pat = "```",
            indent = 0,
        }),
        {
            insx.with.filetype({ "markdown" }),
        }
    )
end

local function setup(insx)
    require("insx.preset.standard").setup()
    use_cj_as_cr(insx)
end

return {
    {
        -- nvim-insx
        -- Flexible insert-mode key mapping manager
        "hrsh7th/nvim-insx",
        event = { "InsertEnter", "CmdlineEnter" },
        config = function()
            local loaded, insx = pcall(require, "insx")
            if not loaded then
                USER.loading_error_msg("nvim-insx")
                return
            end

            setup(insx)
        end,
    },
}
