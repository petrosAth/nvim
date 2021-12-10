vim.cmd([[
    augroup LIGHTBULB
        autocmd!
        autocmd ColorScheme * highlight LightBulbVirtualText ctermfg=84 guifg=#50fa7b
        autocmd CursorHold,CursorHoldI,CursorMoved,CursorMovedI * lua require("plugins-cfg.lsp-cfg.nvim-lightbulb-cfg").checkCodeAction()
    augroup END
]])

local M = {}
local ci = require("cosmetics").icon

M.checkCodeAction = function()
    require("nvim-lightbulb").update_lightbulb({
        -- LSP client names to ignore
        -- Example: {"sumneko_lua", "null-ls"}
        ignore = {},
        sign = {
            enabled = true,
            -- Priority of the gutter sign
            priority = 10,
        },
        float = {
            enabled = false,
            -- Text to show in the popup float
            text = ci.action[2],
            -- Available keys for window options:
            -- - height     of floating window
            -- - width      of floating window
            -- - wrap_at    character to wrap at for computing height
            -- - max_width  maximal width of floating window
            -- - max_height maximal height of floating window
            -- - pad_left   number of columns to pad contents at left
            -- - pad_right  number of columns to pad contents at right
            -- - pad_top    number of lines to pad contents at top
            -- - pad_bottom number of lines to pad contents at bottom
            -- - offset_x   x-axis offset of the floating window
            -- - offset_y   y-axis offset of the floating window
            -- - anchor     corner of float to place at the cursor (NW, NE, SW, SE)
            -- - winblend   transparency of the window (0-100)
            win_opts = {},
        },
        virtual_text = {
            enabled = true,
            -- Text to show at virtual text
            text = "● Code actions available .",
            -- highlight mode to use for virtual text (replace, combine, blend), see :help nvim_buf_set_extmark() for reference
            hl_mode = "combine",
        },
        status_text = {
            enabled = false,
            -- Text to provide when code actions are available
            text = ci.action[2],
            -- Text to provide when no actions are available
            text_unavailable = ""
        }
    })
end

vim.fn.sign_define('LightBulbSign', { text = ci.action[2], texthl = "DraculaGreen", linehl= "", numhl="DraculaGreen" })

return M
