local lualine = require("lualine")
local components = require("config.lualine.components")

lualine.setup({
    options = {
        theme = components.theme,
        component_separators = { left = "│", right = "│" },
        section_separators = { left = "", right = "" },
        -- disabled_filetypes = { "alpha", "NvimTree", "Outline" }
    },
    sections = {
        lualine_a = {
            { components.current_mode },
            { components.wrap },
            { components.paste },
        },
        lualine_b = {
            { components.is_readonly },
            { components.file_name_active },
        },
        lualine_c = {
            { components.git_status },
            { components.lsp_status },
        },
        lualine_x = {
            { components.spell },
            { components.file_type },
            { components.treesitter_status },
            { components.file_format },
            { components.file_encoding },
        },
        lualine_y = {
            { components.line_info },
        },
        lualine_z = {
            { components.lines_per_total },
        },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {
            { components.is_readonly },
            { components.file_name_inactive },
        },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {
            { components.window },
        },
        lualine_z = {},
    },
    tabline = {},
    extensions = {},
})
