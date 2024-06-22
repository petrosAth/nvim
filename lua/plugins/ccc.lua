local function setup(ccc)
    local cfg = {
        highlighter = {
            auto_enable = true,
        },
    }

    if next(USER.local_config.palettes) ~= nil then
        cfg.pickers = {
            ccc.picker.custom_entries(USER.local_config.palettes),
        }
    end

    ccc.setup(cfg)
end

return {
    {
        -- ccc.nvim
        -- Super powerful color picker / colorizer plugin.
        "uga-rosa/ccc.nvim",
        -- lazy = true,
        cmd = {
            "CccPick",
            "CccConvert",
            "CccHighlighterEnable",
            "CccHighlighterToggle",
            "CccHighlighterDisable",
        },
        ft = {
            "css",
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
