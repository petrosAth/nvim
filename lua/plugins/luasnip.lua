local function setup(luasnip)
    -- Load friendly-snippets
    require("luasnip/loaders/from_vscode").lazy_load()
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
