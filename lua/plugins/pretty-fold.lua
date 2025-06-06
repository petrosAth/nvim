local function setup(pretty_fold)
    pretty_fold.setup({
        fill_char = "·",
        sections = {
            left = { "content" },
            right = { " ", "number_of_folded_lines", " │ ", "percentage", " ····" },
        },

        remove_fold_markers = true,

        -- Keep the indentation of the content of the fold string.
        keep_indentation = true,

        -- Possible values:
        -- "delete" : Delete all comment signs from the fold string.
        -- "spaces" : Replace all comment signs with equal number of spaces.
        -- false    : Do nothing with comment signs.
        process_comment_signs = "spaces",

        -- Comment signs additional to the value of `&commentstring` option.
        comment_signs = {},

        -- List of patterns that will be removed from content foldtext section.
        stop_words = {
            "@brief%s*", -- (for C++) Remove '@brief' and all spaces after.
        },

        add_close_pattern = true, -- true, 'last_line' or false
        matchup_patterns = {
            -- beginning of the line -> any number of spaces -> 'do' -> end of the line
            { "^%s*do$", "end" }, -- `do ... end` blocks
            { "^%s*if", "end" }, -- if
            { "^%s*for", "end" }, -- for
            { "function%s*%(", "end" }, -- 'function( or 'function (''
            { "{", "}" },
            { "%(", ")" }, -- % to escape lua pattern char
            { "%[", "]" }, -- % to escape lua pattern char
        },
    })
end

return {
    {
        -- Pretty Fold is a lua plugin for Neovim which provides framework for easy foldtext customization. Filetype
        -- specific and foldmethod specific configuration is supported.
        -- "anuvyklack/pretty-fold.nvim",
        "bbjornstad/pretty-fold.nvim", -- fork
        config = function()
            local loaded, pretty_fold = pcall(require, "pretty-fold")
            if not loaded then
                USER.loading_error_msg("pretty-fold.nvim")
                return
            end

            setup(pretty_fold)
        end,
    },
}
