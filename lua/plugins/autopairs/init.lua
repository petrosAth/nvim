local function config_cmp()
    local loaded, cmp = pcall(require, "cmp")
    if not loaded then
        USER.loading_error_msg("nvim-cmp")
        return
    end

    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

return {
    {
        -- nvim-autopairs
        -- A super powerful autopair for Neovim. It supports multiple characters
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            local loaded, nvim_autopairs = pcall(require, "nvim-autopairs")
            if not loaded then
                USER.loading_error_msg("nvim-autopairs")
                return
            end

            config_cmp()

            nvim_autopairs.setup({
                map_cr = true,
                map_c_h = true,
                map_c_w = true,
            })

            require("plugins.autopairs.rules").add_rules()
        end,
    },
}
