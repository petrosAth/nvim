local M = {}

function M.setup(icons, borders)
    local loaded, glance = pcall(require, "glance")
    if not loaded then
        USER.loading_error_msg("glance.nvim")
        return
    end

    local actions = glance.actions
    local fillchars = icons.fillchars.global
    glance.setup({
        -- height = 18, -- Height of the window
        height = 20, -- Height of the window
        zindex = 45,
        preview_win_opts = { -- Configure preview window options
            cursorline = true,
            number = true,
            wrap = true,
        },
        border = {
            enable = true, -- Show window borders. Only horizontal borders allowed
            -- top_char = borders.t,
            top_char = "",
            bottom_char = borders.b,
        },
        list = {
            position = "left", -- Position of the list window 'left'|'right'
            width = 0.33, -- 33% width relative to the active window, min 0.1, max 0.5
        },
        theme = { -- This feature might not work properly in nvim-0.7.2
            enable = true, -- Will generate colors for the plugin based on your current colorscheme
            mode = "auto", -- 'brighten'|'darken'|'auto', 'auto' will set mode based on the brightness of your colorscheme
        },
        mappings = {
            list = {
                ["j"] = actions.next, -- Bring the cursor to the next item in the list
                ["k"] = actions.previous, -- Bring the cursor to the previous item in the list
                ["<Down>"] = actions.next,
                ["<Up>"] = actions.previous,
                ["<C-n>"] = actions.next_location, -- Bring the cursor to the next location skipping groups in the list
                ["<C-p>"] = actions.previous_location, -- Bring the cursor to the previous location skipping groups in the list
                ["<C-u>"] = actions.preview_scroll_win(5),
                ["<C-d>"] = actions.preview_scroll_win(-5),
                ["v"] = actions.jump_vsplit,
                ["s"] = false,
                ["t"] = actions.jump_tab,
                ["<CR>"] = actions.jump,
                ["o"] = actions.jump_split,
                ["<leader>l"] = false, -- Use <C-w>W
                ["q"] = actions.close,
                ["Q"] = actions.close,
                ["<Esc>"] = actions.close,
            },
            preview = {
                ["Q"] = actions.close,
                ["<C-n>"] = actions.next_location,
                ["<C-p>"] = actions.previous_location,
                ["<leader>l"] = false, -- Use <C-w>w / <C-w>p
            },
        },
        hooks = {},
        folds = {
            fold_closed = fillchars.foldclose,
            fold_open = fillchars.foldopen,
            folded = true, -- Automatically fold list on startup
        },
        indent_lines = {
            enable = true,
            icon = fillchars.foldsep,
        },
        winbar = {
            enable = true, -- Available strating from nvim-0.8+
        },
    })
end

return M
