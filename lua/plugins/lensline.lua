local function setup(lensline)
    lensline.setup({
        profiles = {
            {
                name = "default",
                providers = {
                    {
                        name = "usages",
                        enabled = true,
                        include = { "refs", "defs", "impls" },
                        breakdown = true,
                        show_zero = false,
                    },
                },
                style = {
                    highlight = "LensLine",
                    prefix = ("%s  "):format(USER.styling.icons.lsp.refs[1]),
                },
            },
        },
    })
end

return {
    {
        -- A lightweight plugin that displays contextual info (LSP reference counts)
        -- above functions, codelens style.
        "oribarilan/lensline.nvim",
        branch = "release/2.x",
        event = "LspAttach",
        config = function()
            local loaded, lensline = pcall(require, "lensline")
            if not loaded then
                USER.loading_error_msg("lensline.nvim")
                return
            end

            setup(lensline)
        end,
    },
}
