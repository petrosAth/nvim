local function setup(todo_comments, icons)
    todo_comments.setup({
        signs = true, -- show icons in the signs column
        sign_priority = 8, -- sign priority
        -- keywords recognized as todo comments
        keywords = {
            FIX = {
                icon = icons.bug[1], -- icon used for the sign, and in search results
                color = "error", -- can be a hex color, or a named color (see below)
                alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
                -- signs = false, -- configure signs for some keywords individually
            },
            TODO = { icon = icons.task[1], color = "info" },
            HACK = { icon = icons.hack[1], color = "warning" },
            WARN = { icon = icons.lsp.warn[1], color = "warning", alt = { "WARNING", "XXX" } },
            PERF = { icon = icons.performance[1], alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
            NOTE = { icon = icons.note[1], color = "hint", alt = { "INFO" } },
        },
    })
end

return {
    {
        -- Todo Comments
        -- todo-comments is a lua plugin for Neovim 0.5 to highlight and search for todo comments like TODO, HACK, BUG
        -- in your code base.
        "folke/todo-comments.nvim",
        event = { "BufReadPost" },
        cmd = { "TodoTrouble", "TodoTelescope" },
        dependencies = {
            -- plenary.nvim
            -- plenary: full; complete; entire; absolute; unqualified. All the lua functions I don't want to write
            -- twice.
            "nvim-lua/plenary.nvim",
        },
        config = function()
            local loaded, todo_comments = pcall(require, "todo-comments")
            if not loaded then
                USER.loading_error_msg("todo-comments.nvim")
                return
            end

            local icons = USER.styling.icons
            setup(todo_comments, icons)
        end,
    },
}
