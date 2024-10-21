return {
    {
        -- An always-on highlight for a unique character in every word on a line to help you use f, F and family.
        "unblevable/quick-scope",
        -- enabled = false,
        config = function()
            local g = vim.g

            g.qs_delay = 200
            g.qs_max_chars = 200
            g.qs_buftype_blacklist = {
                "terminal",
                "nofile",
            }
            g.qs_filetype_blacklist = {
                "alpha",
                "diff",
                "help",
                "minimap",
                "NvimTree",
                "Outline",
                "packer",
                "qf",
                "TelescopePrompt",
                "Trouble",
                "undotree",
            }
        end,
    },
}
