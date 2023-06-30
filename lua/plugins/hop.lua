local function setup(hop)
    hop.setup({
        keys = "fjdkslaruvmgheiwoxqpbnz",
    })
end

return {
    {
        -- hop
        -- Hop is an EasyMotion-like plugin allowing you to jump anywhere in a document with as few keystrokes as
        -- possible.
        "phaazon/hop.nvim",
        -- enabled = false,
        branch = "v2",
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
