-- References:
-- https://elianiva.my.id/post/neovim-lua-statusline -- Great help for figuring out highlight groups
-- https://github.com/Neelfrost/dotfiles

local fn = vim.fn
local bo = vim.bo
local i = require("styling").icons
local filetype_list = {
    "aerial",
    "alpha",
    "diff",
    "DiffviewFileHistory",
    "DiffviewFiles",
    "help",
    "lspinfo",
    "man",
    "mason.nvim",
    "minimap",
    "neo-tree",
    "NvimTree",
    "Outline",
    "packer",
    "qf",
    "TelescopePrompt",
    "Trouble",
    "undotree",
}

local M = {}

M.theme = require("config.themes." .. THEME .. ".lualine")

M.print_for_width = function(sizes)
    -- if global status bar is enabled, get terminal window columns, else get nvim current window columns
    local win = vim.api.nvim_get_option("columns")
    if vim.api.nvim_get_option("laststatus") ~= 3 then
        win = fn.winwidth(0)
    end

    if sizes.autofill then
        sizes._ = sizes._ ~= "" and sizes._ or ""
        sizes.S = sizes.S ~= "" and sizes.S or sizes._
        sizes.M = sizes.M ~= "" and sizes.M or sizes.S
        sizes.L = sizes.L ~= "" and sizes.L or sizes.M
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

M.win_size = function()
    return M.print_for_width({
        XL = "XL",
        L = "L",
        M = "M",
        S = "S",
        _ = "_",
    })
end

M.is_plugin = function()
    local filename = fn.expand("%:t")
    for _, filetype in pairs(filetype_list) do
        if filename == filetype or bo.filetype == filetype then
            return true, filename
        end
    end
end

M.has_custom_name = function()
    local filename = fn.expand("%:p")
    local filename_list = {
        { filename = "%[Command Line%]", customFilename = "Command line history",                },
        { filename = "(/%.git/:0:)/",    customFilename = "Original file",                       },
        { filename = "(/%.git/.-)/",     customFilename = "??? Git commit ",          gitRepo = true }
    }
    for _, name in pairs(filename_list) do
        local filename_match = string.match(filename, name.filename)
        if filename_match then
            if name.gitRepo then
                local commit = string.sub(filename_match, 7, 13)
                return true, name.customFilename .. commit
            end
            return true, name.customFilename
        end
    end
end

M.is_modified = function()
    local bufid = vim.api.nvim_win_get_buf(0)
    local is_modified = vim.bo[bufid].modified
    local modified_icon = i.edit[1]
    local modified_flag = "%#lualineModifiedFile# " .. modified_icon
    -- return is_modified, modified_flag
    modified_flag = is_modified and modified_flag or ""
    return modified_flag
end

M.file_type = function()
    if M.has_custom_name() then
        return ""
    elseif M.is_plugin() then
        return ""
    else
        local f_type = bo.filetype
        local f_name, f_extension = fn.expand("%:t"), fn.expand("%:e")
        f_extension = f_extension ~= "" and f_extension or bo.filetype
        local f_icon = require("nvim-web-devicons").get_icon(f_name, f_extension)

        -- Return file_name if icon does not exist
        if f_icon == nil or f_icon == "" then
            return M.print_for_width({
                autofill = true,
                M = f_type,
            })
        end

        -- Join icon and file_name if icon exists
        return M.print_for_width({
            autofill = true,
            XL = f_icon .. " " .. f_type,
            M = f_type,
            S = f_icon,
        })
    end
end

M.file_name_active = function()
    local file_icon = i.file[1] .. " "
    local dir_icon = i.dir[1] .. " "
    local modified_flag = M.is_modified()
    local has_custom_name, custom_name = M.has_custom_name()
    if has_custom_name then
        return custom_name
    elseif M.is_plugin() or bo.filetype == "checkhealth" then
        return ""
    else
        if #fn.expand("%:~:.:h") < fn.winwidth(0) * 0.12 and fn.expand("%:h") ~= "." then
            return file_icon .. fn.expand("%:~:.") .. modified_flag
        else
            return M.print_for_width({
                autofill = true,
                L = file_icon .. fn.expand("%:~:.") .. modified_flag,
                M = dir_icon .. fn.expand("%:h:t") .. "/" .. modified_flag,
                S = fn.expand("%:h:t") .. "/" .. modified_flag,
            })
        end
    end
