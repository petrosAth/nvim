return {
    {
        -- hop
        -- Hop is an EasyMotion-like plugin allowing you to jump anywhere in a document with as few keystrokes as
        -- possible.
        "phaazon/hop.nvim",
        enabled = false,
        branch = "v2",
        config = function()
            require("hop").setup()
        end,
    },
}
