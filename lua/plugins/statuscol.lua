local function setup(statuscol)
    local builtin = require("statuscol.builtin")
    statuscol.setup({
        ft_ignore = { "vim" },
        bt_ignore = { "nofile" },
        segments = {
            {
                sign = {
                    name = { "Diagnostic" },
                    maxwidth = 1,
                    colwidth = 2,
                },
                click = "v:lua.ScSa",
            },
            {
                text = { "%s" },
                click = "v:lua.ScSa",
            },
            {
                text = { builtin.lnumfunc, " " },
                condition = { true, builtin.not_empty },
                click = "v:lua.ScLa",
            },
            {
                text = { builtin.foldfunc },
                condition = { true, builtin.not_empty },
                click = "v:lua.ScFa",
            },
            {
                sign = {
                    namespace = { "gitsigns" },
                    colwidth = 1,
                },
                click = "v:lua.ScSa",
            },
        },
    })
end

return {
    {
        -- statuscol.nvim
        -- Status column plugin that provides a configurable 'statuscolumn' and click handlers.
        "luukvbaal/statuscol.nvim",
        branch = "0.10",
        config = function()
            local loaded, statuscol = pcall(require, "statuscol")
            if not loaded then
                USER.loading_error_msg("statuscol.nvim")
                return
            end

            setup(statuscol)
        end,
    },
}