end

M.file_name_inactive = function()
    local file_icon = i.file[1] .. " "
    local dir_icon = i.dir[1] .. " "
    local modified_flag = M.is_modified()
    if M.is_plugin() then
        return ""
    else
        if #fn.expand("%:~:.") < fn.winwidth(0) * 0.85 and fn.expand("%:h") ~= "." then
            return dir_icon .. fn.expand("%:~:.") .. modified_flag
        elseif #fn.expand("%:t") < fn.winwidth(0) * 0.65 then
            return file_icon .. fn.expand("%:t") .. modified_flag
        else
            return ""
        end
    end
end

M.is_readonly = function()
    if bo.modifiable == false or bo.readonly == true then
        return "??? "
    end
    return ""
end

M.current_mode = function()
    local buffer_name = fn.expand("%:t")
    local mode = require("lualine.utils.mode").get_mode()
    local plugin_list = {
        { filetype = "aerial",              mode_title = "Aerial"   },
        { filetype = "alpha",               mode_title = "Alpha"    },
        { filetype = "DiffviewFileHistory", mode_title = "Diffview" },
        { filetype = "DiffviewFiles",       mode_title = "Diffview" },
        { filetype = "lspinfo",             mode_title = "LSP info" },
        { filetype = "mason.nvim",          mode_title = "Mason"    },
        { filetype = "minimap",             mode_title = "Minimap"  },
        { filetype = "neo-tree",            mode_title = "NeoTree"  },
        { filetype = "NvimTree",            mode_title = "NvimTree" },
        { filetype = "Outline",             mode_title = "Outline"  },
        { filetype = "packer",              mode_title = "Packer"   },
        { filetype = "Trouble",             mode_title = "Trouble"  },
    }

    -- Return mode if in command mode
    if fn.mode() == "c" then
        return mode
    end

    if require("hydra.statusline").is_active() then
        vim.api.nvim_set_hl(0, "lualine_a_normal", { link = "lualineHydraMode" })
        return "HYDRA"
    else
        vim.api.nvim_set_hl(0, "lualine_a_normal", M.theme.normal.a)
    end

    -- Return plugin name
    for _, plugin in pairs(plugin_list) do
        if bo.filetype == plugin.filetype or buffer_name == plugin.filetype then
            return plugin.mode_title
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
        local icon = "???"
        return M.print_for_width({
            autofill = true,
            XL = icon .. " " .. spell,
            M = spell,
            S = icon,
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
            f_icon, f_eol = "???", "CRLF"
        elseif f_format == "unix" then
            f_icon, f_eol = "???", "LF"
        elseif f_format == "mac" then
            f_icon, f_eol = "???", "CR"
        end

        return M.print_for_width({
            XL = f_icon .. " " .. f_eol,
            L = f_eol,
        })
    end
end

M.file_encoding = function()
    if M.is_plugin() then
        return ""
    else
        return M.print_for_width({
            autofill = true,
            L = bo.fileencoding,
        })
    end
end

M.line_info = function()
    local is_plugin, plugin_name = M.is_plugin()

    if not is_plugin then
        return M.print_for_width({
            autofill = true,
            L = string.format("??? %d : ??? %d", fn.line("."), fn.col(".")),
            S = string.format("%d:%d", fn.line("."), fn.col(".")),
        })
    elseif plugin_name == "Trouble" then
        return string.format("??? %d", fn.line("."))
    else
        return ""
    end
end

M.lines_total = function()
    local is_plugin, plugin_name = M.is_plugin()

    if not is_plugin then
        return string.format("??? %d", fn.line("$"))
    elseif plugin_name == "Trouble" and fn.line("$") > 1 then
        return string.format("??? %d", fn.line("$"))
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
            L = M.lines_total() .. " : " .. M.lines_percent(),
            _ = M.lines_percent(),
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
                XL = "??? TS",
                M = "TS",
                S = "??? ",
            })
        else
            return ""
        end
    end
