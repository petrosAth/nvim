-- References:
-- https://elianiva.my.id/post/neovim-lua-statusline -- Great help for figuring out highlight groups
-- https://github.com/Neelfrost/dotfiles

local ci = require("styling").icon
local excFiletypes = {
    "aerial",
    "alpha",
    "diff",
    "help",
    "lsp-installer",
    "man",
    "minimap",
    "NvimTree",
    "Outline",
    "packer",
    "qf",
    "Trouble",
    "undotree"
}
local fn = vim.fn
local bo = vim.bo

local M = {}

M.print_for_width = function(sizes)
    local win = fn.winwidth(0)

    if sizes.autofill then
        sizes._  = sizes._  ~= "" and sizes._  or ""
        sizes.S  = sizes.S  ~= "" and sizes.S  or sizes._
        sizes.M  = sizes.M  ~= "" and sizes.M  or sizes.S
        sizes.L  = sizes.L  ~= "" and sizes.L  or sizes.M
        sizes.XL = sizes.XL ~= "" and sizes.XL or sizes.L
    end

    if win > 170 then
        return sizes.XL ~= "" and sizes.XL or ""
    elseif win > 120 then
        return sizes.L ~= "" and sizes.L or ""
    elseif win > 90 then
        return sizes.M ~= "" and sizes.M or ""
    elseif win > 60 then
        return sizes.S ~= "" and sizes.S or ""
    else
        return sizes._ ~= "" and sizes._ or ""
    end
end

M.win_size = function ()
    return M.print_for_width({
        XL = "XL",
        L  = "L",
        M  = "M",
        S  = "S",
        _  = "_"
    })
end

M.is_plugin = function()
	local filename = fn.expand("%:t")
	for _, v in pairs(excFiletypes) do
		if filename == v or bo.filetype == v then
			return true, filename
		end
	end
end

M.file_type = function()
    if M.is_plugin() then
        return ""
    else
        local f_type = bo.filetype
        local f_name, f_extension = fn.expand '%:t', fn.expand '%:e'
        f_extension = f_extension ~= '' and f_extension or bo.filetype
        local f_icon = require("nvim-web-devicons").get_icon(f_name, f_extension)

        -- Return file_name if icon does not exist
        if f_icon == nil or f_icon == "" then
        return M.print_for_width({
            autofill = true,
            M  = f_type,
        })
        end

        -- Join icon and file_name if icon exists
        return M.print_for_width({
            autofill = true,
            XL = f_icon .. " " .. f_type,
            M  = f_type,
            S  = f_icon,
        })
    end
end

M.file_name_active = function()
    if M.is_plugin() or bo.filetype == "checkhealth" then
        return ""
    else
        if #fn.expand("%:~:.:h") < fn.winwidth(0) * 0.12 and fn.expand("%:h") ~= "." then
            return " " .. fn.expand("%:~:.")
        else
            return M.print_for_width({
                autofill = true,
                L  = " " .. fn.expand("%:~:."),
                M  = " " .. fn.expand("%:h:t") .. "/",
                S  = fn.expand("%:h:t") .. "/"
            })
        end
    end
end

M.file_name_inactive = function()
    if M.is_plugin() then
        return ""
    else
        if #fn.expand("%:~:.") < fn.winwidth(0) * 0.85 and fn.expand("%:h") ~= "." then
            return " " .. fn.expand("%:~:.")
        elseif #fn.expand("%:t") < fn.winwidth(0) * 0.65 then
            return " " .. fn.expand("%:t")
        else
            return ""
        end
    end
end

M.is_readonly = function()
    if bo.modifiable == false or bo.readonly == true then
        return ""
    end
	return ""
end

M.current_mode = function()
	local buffer_name = fn.expand("%:t")
    local mode = require("lualine.utils.mode").get_mode()
	local mode_plugins = {
        alpha    = "Alpha",
        minimap  = "Minimap",
		NvimTree = "NvimTree",
        Outline  = "Outline",
		packer   = "Packer",
        Trouble  = "Trouble"
	}

	-- Return mode if in command mode
	if fn.mode() == "c" then
        return mode
	end

	-- Return plugin name
	for k, v in pairs(mode_plugins) do

		if bo.filetype == k or buffer_name == k then
			return v
		end
	end

	-- Return mode
	return mode
end

M.paste = function()
	return vim.o.paste and "PASTE" or ""
end

M.wrap = function()
	return vim.o.wrap and "WRAP" or ""
end

M.spell = function()
    if M.is_plugin() then
        return ""
    elseif vim.wo.spell then
        local spell = bo.spelllang
        local icon = "暈"
        return M.print_for_width({
            autofill = true,
            XL = icon .. " " .. spell,
            M  = spell,
            S  = icon
        })
    else
        return ""
	end
end

M.file_format = function()
	if M.is_plugin() then
        return ""
    else
        local f_format = bo.fileformat
        local f_eol, f_icon

        if f_format == "dos" then
            f_icon, f_eol = "", "CRLF"
        elseif f_format == "unix" then
            f_icon, f_eol = "", "LF"
        elseif f_format == "mac" then
            f_icon, f_eol = "", "CR"
        end

        return M.print_for_width({
            XL = f_icon .. " " .. f_eol,
            L  = f_eol
        })
	end
