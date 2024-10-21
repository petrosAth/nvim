local function setup(hlslens)
    local icons = USER.styling.icons

    hlslens.setup({
        -- When to open the floating window for the nearest lens.
        -- 'auto': floating window will be opened if room isn't enough for virtual text;
        -- 'always': always use floating window instead of virtual text;
        -- 'never': never use floating window for the nearest lens,
        nearest_float_when = "never",
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
                    sfw ~= (relIdx > 0) and icons.arrow.hollow.u or icons.arrow.hollow.b
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
        -- nvim-hlslens helps you better glance at matched information, seamlessly jump between matched instances.
        "kevinhwang91/nvim-hlslens",
        config = function()
            local loaded, hlslens = pcall(require, "hlslens")
            if not loaded then
                USER.loading_error_msg("nvim-hlslens")
                return
            end

            setup(hlslens)
        end,
    },
}
