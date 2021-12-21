local excFiletypes = { "NvimTree", "packer", "alpha", "help", "lsp-installer", "Outline", "minimap", "Trouble" }
local ci = require("cosmetics").icon
local M = {}

local fn = vim.fn
local half_winwidth = 85

function M.buffer_is_plugin()--{{{
	local filename = fn.expand("%:t")
	for _, v in pairs(excFiletypes) do
		if filename == v or vim.bo.filetype == v then
			return true, filename
		end
	end
end --}}}

function M.file_icon(file_name, file_type)--{{{
	local icon = ""
	if file_type ~= "" then
		icon = require("nvim-web-devicons").get_icon(file_name, file_type)
	end

	-- Return file_name if icon does not exist
	if icon == nil or icon == "" then
		return file_name
	end

	-- Join icon and file_name if icon exists
	return icon .. " " .. file_name
end--}}}

function M.file_name()--{{{
	local file_name = fn.expand("%:r")
	local file_type = fn.expand("%:e")

	-- Truncate file_name if too big
	-- Set file name to [No Name] on empty buffers
	if #file_name > 30 then
		file_name = string.sub(file_name, 1, 8) .. "⋯"
	elseif file_name == "" then
		file_name = "[No Name]"
	end

	-- Join file_name and file_type if file_type exists
	local final_name = file_type ~= "" and file_name .. "." .. file_type or file_name

	-- Empty file_name for plugin releated buffers
	for _, v in pairs(excFiletypes) do
		if v == vim.bo.filetype then
			-- final_name = "⋯"
			final_name = "⋯"
		end
	end

	return M.readonly() .. M.file_icon(final_name, file_type)
end --}}}

function M.readonly()--{{{
	local readonly = vim.api.nvim_exec([[echo &readonly || !&modifiable ? ' ' : '']], true)
	return readonly
end --}}}

function M.current_mode()--{{{
	local buffer_name = fn.expand("%:t")
    local mode = require("lualine.utils.mode").get_mode()
	local mode_plugins = {
		NvimTree = "NVIMTREE",
		packer = "PACKER",
		alpha = "ALPHA",
        minimap = "MINIMAP",
        Outline = "OUTLINE",
        Trouble = "Trouble",
	}

	-- Return mode if in command mode
	if fn.mode() == "c" then
        return mode
	end

	-- Return plugin name
	for k, v in pairs(mode_plugins) do
		if vim.bo.filetype == k or buffer_name == k then
			return v
		end
	end

	-- Return mode
	return mode
end --}}}

function M.git_branch()--{{{
	local icon = " "
	local git_branch = require("lualine.components.branch.git_branch")
	git_branch.init()

	local branch = git_branch.get_branch()

	if branch ~= "" and not M.buffer_is_plugin() then
		return icon .. branch
	end
	return ""
end --}}}

function M.paste()--{{{
	return vim.o.paste and "PASTE" or ""
end --}}}

function M.wrap()--{{{
	return vim.o.wrap and "WRAP" or ""
end --}}}

function M.spell()--{{{
	return vim.wo.spell and vim.bo.spelllang or ""
end --}}}

function M.file_format()--{{{
	if not M.buffer_is_plugin() and fn.winwidth(0) > half_winwidth then
        return vim.bo.fileformat
    else
        return ""
	end
end --}}}

function M.file_encoding()--{{{
	if not M.buffer_is_plugin() and fn.winwidth(0) > half_winwidth then
		return vim.bo.fileencoding
	else
		return ""
	end
end --}}}

function M.line_info()--{{{
    local is_plugin, plugin_name = M.buffer_is_plugin()
	if not is_plugin then
        if fn.winwidth(0) > half_winwidth then
			return string.format("Ln %d, Col %-2d", fn.line("."), fn.col("."))
		else
			return string.format("%d : %-2d", fn.line("."), fn.col("."))
		end
    elseif plugin_name == "Trouble" then
        return string.format("Ln %d", fn.line("."))
	else
		return ""
	end
end --}}}

function M.lines_total()--{{{
    local is_plugin, plugin_name = M.buffer_is_plugin()

    if not M.buffer_is_plugin() then
        return string.format("%d ", fn.line("$"))
    elseif (plugin_name == "Trouble") and (fn.line("$") > 1 ) then
        return string.format("%d ", fn.line("$"))
    else
        return ""
    end
end --}}}