end

M.file_encoding = function()
    if M.is_plugin() then
        return ""
    else
        return M.print_for_width({
            autofill = true,
            L  = bo.fileencoding
        })
	end
end

M.line_info = function()
    local is_plugin, plugin_name = M.is_plugin()

	if not is_plugin then
        return M.print_for_width({
            autofill = true,
            L  = string.format(" %d :  %d", fn.line("."), fn.col(".")),
            S  = string.format("%d:%d", fn.line("."), fn.col("."))
        })
    elseif plugin_name == "Trouble" then
        return string.format(" %d", fn.line("."))
    else
        return ""
    end
end

M.lines_total = function()
    local is_plugin, plugin_name = M.is_plugin()

    if not is_plugin then
        return string.format(" %d", fn.line("$"))
    elseif plugin_name == "Trouble" and fn.line("$") > 1 then
        return string.format(" %d", fn.line("$"))
    else
        return ""
    end
end

M.lines_percent = function()
    local is_plugin, plugin_name = M.is_plugin()
    local lines_percent = (100 * fn.line(".") / fn.line("$"))

    if not is_plugin then
        return string.format("%d", lines_percent) .. "%%"
    elseif plugin_name == "Trouble" and fn.line("$") > 1 then
        return string.format("%d", lines_percent) .. "%%"
    else
        return ""
    end
end

M.lines_per_total = function()
    local is_plugin, plugin_name = M.is_plugin()

    if not is_plugin then
        return M.print_for_width({
            autofill = true,
            L  = M.lines_total() .. " : " .. M.lines_percent(),
            _  = M.lines_percent()
        })
    elseif plugin_name == "Trouble" and fn.line("$") > 4 then
        return (M.lines_percent() .. " : " .. M.lines_total())
    else
        return ""
    end
end

-- nvim-treesitter
M.treesitter_status = function()
    if M.is_plugin() then
        return ""
    else
    -- Reference:
    -- LunarVim -- https://github.com/LunarVim/LunarVim/blob/a79de08d40f08e9a3b753175df11283ed737067c/lua/lvim/core/lualine/components.lua#L74-L80
        local bufnr = vim.api.nvim_get_current_buf()
        if next(vim.treesitter.highlighter.active[bufnr]) then
            return M.print_for_width({
                autofill = true,
                XL = " TS",
                M  = "TS",
                S  = " "
            })
        else
            return ""
        end
    end
end

M.lsp_clients = function()
    -- Reference:
    -- LunarVim -- https://github.com/LunarVim/LunarVim/blob/a79de08d40f08e9a3b753175df11283ed737067c/lua/lvim/core/lualine/components.lua#L85-L116
    if M.is_plugin() then
        return ""
    else
        local buf_clients = vim.lsp.buf_get_clients()
        if not next(buf_clients) then
            return ""
        end
        -- local buf_ft = vim.bo.filetype
        local buf_client_names = {}

        -- add client
        for _, client in pairs(buf_clients) do
            if client.name ~= "null-ls" then
                table.insert(buf_client_names, client.name)
            end
        end

        -- add formatter
        -- local formatters = require "lvim.lsp.null-ls.formatters"
        -- local supported_formatters = formatters.list_registered_providers(buf_ft)
        -- vim.list_extend(buf_client_names, supported_formatters)

        -- add linter
        -- local linters = require "lvim.lsp.null-ls.linters"
        -- local supported_linters = linters.list_registered_providers(buf_ft)
        -- vim.list_extend(buf_client_names, supported_linters)

        return buf_client_names
    end
end

-- lsp-status.nvim
M.lsp_diagnostics = function()
    if M.is_plugin() then
        return ""
    else
        local lsp_clients = M.lsp_clients()
        if not next(lsp_clients) then
            return ""
        else
            local lsp_diagnostics = require("lsp-status").diagnostics
            local bufnr = vim.api.nvim_get_current_buf()

            local d_color = {
                errors   = "%#lualineDiagnosticError#",
                warnings = "%#lualineDiagnosticWarn#",
                info     = "%#lualineDiagnosticInfo#",
                hints    = "%#lualineDiagnosticHint#"
            }
            local d_symbol = {
                errors   = ci.error[1] .. " ",
                warnings = ci.warn[1] .. " ",
                info     = ci.info[1] .. " ",
                hints    = ci.hint[1] .. " "
            }
            local d_count = {
                errors   = lsp_diagnostics(bufnr).errors,
                warnings = lsp_diagnostics(bufnr).warnings,
                info     = lsp_diagnostics(bufnr).info,
                hints    = lsp_diagnostics(bufnr).hints
            }
            local d_status = {
                signs      = {},
                count_only = {}
            }
            for _, name in ipairs{ "errors", "warnings", "info", "hints" } do
                if lsp_diagnostics(bufnr)[name] and lsp_diagnostics(bufnr)[name] > 0 then
                    table.insert(d_status.signs, d_color[name] .. d_symbol[name] .. d_count[name])
                    table.insert(d_status.count_only, d_color[name] .. d_count[name])
                end
            end

            return d_status
        end
    end
