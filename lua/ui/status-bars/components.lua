local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
local u = require("ui.utilities")
local t = require("ui.status-bars.tables")
local i = USER.styling.icons
local M = {}

local function get_vim_mode()
    if require("hydra.statusline").is_active() then
        return "h"
    else
        return vim.api.nvim_get_mode()["mode"]
    end
end

local function get_vim_mode_color(mode)
    mode = mode or get_vim_mode()
    mode = mode:sub(1, 1) -- get only the first mode character
    local mode_colors = t.ModeHighlightGroups
    local highlight = utils.get_highlight(mode_colors[mode])

    return { fg = highlight.fg, bg = highlight.bg, bold = true }
end

local FileTypeBlock = {
    condition = function()
        return vim.bo.filetype ~= ""
    end,
    init = function(self)
        -- FileTypeIcon
        local fileName = vim.api.nvim_buf_get_name(0)
        local extension = vim.fn.fnamemodify(fileName, ":e")
        self.icon = require("nvim-web-devicons").get_icon(fileName, extension)
        -- FileType
        self.fileType = vim.bo.filetype
    end,
}

local FileTypeIcon = {
    provider = function(self)
        return self.icon and self.icon .. t.Separator.mid.provider
    end,
}

local FileType = {
    provider = function(self)
        return string.upper(self.fileType)
    end,
}

M.FileTypeBlock = utils.insert(
    FileTypeBlock,
    { flexible = t.Hide.FileTypeBlock.value, { t.Separator.left }, { t.Null } },
    { flexible = t.Hide.FileTypeBlock.icon, { FileTypeIcon }, { t.Null } },
    { flexible = t.Hide.FileTypeBlock.icon, { t.Null } },
    { flexible = t.Hide.FileTypeBlock.value, { FileType }, { t.Null } },
    { flexible = t.Hide.FileTypeBlock.value, { t.Separator.right }, { t.Null } }
)

local FileFormatBlock = {
    init = function(self)
        self.fileFormat = vim.bo.fileformat
    end,
}

local FileFormatIcon = {
    provider = function(self)
        local icon
        if self.fileFormat == "dos" then
            icon = i.OS.windows[1]
        elseif self.fileFormat == "unix" then
            icon = i.OS.linux[1]
        elseif self.fileFormat == "mac" then
            icon = i.OS.mac[1]
        end
        return icon
    end,
}

local FileFormat = {
    provider = function(self)
        local eol
        if self.fileFormat == "dos" then
            eol = "CRLF"
        elseif self.fileFormat == "unix" then
            eol = "LF"
        elseif self.fileFormat == "mac" then
            eol = "CR"
        end
        return eol
    end,
}

M.FileFormatBlock = utils.insert(
    FileFormatBlock,
    { flexible = t.Hide.FileFormatBlock.value, { t.Separator.left }, { t.Null } },
    { flexible = t.Hide.FileFormatBlock.icon, { FileFormatIcon }, { t.Null } },
    { flexible = t.Hide.FileFormatBlock.icon, { t.Separator.mid }, { t.Null } },
    { flexible = t.Hide.FileFormatBlock.value, { FileFormat }, { t.Null } },
    { flexible = t.Hide.FileFormatBlock.value, { t.Separator.right }, { t.Null } }
)

M.FileEncoding = {
    init = function(self)
        self.fileEncoding = vim.bo.fileencoding
    end,

    { flexible = t.Hide.FileEncoding, { t.Separator.left }, { t.Null } },
    {
        flexible = t.Hide.FileEncoding,
        {
            provider = function(self)
                return string.upper(self.fileEncoding)
            end,
        },
        { t.Null },
    },
    { flexible = t.Hide.FileEncoding, { t.Separator.right }, { t.Null } },
}

M.FileReadOnly = {
    condition = function()
        return not vim.bo.modifiable or vim.bo.readonly
    end,

    {
        flexible = t.Hide.FileReadOnly,
        {
            { t.Separator.left },
            { provider = i.lock[1] },
            { t.Separator.right },
        },
        { t.Null },
    },
}

