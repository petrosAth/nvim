local components = require("plugins-cfg.lualine-cfg.components")
local lualine = require("lualine")

lualine.setup({
    options = {
        theme = "dracula",
        section_separators = { left = "", right = "" },
        component_separators = { left = "│", right = "│" },
    },
	sections = {
		lualine_a = {
            { components.current_mode },
            { components.wrap },
            { components.paste }
        },
		lualine_b = {
            { components.file_name }
        },
		lualine_c = {
            { components.lsp_status }
        },
		lualine_x = {
            components.diagnostics(),
            { components.spell },
            { components.file_encoding },
            { components.file_format }
        },
		lualine_y = {
            components.branch(),
			{ components.line_info }
		},
		lualine_z = {
            { components.lines_per_total }
        },
	},
	inactive_sections = {
		lualine_a = { },
		lualine_b = {
            { components.file_name }
        },
		lualine_c = { },
		lualine_x = { },
		lualine_y = { },
		lualine_z = { }
	},
	tabline = { },
	extensions = { "quickfix" }
})
