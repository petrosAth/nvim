return {
    {
        -- A plugin that leverages Neovim's built-in RPC functionality to simplify opening files from within Neovim's
        -- terminal emulator without nesting sessions.
        "samjwill/nvim-unception",
        config = function()
            vim.g.unception_delete_replaced_buffer = true
        end,
    },
}