M.FileModified = {
    condition = function()
        return vim.bo.modified
    end,

    {
        flexible = t.Hide.FileModified,
        {
            { t.Separator.left },
            { provider = i.edit[1] },
            { t.Separator.right },
        },
        { t.Null },
    },
}

M.CustomTitle = {
    init = function(self)
        self.fileName = vim.api.nvim_buf_get_name(0)
        self.fullPath = vim.fn.fnamemodify(self.fileName, ":p")
    end,

    provider = function(self)
        local buf_label = u.get_buf_label(self.fullPath, vim.bo.buftype, vim.bo.filetype)
        if buf_label then
            return t.Separator.left.provider .. buf_label .. t.Separator.right.provider
        end

        return ""
    end,
}

local FileNameBlock = {
    init = function(self)
        self.fileName = vim.api.nvim_buf_get_name(0)
        self.filePath = vim.fn.fnamemodify(self.fileName, ":.")
    end,
}

local FilePath = {
    provider = function(self)
        local filePath = self.filePath

        if filePath == "" then
            return ""
        end

        if not conditions.width_percent_below(#self.filePath, 0.40) then
            filePath = vim.fn.pathshorten(self.filePath)
        end

        filePath = vim.fn.fnamemodify(filePath, ":.:h") .. "/"

        if filePath == "./" then
            filePath = ""
        end

        return "%<" .. i.root_dir[1] .. " /" .. filePath .. t.Separator.mid.provider
    end,
}

local FileName = {
    provider = function(self)
        local fileName = vim.fn.fnamemodify(self.fileName, ":t")

        if fileName == "" then
            return "[No Name]"
        end

        return t.Separator.mid.provider .. i.file[1] .. " " .. fileName .. t.Separator.mid.provider
    end,
    hl = function()
        if conditions.is_active() then
            return "WinBarFile"
        end
    end,
}

local LspSymbol = {
    condition = function()
        local clients = vim.lsp.buf_get_clients()

        return next(clients) ~= nil and conditions.is_active()
    end,
    provider = function()
        local loaded, navic = pcall(require, "nvim-navic")
        local symbol = ""
        if not loaded or not require("nvim-navic").is_available() then
            return symbol
        end

        local context = navic.get_location()
        if context ~= nil and context ~= "" then
            symbol = " " .. i.arrow.hollow.r .. " " .. context
        end

        return symbol
    end,
    update = "CursorMoved",
}

M.FileNameBlock = utils.insert(
    FileNameBlock,
    { flexible = t.Hide.FilePath, { t.Separator.left }, { t.Null } },
    { flexible = t.Hide.FilePath, { FilePath }, { t.Null } },
    { flexible = t.Hide.FileName, { FileName }, { t.Null } },
    { flexible = t.Hide.LspSymbol, { LspSymbol }, { t.Null } },
    { flexible = t.Hide.FileName, { t.Separator.right }, { t.Null } }
)

M.Paste = {
    condition = function()
        return vim.o.paste
    end,

    { t.Separator.left },
    { provider = "PASTE" },
    { t.Separator.right },

    hl = function(self)
        return get_vim_mode_color(self.mode)
    end,
}

M.Wrap = {
    condition = function()
        return vim.o.wrap
    end,

    { t.Separator.left },
    { provider = "WRAP" },
    { t.Separator.right },

    hl = function(self)
        return get_vim_mode_color(self.mode)
    end,
}

M.Spell = {
    condition = function()
        return vim.wo.spell
    end,

    { flexible = t.Hide.Spell.value, { t.Separator.left }, { t.Null } },
    {
        flexible = t.Hide.Spell.icon,
        {
            provider = function()
                return i.spelling[1]
            end,
        },
        { t.Null },
    },
    { flexible = t.Hide.Spell.icon, { t.Separator.mid }, { t.Null } },
    {
        flexible = t.Hide.Spell.value,
        {
            provider = function()
                return vim.bo.spelllang
            end,
        },
        { t.Null },
    },
    { flexible = t.Hide.Spell.value, { t.Separator.right }, { t.Null } },
}

M.Treesitter = {
    condition = function()
        -- Source
        -- LunarVim - https://github.com/LunarVim/LunarVim/blob/a79de08d40f08e9a3b753175df11283ed737067c/lua/lvim/core/lualine/components.lua#L74-L80
        local bufnr = vim.api.nvim_get_current_buf()
        local is_active = pcall(next, vim.treesitter.highlighter.active[bufnr])

        return is_active
    end,

    { flexible = t.Hide.Treesitter.value, { t.Separator.left }, { t.Null } },
    { flexible = t.Hide.Treesitter.icon, { provider = i.treesiter[1] }, { t.Null } },
    { flexible = t.Hide.Treesitter.icon, { t.Separator.mid }, { t.Null } },
    { flexible = t.Hide.Treesitter.value, { provider = "TS" }, { t.Null } },
    { flexible = t.Hide.Treesitter.value, { t.Separator.right }, { t.Null } },
}

M.PluginUpdates = {
    condition = function(self)
        -- Source
        -- lazy.nvim - https://github.com/folke/lazy.nvim/blob/d2110278be136fd977d357ff49689352d58b2e83/lua/lazy/status.lua
        self.Checker = require("lazy.manage.checker")

        return #self.Checker.updated > 0
    end,

    { flexible = t.Hide.PluginUpdates.value, { t.Separator.left }, { t.Null } },
    { flexible = t.Hide.PluginUpdates.icon, { provider = i.plugin[1] }, { t.Null } },
    { flexible = t.Hide.PluginUpdates.icon, { t.Separator.mid }, { t.Null } },
    {
        flexible = t.Hide.PluginUpdates.value,
        {
            provider = function(self)
                return #self.Checker.updated
            end,
        },
        { t.Null },
    },
    { flexible = t.Hide.PluginUpdates.value, { t.Separator.right }, { t.Null } },

    hl = "StatusLinePluginUpdates",
}

M.CursorPosition = {
    { flexible = t.Hide.CursorPosition, { t.Separator.left }, { t.Null } },
    {
        flexible = t.Hide.CursorPosition,
        {
            provider = i.line[1] .. " %l" .. " : " .. i.column[1] .. " %c",
        },
        {
            provider = "%l:%c",
        },
    },
    { flexible = t.Hide.CursorPosition, { t.Separator.right }, { t.Null } },
}

M.CursorLine = {
    { t.Separator.left },
    { provider = i.line[1] .. " %l" },
    { t.Separator.right },
}

M.LinesTotal = {
    { t.Separator.left },
    { provider = i.linesTotal[1] .. " %L" },
    { t.Separator.right },

    hl = function(self)
        return get_vim_mode_color(self.mode)
    end,
}

M.WindowNumber = {
    { t.Separator.left },
    {
        provider = function(self)
            return i.window[1] .. " " .. self.winnr
        end,
    },
    { t.Separator.right },
}

M.CloseButton = {
    { t.Separator.left },
    { provider = i.close[1] },
    on_click = {
        callback = function()
            vim.cmd.quit()
        end,
        name = "heirline_closeButton",
    },
    { t.Separator.right },
}

-- Source
-- Neelfrost - https://github.com/Neelfrost/nvim-config/blob/df89fdcb49ce9080ccf1c54d33a939f341017be2/lua/user/plugins/config/heirline/components.lua#L255-L291
M.SearchResults = {
    condition = function(self)
        if vim.api.nvim_buf_line_count(0) > 50000 then
            return
        end

        local query = vim.fn.getreg("/")
        if query == "" or query:find("@") then
            return
        end

        local active = false
        local search_count = vim.fn.searchcount({ recompute = 1, maxcount = -1 })

        if vim.v.hlsearch and vim.v.hlsearch == 1 and search_count.total > 0 then
            active = true
        end

        if not active then
            return
        end

        self.count = search_count

        return true
    end,

    { t.Separator.left },
    {
        provider = function(self)
            return table.concat({ i.search[1], " ", self.count.current, "/", self.count.total })
        end,
    },
    { t.Separator.right },

    hl = "HlSearchLensNear",
}

M.GitStatus = {
    condition = conditions.is_git_repo,

    init = function(self)
        self.status_dict = vim.b.gitsigns_status_dict
        self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
        self.countAdded = self.status_dict.added or 0
        self.countRemoved = self.status_dict.removed or 0
        self.countChanged = self.status_dict.changed or 0
    end,

    { t.Separator.left },
    {
        flexible = t.Hide.GitBranch,
        { -- git branch name
            provider = function(self)
                return string.format("%s %s %s", i.git.repo[1], i.git.branch[1], self.status_dict.head)
            end,
            hl = { bold = true },
        },
        {
            provider = function()
                return i.git.repo[1] .. " "
            end,
            hl = { bold = true },
        },
    },

    {
        flexible = t.Hide.GitSigns.icon,
        {
            provider = function(self)
                return self.countAdded > 0 and (t.Separator.mid.provider .. i.git.added[1])
            end,
            -- hl = { fg = utils.get_highlight("GitSignsAdd").fg },
            hl = "GitSignsAdd",
        },
        {
            t.Null,
        },
    },

    {
        flexible = t.Hide.GitSigns.value,
        {
            provider = function(self)
                return self.countAdded > 0 and (" " .. self.countAdded)
            end,
            hl = "GitSignsAdd",
        },
        {
            t.Null,
        },
    },

    {
        flexible = t.Hide.GitSigns.icon,
        {
            provider = function(self)
                return self.countRemoved > 0 and (t.Separator.mid.provider .. i.git.deleted[1])
            end,
            hl = "GitSignsDelete",
        },
        {
            t.Null,
        },
    },

    {
        flexible = t.Hide.GitSigns.value,
        {
            provider = function(self)
                return self.countRemoved > 0 and (" " .. self.countRemoved)
            end,
            hl = "GitSignsDelete",
        },
        {
            t.Null,
        },
    },

    {
        flexible = t.Hide.GitSigns.icon,
        {
            provider = function(self)
                return self.countChanged > 0 and (t.Separator.mid.provider .. i.git.changed[1])
            end,
            hl = "GitSignsChange",
        },
        {
            t.Null,
        },
    },

    {
        flexible = t.Hide.GitSigns.value,
        {
            provider = function(self)
                return self.countChanged > 0 and (" " .. self.countChanged)
            end,
            hl = "GitSignsChange",
        },
        {
            t.Null,
        },
    },

    { t.Separator.right },
}

local LspBlock = {
    condition = conditions.lsp_attached,
    init = function(self)
        -- LspClients
        self.Clients = vim.lsp.buf_get_clients()
        self.Sources = require("null-ls.sources").get_available(vim.bo.filetype)
        -- LspDiagnostics
        self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
        self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
        self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
    end,
}

local LspClients = {
    condition = function(self)
        return next(self.Clients) ~= nil
    end,
    update = { "LspAttach", "LspDetach", "BufEnter" },
    {
        flexible = t.Hide.lspIcon,
        {
            provider = i.lsp.icon[1] .. " ",
        },
        {
            t.Null,
        },
    },
    {
        provider = function(self)
            -- Source:
            -- LunarVim - https://github.com/LunarVim/LunarVim/blob/a79de08d40f08e9a3b753175df11283ed737067c/lua/lvim/core/lualine/components.lua#L85-L116
            local lsp_servers = {}

            for _, client in pairs(self.Clients) do
                table.insert(lsp_servers, client.name)
            end

            return "[" .. table.concat(lsp_servers, " ") .. "]"
        end,
    },
}

local LspNullLsGap = {
    condition = function(self)
        return (next(self.Clients) ~= nil) and (next(self.Sources) ~= nil)
    end,
    update = { "LspAttach", "LspDetach", "BufEnter" },
    provider = t.Separator.mid.provider,
}

local NullLsSources = {
    condition = function(self)
        return next(self.Sources) ~= nil
    end,
    update = { "LspAttach", "LspDetach", "BufEnter" },
    {
        flexible = t.Hide.nullLsIcon,
        {
            provider = i.lsp.null_ls[1] .. " ",
        },
        {
            t.Null,
        },
    },
    {
        provider = function(self)
            local null_ls_sources = {}

            for _, source in ipairs(self.Sources) do
                table.insert(null_ls_sources, source.name)
            end

            return "[" .. table.concat(null_ls_sources, " ") .. "]"
        end,
    },
}

local LspDiagnostics = {
    condition = conditions.has_diagnostics,
    update = { "DiagnosticChanged", "BufEnter" },
    static = {
        errorIcon = i.lsp.error[1],
        warnIcon = i.lsp.warn[1],
        infoIcon = i.lsp.info[1],
        hintIcon = i.lsp.hint[1],
    },
    {
        flexible = t.Hide.lspDiagnosticIcons,
        {
            provider = function(self)
                return self.errors > 0
                    and string.format("%s%s %s", t.Separator.mid.provider, self.errorIcon, self.errors)
            end,
            hl = { fg = utils.get_highlight("DiagnosticError").fg },
        },
        {
            provider = function(self)
                return self.errors > 0 and (t.Separator.mid.provider .. self.errors)
            end,
            hl = { fg = utils.get_highlight("DiagnosticError").fg },
        },
    },

    {
        flexible = t.Hide.lspDiagnosticIcons,
        {
            provider = function(self)
                return self.warnings > 0
                    and string.format("%s%s %s", t.Separator.mid.provider, self.warnIcon, self.warnings)
            end,
            hl = { fg = utils.get_highlight("DiagnosticWarn").fg },
        },
        {
            provider = function(self)
                return self.warnings > 0 and (t.Separator.mid.provider .. self.warnings)
            end,
            hl = { fg = utils.get_highlight("DiagnosticWarn").fg },
        },
    },

    {
        flexible = t.Hide.lspDiagnosticIcons,
        {
            provider = function(self)
                return self.info > 0 and string.format("%s%s %s", t.Separator.mid.provider, self.infoIcon, self.info)
            end,
            hl = { fg = utils.get_highlight("DiagnosticInfo").fg },
        },
        {
            provider = function(self)
                return self.info > 0 and (t.Separator.mid.provider .. self.info)
            end,
            hl = { fg = utils.get_highlight("DiagnosticInfo").fg },
        },
    },

    {
        flexible = t.Hide.lspDiagnosticIcons,
        {
            provider = function(self)
                return self.hints > 0 and string.format("%s%s %s", t.Separator.mid.provider, self.hintIcon, self.hints)
            end,
            hl = { fg = utils.get_highlight("DiagnosticHint").fg },
        },
        {
            provider = function(self)
                return self.hints > 0 and (t.Separator.mid.provider .. self.hints)
            end,
            hl = { fg = utils.get_highlight("DiagnosticHint").fg },
        },
    },
}

M.LspBlock = utils.insert(
    LspBlock,

    { t.Separator.left },
    { flexible = t.Hide.lspClients, LspClients, { t.Null } },
    { flexible = math.min(t.Hide.lspClients, t.Hide.nullLsSources), LspNullLsGap, { t.Null } },
    { flexible = t.Hide.nullLsSources, NullLsSources, { t.Null } },
    { LspDiagnostics },
    { t.Separator.right }
)

M.TerminalName = {
    condition = function()
        return conditions.buffer_matches({ buftype = { "terminal" } })
    end,
    { t.Separator.left },
    {
        provider = function()
            local terminalName, _ = vim.api.nvim_buf_get_name(0):gsub(".*:/bin/", "")
            return string.format("%s %s", i.terminal[1], terminalName)
        end,
    },
    { t.Separator.right },
}

M.ViMode = {
    init = function(self)
        self.mode = get_vim_mode()
    end,

    -- Re-evaluate the component only on ModeChanged event!
    -- Also allorws the statusline to be re-evaluated when entering operator-pending mode
    update = {
        "ModeChanged",
        pattern = "*:*",
        callback = vim.schedule_wrap(function()
            vim.cmd("redrawstatus")
        end),
    },

    provider = function(self)
        return t.Separator.left.provider .. "%2(" .. t.ModeNames[self.mode] .. "%)"
    end,

    t.Separator.right,

    hl = function(self)
        return get_vim_mode_color(self.mode)
    end,
}

return M
