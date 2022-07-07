local bufferline = require("bufferline")
local i = require("styling").icons

bufferline.setup{
    options = {
        themable = true,
        numbers = function(opts)
            return string.format("%s", opts.id)
        end,
        close_command = "Bdelete %d",
        right_mouse_command = "Bdelete %d",
        buffer_close_icon= i.close[1] .. " ",
        modified_icon = i.edit[1] .. " ",
        close_icon = i.close[1],
        left_trunc_marker = i.arrowl[1],
        right_trunc_marker = i.arrowr[1],
        max_name_length = 30,
        tab_size = 1,
        diagnostics = false,
        show_buffer_icons = false,
        show_buffer_close_icons = true,
        -- right aligned  => "▕"," ","▐"
        -- left aligned   => "▏","▍","▌"
        -- center aligned => "│","┃"," ","█"
        indicator_icon = "█",
        separator_style = { "█", "█" }, -- { "▕", "▕" },
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Tree",
                highlight = "BufferLineOffsetTitleBar",
                text_align = "center",
                padding = 1,
            },
            {
                filetype = "aerial",
                text = "Symbols",
                highlight = "BufferLineOffsetTitleBar",
                text_align = "center",
                padding = 1,
            },
            {
                filetype = "undotree",
                text = "Undotree",
                highlight = "BufferLineOffsetTitleBar",
                text_align = "center",
                padding = 1,
            },
        },
        always_show_bufferline = false,
    },
}