function M.lines_percent()--{{{
    local is_plugin, plugin_name = M.buffer_is_plugin()
    local lines_percent = (100 * fn.line(".") / fn.line("$"))

    if not is_plugin then
        return (string.format("%d", lines_percent) .. "%%")
    elseif (plugin_name == "Trouble") and (fn.line("$") > 1 ) then
        return (string.format("%d", lines_percent) .. "%%")
    else
        return ""
    end
end --}}}

function M.lines_per_total()--{{{
    local is_plugin, plugin_name = M.buffer_is_plugin()
    if fn.winwidth(0) > half_winwidth and not is_plugin then
        return (M.lines_percent() .. " of " .. M.lines_total())
    elseif (plugin_name == "Trouble") and (fn.line("$") > 1 ) then
        return (M.lines_percent() .. " of " .. M.lines_total())
    else
        return M.lines_percent()
    end
end--}}}

function M.lsp_client_name()--{{{
	local clients = vim.lsp.get_active_clients()
	for _, client in pairs(clients) do
		local client_filetype = client.config.filetypes[1]
		local client_name = client.name
		if client_filetype == vim.bo.filetype then
			return client_name
		end
	end
	return ""
end --}}}

function M.lsp_status()--{{{
    local client_name = M.lsp_client_name()
    local lsp_status_loaded, lsp_status = pcall(function()
        return require("lsp-status").status_progress()
    end)

    if lsp_status_loaded then
        if (lsp_status == "") then
            if fn.winwidth(0) > 105 then
                return client_name == "" and "" or "LSP " .. "[" .. client_name .. "]"
            elseif fn.winwidth(0) > half_winwidth then
                return client_name == "" and "" or "LSP"
            else
                return ""
            end
        else
            if fn.winwidth(0) > 130 then
                return "LSP " .. lsp_status
            elseif fn.winwidth(0) > half_winwidth then
                return "LSP"
            else
                return ""
            end
        end
    else
        print("lualine - components: lsp-status missing")
    end
end--}}}

function M.branch()--{{{
    local branch_options = {
        "branch",
        icon = "",
        cond = function()
            return not M.buffer_is_plugin()
        end,
    }
    return branch_options
end--}}}

function M.diagnostics()--{{{
    local diagnostics_options = {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        colored = true,
        symbols = {
            error = ci.error[1] .. " ",
            warn = ci.warn[1] .. " ",
            info = ci.info[1] .. " ",
            hint = ci.hint[1] .. " "
        },
        sections = { "error", "warn", "info", "hint" },
        always_visible = false,
        update_in_insert = false,
    }

    return diagnostics_options
end--}}}

function M.theme_transparent()--{{{
	local colors = {
		darkgray = "#1d1f21",
		gray = "#3f4b59",
		innerbg = "NONE",
		outerbg = "NONE",
		outerfg = "#14191f",
		insert = "#99c794",
		normal = "#6699cc",
		replace = "#ec5f67",
		visual = "#f99157",
	}
	return {
		inactive = {
			a = { fg = colors.gray, bg = colors.outerbg, gui = "bold" },
			b = { fg = colors.gray, bg = colors.outerfg },
			c = { fg = colors.gray, bg = colors.innerbg },
		},
		visual = {
			a = { fg = colors.darkgray, bg = colors.visual, gui = "bold" },
			b = { fg = colors.gray, bg = colors.outerfg },
			c = { fg = colors.gray, bg = colors.innerbg },
		},
		replace = {
			a = { fg = colors.darkgray, bg = colors.replace, gui = "bold" },
			b = { fg = colors.gray, bg = colors.outerfg },
			c = { fg = colors.gray, bg = colors.innerbg },
		},
		normal = {
			a = { fg = colors.darkgray, bg = colors.normal, gui = "bold" },
			b = { fg = colors.gray, bg = colors.outerfg },
			c = { fg = colors.gray, bg = colors.innerbg },
		},
		insert = {
			a = { fg = colors.darkgray, bg = colors.insert, gui = "bold" },
			b = { fg = colors.gray, bg = colors.outerfg },
			c = { fg = colors.gray, bg = colors.innerbg },
		},
		command = {
			a = { fg = colors.darkgray, bg = colors.insert, gui = "bold" },
			b = { fg = colors.gray, bg = colors.outerfg },
			c = { fg = colors.gray, bg = colors.innerbg },
		},
	}
end --}}}

return M
