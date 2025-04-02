local function setup(codewindow)
    local borders = USER.styling.borders.default

    codewindow.setup({
        exclude_filetypes = { -- Choose certain filetypes to not show minimap on
            "aerial",
            "alpha",
            "DiffviewFileHistory",
            "DiffviewFiles",
            "diff",
            "help",
            "minimap",
            "neo-tree",
            "NvimTree",
            "Outline",
            "qf",
            "TelescopePrompt",
            "terminal",
            "trouble",
            "undotree",
        },
        minimap_width = 15, -- The width of the text part of the minimap
        width_multiplier = 4, -- How many characters one dot represents
        z_index = 45, -- The z-index the floating window will be on
        screen_bounds = "background",
        window_border = { -- The border style of the floating window (accepts all usual options)
            borders.tl,
            borders.t,
            borders.tr,
            borders.r,
            borders.br,
            borders.b,
            borders.bl,
            borders.l,
        },
    })
end

return {
    {
        -- Codewindow.nvim is a minimap plugin for neovim, that is closely integrated with treesitter and the builtin
        -- LSP to display more information to the user.
        "gorbit99/codewindow.nvim",
        keys = {
            "<Space>m",
        },
        config = function()
            local loaded, codewindow = pcall(require, "codewindow")
            if not loaded then
                USER.loading_error_msg("codewindow.nvim")
                return
            end

            setup(codewindow)
        end,
    },
}
