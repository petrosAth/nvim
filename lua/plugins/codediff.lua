local function setup(codediff)
    local icons = USER.styling.icons

    codediff.setup({
        highlights = {
            line_insert = "DiffChange", -- yellow bg in this theme (DiffAdd has only `sp`, no bg)
            line_delete = "DiffDelete", -- red bg
        },
        diff = {
            layout = "side-by-side",
            compute_moves = true, -- detect and mark moved code blocks
        },
        explorer = { -- was diffview's file_panel
            position = "left",
            width = 35,
            view_mode = "tree",
            flatten_dirs = true,
            indent_markers = true,
            auto_refresh = true,
            icons = {
                folder_closed = icons.dir[1],
                folder_open = icons.diropen[1],
            },
        },
        history = { -- was diffview's file_history_panel
            position = "bottom",
            height = 16,
        },
        -- in-UI keymaps use codediff defaults
    })
end

return {
    {
        -- VSCode-style diff engine: character-level highlights and moved-code detection.
        "esmuellert/codediff.nvim",
        cmd = "CodeDiff",
        config = function()
            local loaded, codediff = pcall(require, "codediff")
            if not loaded then
                USER.loading_error_msg("codediff.nvim")
                return
            end

            setup(codediff)
        end,
    },
}
