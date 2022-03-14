local bufferline = require("bufferline")
local ci = require("aesthetics").icon
local dracula_theme = {
    highlights = {
        fill                  = { guifg = "#f8f8f2", guibg = "#44475a" },
        background            = { guifg = "#f8f8f2", guibg = "#5f6a8e" },
        tab                   = { guifg = "#f8f8f2", guibg = "#5f6a8e" },
        tab_selected          = { guifg = "#44475a", guibg = "#BD93F9" },
        tab_close             = { guifg = "#f8f8f2", guibg = "#5f6a8e" },
        close_button          = { guifg = "#f8f8f2", guibg = "#5f6a8e" },
        close_button_visible  = { guifg = "#f8f8f2", guibg = "#5f6a8e" },
        close_button_selected = { guifg = "#44475a", guibg = "#BD93F9", gui = "" },
        buffer_visible        = { guifg = "#f8f8f2", guibg = "#5f6a8e" },
        buffer_selected       = { guifg = "#44475a", guibg = "#BD93F9", gui = "" },
        modified              = { guifg = "#FFB86C", guibg = "#5f6a8e" },
        modified_visible      = { guifg = "#FFB86C", guibg = "#5f6a8e" },
        modified_selected     = { guifg = "#FFB86C", guibg = "#BD93F9" },
        duplicate_selected    = { guifg = "#816daa", guibg = "#BD93F9", gui = "", },
        duplicate_visible     = { guifg = "#8d94ac", guibg = "#5f6a8e", gui = "", },
        duplicate             = { guifg = "#8d94ac", guibg = "#5f6a8e", gui = "", },
        separator_selected    = { guifg = "#44475A", guibg = "#BD93F9" },
        separator_visible     = { guifg = "#44475A", guibg = "#5f6a8e" },
        separator             = { guifg = "#44475A", guibg = "#5f6a8e" },
        indicator_selected    = { guifg = "#44475A", guibg = "#BD93F9" },
        pick_selected         = { guifg = "#F1FA8C", guibg = "#282a36", gui = "" },
        pick_visible          = { guifg = "#F1FA8C", guibg = "#282a36", gui = "" },
        pick                  = { guifg = "#F1FA8C", guibg = "#282a36", gui = "" }
    },
    offsets = {
        {
            filetype = "NvimTree",
            text = "File Tree",
            highlight = "lualine_a_normal",
            text_align = "center",
        },
        {
            filetype = "aerial",
            text = "Symbols",
            highlight = "lualine_a_normal",
            text_align = "center",
        },
        {
            filetype = "undotree",
            text = "Undotree",
            highlight = "lualine_a_normal",
            text_align = "center",
        }
    },
}
local nord_theme = {
    highlights = {
        fill                  = { guifg = "#E5E9F0", guibg = "#3B4252" },
        background            = { guifg = "#E5E9F0", guibg = "#4C566A" },
        tab                   = { guifg = "#E5E9F0", guibg = "#4C566A" },
        tab_selected          = { guifg = "#3B4252", guibg = "#81A1C1" },
        tab_close             = { guifg = "#E5E9F0", guibg = "#4C566A" },
        close_button          = { guifg = "#E5E9F0", guibg = "#4C566A" },
        close_button_visible  = { guifg = "#E5E9F0", guibg = "#4C566A" },
        close_button_selected = { guifg = "#3B4252", guibg = "#81A1C1", gui = "" },
        buffer_visible        = { guifg = "#E5E9F0", guibg = "#4C566A" },
        buffer_selected       = { guifg = "#3B4252", guibg = "#81A1C1", gui = "" },
        modified              = { guifg = "#EBCB8B", guibg = "#4C566A" },
        modified_visible      = { guifg = "#EBCB8B", guibg = "#4C566A" },
        modified_selected     = { guifg = "#EBCB8B", guibg = "#81A1C1" },
        duplicate_selected    = { guifg = "#D8DEE9", guibg = "#81A1C1", gui = "bold" },
        duplicate_visible     = { guifg = "#D8DEE9", guibg = "#4C566A", gui = "bold" },
        duplicate             = { guifg = "#D8DEE9", guibg = "#4C566A", gui = "bold" },
        separator_selected    = { guifg = "#3B4252", guibg = "#81A1C1" },
        separator_visible     = { guifg = "#3B4252", guibg = "#4C566A" },
        separator             = { guifg = "#3B4252", guibg = "#4C566A" },
        indicator_selected    = { guifg = "#3B4252", guibg = "#81A1C1" },
        pick_selected         = { guifg = "#D08770", guibg = "#2E3440", gui = "" },
        pick_visible          = { guifg = "#D08770", guibg = "#2E3440", gui = "" },
        pick                  = { guifg = "#D08770", guibg = "#2E3440", gui = "" }
    },
    offsets = {
        {
            filetype = "NvimTree",
            text = "File Tree",
            highlight = "BufferLineOffsetTitleBar",
            text_align = "center",
        },
        {
            filetype = "aerial",
            text = "Symbols",
            highlight = "BufferLineOffsetTitleBar",
            text_align = "center",
        },
        {
            filetype = "undotree",
            text = "Undotree",
            highlight = "BufferLineOffsetTitleBar",
            text_align = "center",
        }
    },
}

bufferline.setup{
    options = {
        numbers = function(opts)
            return string.format(" %s :", opts.id)
        end,
        close_command = "Bdelete %d",
        right_mouse_command = "Bdelete %d",
        buffer_close_icon= ci.close[1] .. " ",
        modified_icon = ci.edit[1] .. " ",
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
        separator_style = "slant", -- { "█", "█" },
        offsets = nord_theme.offsets,
        always_show_bufferline = true,
    },
    highlights = nord_theme.highlights,
}