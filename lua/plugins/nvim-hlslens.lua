local function setup(hlslens, icons)
    hlslens.setup({
        auto_enable = true,
        enable_incsearch = true,
        -- When the cursor is out of the position range of the matched instance
        -- and calm_down is true, clear all lens,
        calm_down = true,
        -- When to open the floating window for the nearest lens.
        -- 'auto': floating window will be opened if room isn't enough for virtual text;
        -- 'always': always use floating window instead of virtual text;
        -- 'never': never use floating window for the nearest lens,
        nearest_float_when = "never",
        -- Winblend of the nearest floating window. `:h winbl` for more details,
        float_shadow_blend = 50,
        -- Priority of virtual text, set it lower to overlay others.
        --     `:h nvim_buf_set_extmark` for more details,
        virt_priority = 100,
        -- Hackable function for customizing the lens. If you like hacking, you
        --     should search `override_lens` and inspect the corresponding source code.
        --     There's no guarantee that this function will not be changed in the future. If it is
        --     changed, it will be listed in the CHANGES file.,
        override_lens = function(render, posList, nearest, idx, relIdx)
            local sfw = vim.v.searchforward == 1
            local indicator, text, chunks
            local absRelIdx = math.abs(relIdx)
            if absRelIdx > 0 then
                indicator = ("%d%s"):format(
                    absRelIdx,
                    sfw ~= (relIdx > 0) and icons.arrow.hollow.u or icons.arrow.hollow.d
                )
            else
                indicator = icons.arrow.hollow.r
            end

            local lnum, col = unpack(posList[idx])
            if nearest then
                local cnt = #posList
                if indicator ~= "" then
                    text = (" %s▕ %d/%d "):format(indicator, idx, cnt)
                else
                    text = (" %d/%d "):format(idx, cnt)
                end
                chunks = { { " ", "Ignore" }, { text, "HlSearchLensNear" } }
            else
                text = (" %s▕ %d "):format(indicator, idx)
                chunks = { { " ", "Ignore" }, { text, "HlSearchLens" } }
            end
            render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
        end,
    })
end

return {
    {
        -- nvim-hlslens
        -- nvim-hlslens helps you better glance at matched information, seamlessly jump between matched instances.
        "kevinhwang91/nvim-hlslens",
        config = function()
            local loaded, hlslens = pcall(require, "hlslens")
            if not loaded then
                USER.loading_error_msg("nvim-hlslens")
                return
            end

            local icons = USER.styling.icons
            setup(hlslens, icons)
        end,
    },
}
