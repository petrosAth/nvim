local function setup(hop)
    hop.setup({
        keys = "fjdkslaruvmgheiwoxqpbnz",
    })
end

return {
    {
        -- Hop is an EasyMotion-like plugin allowing you to jump anywhere in a document with as few keystrokes as
        -- possible.
        "smoka7/hop.nvim",
        -- enabled = false,
        event = "VeryLazy",
        config = function()
            local loaded, hop = pcall(require, "hop")
            if not loaded then
                USER.loading_error_msg("hop.nvim")
                return
            end

            setup(hop)
        end,
    },
}
