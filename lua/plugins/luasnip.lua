local function setup(luasnip)
    -- Load friendly-snippets
    require("luasnip/loaders/from_vscode").lazy_load()

    -- Cancel snippet session on ModeChanged event
    -- Source: https://github.com/L3MON4D3/LuaSnip/issues/656#issuecomment-1313310146
    -- Source: https://github.com/L3MON4D3/LuaSnip/issues/258#issuecomment-1011938524
    vim.api.nvim_create_autocmd("ModeChanged", {
        group = vim.api.nvim_create_augroup("UnlinkSnippetOnModeChange", { clear = true }),
        pattern = { "s:n", "i:*" },
        desc = "Forget the current snippet when leaving the insert mode",
        callback = function(evt)
            if luasnip.session and luasnip.session.current_nodes[evt.buf] and not luasnip.session.jump_active then
                luasnip.unlink_current()
            end
        end,
    })
end

return {
    {
        -- LuaSnip
        -- Snippet Engine for Neovim written in Lua.
        "L3MON4D3/LuaSnip",
        dependencies = {
            -- Friendly Snippets
            -- Snippets collection for a set of different programming languages for faster development.
            "rafamadriz/friendly-snippets",
        },
        config = function()
            local loaded, luasnip = pcall(require, "luasnip")
            if not loaded then
                USER.loading_error_msg("LuaSnip")
                return
            end

            setup(luasnip)
        end,
    },
}
