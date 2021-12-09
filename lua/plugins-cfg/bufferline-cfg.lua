local bufferline = require("bufferline")
-- Selected buffer ordenal number
local selbufOrdinal = 0
local ci = require("cosmetics").icon

bufferline.setup{
    options = {
        numbers = function(opts)--{{{
                if opts.id == vim.fn.bufnr("%") then
                    selbufOrdinal = opts.ordinal
                    if opts.ordinal > 1 then
                        return string.format(" %s:", opts.id)
                    else
                        return string.format("▏%s:", opts.id)
                    end
                elseif (opts.ordinal == 1) or (opts.ordinal == selbufOrdinal + 1) then
                    return string.format("%s:", opts.id)
                else
                    return string.format("▏%s:", opts.id)
                end
            end,--}}}
        close_command = "Bdelete %d",
        right_mouse_command = "Bdelete %d",
        buffer_close_icon= ci.close[1],
        modified_icon = ci.edit[1],
        close_icon = ci.close[1],
        left_trunc_marker = ci.arrowl[1],
        right_trunc_marker = ci.arrowr[1],
        diagnostics = false,
        show_buffer_icons = false,
        show_buffer_close_icons = true,
        indicator_icon = "",
        -- U+2590 ▐ Right half block, this character is right aligned so the
        -- background highlight doesn't appear in th middle
        -- alternatives:
            -- right aligned  => "▕"," ","▐"
            -- left aligned   => "▏","▍","▌"
            -- center aligned => "│","┃"," ","█"
        separator_style = { "", "" },
        offsets = {--{{{
            {
                filetype = "NvimTree",
                text = "File Explorer",
                highlight = "lualine_a_normal",
                text_align = "center"
            },
            {
                filetype = "minimap",
                text = "Minimap",
                highlight = "lualine_a_normal",
                text_align = "center"
            },
            {
                filetype = "Outline",
                text = "Symbols",
                highlight = "lualine_a_normal",
                text_align = "center"
            }
        },--}}}
        always_show_bufferline = true,
    },
    highlights = {--{{{
        fill = {
            guifg = "#f8f8f2",
            guibg = "#44475a"
        },
        background = {
            guifg = "#f8f8f2",
            guibg = "#5f6a8e",
        },
        tab = {
            guifg = "#f8f8f2",
            guibg = "#5f6a8e",
        },
        tab_selected = {--{{{
            guifg = "#44475a",
            guibg = "#BD93F9",
        },--}}}
        tab_close = {
            guifg = "#f8f8f2",
            guibg = "#5f6a8e",
        },
        close_button = {
            guifg = "#f8f8f2",
            guibg = "#5f6a8e",
        },
        close_button_visible = {
            guifg = "#f8f8f2",
            guibg = "#5f6a8e",
        },
        close_button_selected = {--{{{
            guifg = "#44475a",
            guibg = "#BD93F9",
            gui = ""
        },--}}}
        buffer_visible = {
            guifg = "#f8f8f2",
            guibg = "#5f6a8e",
        },
        buffer_selected = {--{{{
            guifg = "#44475a",
            guibg = "#BD93F9",
            gui = ""
        },--}}}
        modified = {
            guifg = "#FFB86C",
            guibg = "#5f6a8e",
        },
        modified_visible = {
            guifg = "#FFB86C",
            guibg = "#5f6a8e",
        },
        modified_selected = {--{{{
            guifg = "#FFB86C",
            -- guifg = "#44475a",
            guibg = "#BD93F9",
        },--}}}
        duplicate_selected = {
            guifg = "#816daa",
            guibg = "#BD93F9",
            gui = "",
        },
        duplicate_visible = {
            guifg = "#8d94ac",
            guibg = "#5f6a8e",
            gui = "",
        },
        duplicate = {
            guifg = "#8d94ac",
            guibg = "#5f6a8e",
            gui = "",
        },
        separator_selected = {--{{{
            guifg = "#BD93F9",
            guibg = "#BD93F9",
        },--}}}
        separator_visible = {
            guifg = "#5f6a8e",
            guibg = "#5f6a8e",
        },
        separator = {
            guifg = "#5f6a8e",
            guibg = "#5f6a8e",
        },
        indicator_selected = {
            guifg = "#f8f8f2",
            guibg = "#5f6a8e",
        },
        pick_selected = {
            guifg = "#F1FA8C",
            guibg = "#282a36",
            gui = ""
        },
        pick_visible = {
            guifg = "#F1FA8C",
            guibg = "#282a36",
            gui = ""
        },
        pick = {
            guifg = "#F1FA8C",
            guibg = "#282a36",
            gui = ""
        }
    }--}}}
}

-- bufferline mappings
local map = vim.api.nvim_set_keymap
local ns_opts = { noremap = true, silent = true }

map("n", "<Tab><Tab>", "<cmd>BufferLinePick<CR>", ns_opts)
map("n", "<Tab><Tab>", "<cmd>BufferLinePick<CR>", ns_opts)
