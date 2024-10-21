local function setup(ccc)
    local mapping = ccc.mapping
    local border = USER.styling.borders
    local config = {
        bar_char = border.singlefat.t,
        point_char = USER.styling.icons.slider[1],
        win_opts = {
            border = {
                border.default.tl,
                border.default.t,
                border.default.tr,
                border.default.r,
                border.default.br,
                border.default.b,
                border.default.bl,
                border.default.l,
            },
        },
        highlighter = {
            auto_enable = true,
        },
        mappings = {
            ["d"] = mapping.none,
            ["s"] = mapping.none,
            ["m"] = mapping.none,
            [","] = mapping.none,
            ["l"] = mapping.increase1,
            [">"] = mapping.increase5,
            ["+"] = mapping.increase10,
            ["h"] = mapping.decrease1,
            ["<"] = mapping.decrease5,
            ["-"] = mapping.decrease10,
            ["L"] = mapping.set0,
            ["M"] = mapping.set50,
            ["H"] = mapping.set100,
        },
    }

    if next(USER.local_config.palettes) then
        config.pickers = {
            ccc.picker.hex,
            ccc.picker.css_rgb,
            ccc.picker.css_hsl,
            ccc.picker.css_hwb,
            ccc.picker.css_lab,
            ccc.picker.css_lch,
            ccc.picker.css_oklab,
            ccc.picker.css_oklch,
            ccc.picker.custom_entries(USER.local_config.palettes),
        }
    end

    ccc.setup(config)
end

return {
    {
        -- ccc.nvim
        -- Super powerful color picker / colorizer plugin.
        "uga-rosa/ccc.nvim",
        cmd = {
            "CccPick",
            "CccConvert",
            "CccHighlighterEnable",
            "CccHighlighterToggle",
            "CccHighlighterDisable",
        },
        ft = {
            "css",
            "html",
        },
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
