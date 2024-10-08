local function setup(Comment)
    Comment.setup({
        ---Pre-hook, called before commenting the line
        ---@type function
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    })
end

return {
    {
        -- Comment.nvim
        -- Smart and powerful comment plugin for neovim. Supports treesitter, dot repeat, left-right/up-down motions,
        -- hooks, and more
        "numToStr/Comment.nvim",
        config = function()
            local loaded, Comment = pcall(require, "Comment")
            if not loaded then
                USER.loading_error_msg("Comment.nvim")
                return
            end

            setup(Comment)
        end,
    },
}