end

M.lsp_clients = function()
    -- Source
    -- LunarVim - https://github.com/LunarVim/LunarVim/blob/a79de08d40f08e9a3b753175df11283ed737067c/lua/lvim/core/lualine/components.lua#L85-L116
    if M.is_plugin() then
        return ""
    else
        local buf_clients = vim.lsp.buf_get_clients()
        if not next(buf_clients) then
            return ""
        end

        local buf_client_names = {}

        for _, client in pairs(buf_clients) do
            table.insert(buf_client_names, client.name)
        end

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
                errors = "%#lualineDiagnosticError#",
                warnings = "%#lualineDiagnosticWarn#",
                info = "%#lualineDiagnosticInfo#",
                hints = "%#lualineDiagnosticHint#",
            }
            local d_symbol = {
                errors = i.error[1] .. " ",
                warnings = i.warn[1] .. " ",
                info = i.info[1] .. " ",
                hints = i.hint[1] .. " ",
            }
            local d_count = {
                errors = lsp_diagnostics(bufnr).errors,
                warnings = lsp_diagnostics(bufnr).warnings,
                info = lsp_diagnostics(bufnr).info,
                hints = lsp_diagnostics(bufnr).hints,
            }
            local d_status = {
                signs = {},
                count_only = {},
            }
            for _, name in ipairs({ "errors", "warnings", "info", "hints" }) do
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
                        XL = "???  " .. "[" .. table.concat(lsp_clients, " ") .. "]",
                        L = "???  LSP",
                        M = "LSP",
                        S = "???",
                        _ = "???",
                    })
                else
                    return M.print_for_width({
                        autofill = true,
                        L = "???  " .. table.concat(M.lsp_diagnostics().signs, " "),
                        M = table.concat(M.lsp_diagnostics().signs, " "),
                        _ = table.concat(M.lsp_diagnostics().count_only, " "),
                    })
                end
            else
                return M.print_for_width({
                    XL = "???  " .. lsp_progress,
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
        local gitsigns = vim.b.gitsigns_status_dict or { head = "", added = 0, changed = 0, removed = 0 }
        if gitsigns.head ~= "" then
            local gs_color = {
                head = "",
                added = "%#GitSignsAddNr#",
                changed = "%#GitSignsChangeNr#",
                removed = "%#GitSignsDeleteNr#",
            }
            local gs_symbol = {
                head = "",
                added = " +", --???
                changed = " ~", --???
                removed = " -",  --???
            }
            local gs_count = {
                head = gitsigns.head,
                added = gitsigns.added,
                changed = gitsigns.changed,
                removed = gitsigns.removed,
            }
            local gs_status = {
                head = {},
                signs = {},
                count_only = {},
            }
            for _, name in ipairs({ "head", "added", "changed", "removed" }) do
                if name == "head" then
                    table.insert(gs_status.head, gs_color[name] .. gs_symbol[name] .. gs_count[name])
                elseif gitsigns[name] and gitsigns[name] > 0 then
                    table.insert(gs_status.signs, gs_color[name] .. gs_symbol[name] .. gs_count[name])
                    table.insert(gs_status.count_only, gs_color[name] .. gs_count[name])
                end
            end

            return M.print_for_width({
                XL = "??? ??? " .. gs_status.head[1] .. table.concat(gs_status.signs, ""),
                L = "??? " .. gs_status.head[1] .. table.concat(gs_status.signs, ""),
                M = gs_status.head[1] .. table.concat(gs_status.signs, ""),
                S = table.concat(gs_status.count_only, " "),
                _ = "??? ",
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
            error = i.error[1] .. " ",
            warn = i.warn[1] .. " ",
            info = i.info[1] .. " ",
            hint = i.hint[1] .. " ",
        },
        sections = { "error", "warn", "info", "hint" },
        always_visible = false,
        update_in_insert = false,
    }

    return diagnostics
end

M.window = function()
    return "??? " .. vim.api.nvim_win_get_number(0)
end

return M