end

-- lsp-status.nvim
M.lsp_status = function()
    if M.is_plugin() then
        return ""
    else
        local lsp_clients = M.lsp_clients()
        if not next(lsp_clients) then
            return ""
        else
            local lsp_progress = require("lsp-status").status_progress()

            if lsp_progress == "" then
                if not next(M.lsp_diagnostics().signs) then
                    return M.print_for_width({
                        autofill = true,
                        XL = "  " .. "[" .. table.concat(lsp_clients, " ") .. "]",
                        L  = "  " .. "[" .. table.concat(lsp_clients, " ") .. "]",
                        M  = "LSP",
                        S  = "",
                        _  = ""
                    })
                else
                    return M.print_for_width({
                        autofill = true,
                        L  = "  " .. table.concat(M.lsp_diagnostics().signs, " "),
                        M  = table.concat(M.lsp_diagnostics().signs, " "),
                        _  = table.concat(M.lsp_diagnostics().count_only, " "),
                    })
                end
            else
                return M.print_for_width({
                    XL = "  " .. lsp_progress,
                })
            end
        end
    end
end

-- gitsigns.nvim
M.git_status = function()
    if M.is_plugin() then
        return ""
    else
        local gitsigns = vim.b.gitsigns_status_dict or {head = "", added = 0, changed = 0, removed = 0}
        if gitsigns.head ~= "" then
            local gs_color = {
                head    = "",
                added   = "%#GitSignsAddNr#",
                changed = "%#GitSignsChangeNr#",
                removed = "%#GitSignsDeleteNr#"
            }
            local gs_symbol = {
                head    = "",
                added   = " +", --
                changed = " ~", --
                removed = " -"  --
            }
            local gs_count = {
                head    = gitsigns.head,
                added   = gitsigns.added,
                changed = gitsigns.changed,
                removed = gitsigns.removed
            }
            local gs_status = {
                head        = {},
                signs       = {},
                count_only  = {}
            }
            for _, name in ipairs{ "head", "added", "changed", "removed" } do
                if name == "head" then
                    table.insert(gs_status.head, gs_color[name] .. gs_symbol[name] .. gs_count[name])
                elseif gitsigns[name] and gitsigns[name] > 0 then
                    table.insert(gs_status.signs, gs_color[name] .. gs_symbol[name] .. gs_count[name])
                    table.insert(gs_status.count_only, gs_color[name] .. gs_count[name])
                end
            end

            return M.print_for_width({
                XL = " " .. gs_status.head[1] .. table.concat(gs_status.signs, ""),
                L  = " " .. gs_status.head[1] .. table.concat(gs_status.signs, ""),
                M  = gs_status.head[1] .. table.concat(gs_status.signs, ""),
                S  = table.concat(gs_status.count_only, " "),
                _  = " "
            })
        else
            return ""
        end
    end
end

M.builtin_diagnostics = function()
    local diagnostics = {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        colored = true,
        symbols = {
            error = ci.error[1] .. " ",
            warn  = ci.warn[1] .. " ",
            info  = ci.info[1] .. " ",
            hint  = ci.hint[1] .. " "
        },
        sections = { "error", "warn", "info", "hint" },
        always_visible = false,
        update_in_insert = false,
    }

    return diagnostics
end

M.window = function()
    return " " .. vim.api.nvim_win_get_number(0)
end

M.myNord = function()
    return {
        inactive = {
            a = { fg = "#3B4252", bg = "#88C0D0" },
            b = { fg = "#E5E9F0", bg = "#4C566A" },
            c = { fg = "#E5E9F0", bg = "#3B4252" },
        },
        visual = {
            a = { fg = "#3B4252", bg = "#EBCB8B" },
            b = { fg = "#E5E9F0", bg = "#4C566A" },
            c = { fg = "#E5E9F0", bg = "#3B4252" },
        },
        replace = {
            a = { fg = "#3B4252", bg = "#BF616A" },
            b = { fg = "#E5E9F0", bg = "#4C566A" },
            c = { fg = "#E5E9F0", bg = "#3B4252" },
        },
        normal = {
            a = { fg = "#3B4252", bg = "#88C0D0" },
            b = { fg = "#E5E9F0", bg = "#4C566A" },
            c = { fg = "#E5E9F0", bg = "#3B4252" },
        },
        insert = {
            a = { fg = "#3B4252", bg = "#ECEFF4" },
            b = { fg = "#E5E9F0", bg = "#4C566A" },
            c = { fg = "#E5E9F0", bg = "#3B4252" },
        },
        command = {
            a = { fg = "#3B4252", bg = "#8FBCBB" },
            b = { fg = "#E5E9F0", bg = "#4C566A" },
            c = { fg = "#E5E9F0", bg = "#3B4252" },
        },
    }
end

return M
