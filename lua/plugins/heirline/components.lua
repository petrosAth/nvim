local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
local uiUtils = require("ui.utilities")
local props = require("plugins.heirline.properties")
local get_vim_mode_color = require("plugins.heirline.utilities").get_vim_mode_color
local icons = USER.styling.icons
local Sep = USER.styling.separators.bars
local Null = { provider = "" }

local M = {}

local FileTypeBlock = {
    condition = function() return vim.bo.filetype ~= "" end,
    init = function(self)
        local fullPath = vim.api.nvim_buf_get_name(0)
        local extension = vim.fn.fnamemodify(fullPath, ":e")
        self.icon, self.icon_fg = require("nvim-web-devicons").get_icon_color(fullPath, extension, { default = true })
        self.fileType = vim.bo.filetype
    end,
}

local FileIcon = {
    provider = function(self) return self.icon and ("%s "):format(self.icon) end,
    hl = function(self) return { fg = self.icon_fg } end,
}

local FileType = {
    provider = function(self) return string.upper(self.fileType) end,
}

M.FileTypeBlock = utils.insert(
    FileTypeBlock,
    { flexible = props.Hide.FileTypeBlock.value, { provider = Sep.gap }, Null },
    { flexible = props.Hide.FileTypeBlock.icon, FileIcon, Null },
    { flexible = props.Hide.FileTypeBlock.value, FileType, Null },
    { flexible = props.Hide.FileTypeBlock.value, { provider = Sep.gap }, Null }
)

local FileFormatBlock = {
    init = function(self) self.fileFormat = vim.bo.fileformat end,
}

local FileFormatIcon = {
    provider = function(self)
        local icon
        if self.fileFormat == "dos" then
            icon = icons.OS.windows[1]
        elseif self.fileFormat == "unix" then
            icon = icons.OS.linux[1]
        elseif self.fileFormat == "mac" then
            icon = icons.OS.mac[1]
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
    { flexible = props.Hide.FileFormatBlock.value, { provider = Sep.gap }, Null },
    { flexible = props.Hide.FileFormatBlock.icon, FileFormatIcon, Null },
    { flexible = props.Hide.FileFormatBlock.icon, { provider = " " }, Null },
    { flexible = props.Hide.FileFormatBlock.value, FileFormat, Null },
    { flexible = props.Hide.FileFormatBlock.value, { provider = Sep.gap }, Null }
)

M.FileEncoding = {
    init = function(self) self.fileEncoding = vim.bo.fileencoding end,
    { flexible = props.Hide.FileEncoding, { provider = Sep.gap }, Null },
    {
        flexible = props.Hide.FileEncoding,
        { provider = function(self) return string.upper(self.fileEncoding) end },
        Null,
    },
    { flexible = props.Hide.FileEncoding, { provider = Sep.gap }, Null },
}

M.FileSize = {
    { flexible = props.Hide.FileSize, { provider = Sep.gap }, Null },
    {
        flexible = props.Hide.FileSize,
        {
            provider = function()
                -- stackoverflow, compute human readable file size
                local suffix = { "b", "kb", "Mb", "Gb", "Tb", "Pb", "Eb" }
                local fsize = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
                fsize = (fsize < 0 and 0) or fsize
                if fsize < 1024 then return fsize .. suffix[1] end
                local i = math.floor((math.log(fsize) / math.log(1024)))
                return ("%.2g%s"):format(fsize / math.pow(1024, i), suffix[i + 1])
            end,
        },
        Null,
    },
    { flexible = props.Hide.FileSize, { provider = Sep.gap }, Null },
}

M.FileReadOnly = {
    condition = function() return not vim.bo.modifiable or vim.bo.readonly end,
    { flexible = props.Hide.FileReadOnly, { provider = icons.lock[2] }, Null },
}

M.FileModified = {
    condition = function() return not (not vim.bo.modifiable or vim.bo.readonly) end,
    init = function(self) self.modified = vim.bo.modified end,
    {
        flexible = props.Hide.FileModified,
        {
            { provider = icons.edit[1] },
            hl = function(self) return self.modified and { fg = utils.get_highlight("BarModified").fg } or {} end,
        },
        Null,
    },
}

M.CustomTitle = {
    init = function(self)
        self.fileName = vim.api.nvim_buf_get_name(0)
        self.fullPath = vim.fn.fnamemodify(self.fileName, ":p")
    end,
    {
        provider = function(self)
            local buf_label = uiUtils.get_buf_label(self.fullPath, vim.bo.buftype, vim.bo.filetype)
            if buf_label then return (" %s"):format(buf_label) end

            return ""
        end,
    },
}

local FileNameBlock = {
    init = function(self)
        self.fileName = vim.api.nvim_buf_get_name(0)
        self.filePath = vim.fn.fnamemodify(self.fileName, ":.")
        local extension = vim.fn.fnamemodify(self.fileName, ":e")
        self.icon, self.icon_fg =
            require("nvim-web-devicons").get_icon_color(self.fileName, extension, { default = true })
    end,
}

local FilePath = {
    provider = function(self)
        local filePath = self.filePath

        if filePath == "" then return "" end

        if not conditions.width_percent_below(#self.filePath, 0.40) then
            filePath = vim.fn.pathshorten(self.filePath)
        end

        filePath = ("%s/"):format(vim.fn.fnamemodify(filePath, ":.:h"))

        if filePath == "./" then filePath = "" end

        filePath = ("%%<%s /%s"):format(icons.root_dir[1], filePath)

        return (filePath):gsub("/", (" %s "):format(icons.arrow.hollow.r))
    end,
}

local FileName = {
    provider = function(self)
        local fileName = vim.fn.fnamemodify(self.fileName, ":t")
        if fileName == "" then return "[No Name]" end

        return ("%s"):format(fileName)
    end,
}

M.FileNameBlock = utils.insert(
    FileNameBlock,
    { flexible = props.Hide.FileNameBlock.name, { provider = Sep.gap }, Null },
    { flexible = props.Hide.FileNameBlock.path, FilePath, Null },
    { flexible = props.Hide.FileNameBlock.icon, FileIcon, Null },
    { flexible = props.Hide.FileNameBlock.name, FileName, Null }
)

M.LspSymbol = {
    condition = function(self)
        local clients = vim.lsp.get_clients({ bufnr = 0 })
        local is_navic_loaded, navic = pcall(require, "nvim-navic")
        self.navic = navic

        return next(clients) ~= nil and conditions.is_active() and is_navic_loaded and self.navic.is_available()
    end,
    update = "CursorMoved",
    { flexible = props.Hide.FileNameBlock.symbol, { provider = Sep.gap }, Null },
    {
        flexible = props.Hide.FileNameBlock.symbol,
        {
            provider = function(self)
                local context = self.navic.get_location()
                return (context ~= nil and context ~= "") and ("%s"):format(context)
            end,
        },
        Null,
    },
    { flexible = props.Hide.FileNameBlock.symbol, { provider = Sep.gap }, Null },
}

M.Paste = {
    condition = function() return vim.o.paste end,
    init = function(self) self.mode = vim.api.nvim_get_mode()["mode"] end,
    update = {
        "ModeChanged",
        pattern = "*:*",
        callback = vim.schedule_wrap(function() vim.cmd("redrawstatus") end),
    },
    { provider = (" %s "):format(Sep.sep) },
    { provider = "PASTE" },
    hl = function(self) return get_vim_mode_color(self.mode) end,
}

M.Wrap = {
    init = function(self) self.mode = vim.api.nvim_get_mode()["mode"] end,
    update = {
        "ModeChanged",
        pattern = "*:*",
        callback = vim.schedule_wrap(function() vim.cmd("redrawstatus") end),
    },
    condition = function() return vim.o.wrap end,
    { provider = (" %s "):format(Sep.sep) },
    { provider = "WRAP" },
    hl = function(self) return get_vim_mode_color(self.mode) end,
}

M.Spell = {
    condition = function() return vim.wo.spell end,
    { flexible = props.Hide.Spell.value, { provider = Sep.gap }, Null },
    { flexible = props.Hide.Spell.icon, { provider = function() return icons.spelling[1] end }, Null },
    { flexible = props.Hide.Spell.icon, { provider = " " }, Null },
    { flexible = props.Hide.Spell.value, { provider = function() return vim.bo.spelllang end }, Null },
    { flexible = props.Hide.Spell.value, { provider = Sep.gap }, Null },
}

M.Treesitter = {
    condition = function()
        -- Source
        -- LunarVim - https://github.com/LunarVim/LunarVim/blob/a79de08d40f08e9a3b753175df11283ed737067c/lua/lvim/core/lualine/components.lua#L74-L80
        local bufnr = vim.api.nvim_get_current_buf()
        local is_active = pcall(next, vim.treesitter.highlighter.active[bufnr])

        return is_active
    end,
    { flexible = props.Hide.Treesitter.value, { provider = Sep.gap }, Null },
    { flexible = props.Hide.Treesitter.icon, { provider = icons.treesitter[1] }, Null },
    { flexible = props.Hide.Treesitter.icon, { provider = " " }, Null },
    { flexible = props.Hide.Treesitter.value, { provider = "TS" }, Null },
    { flexible = props.Hide.Treesitter.value, { provider = Sep.gap }, Null },
}

M.PluginUpdates = {
    condition = function(self)
        -- Source
        -- lazy.nvim - https://github.com/folke/lazy.nvim/blob/d2110278be136fd977d357ff49689352d58b2e83/lua/lazy/status.lua
        self.Checker = require("lazy.manage.checker")

        return #self.Checker.updated > 0
    end,
    { flexible = props.Hide.PluginUpdates.value, { provider = Sep.gap }, Null },
    {
        flexible = props.Hide.PluginUpdates.icon,
        { provider = icons.plugin[1], hl = "BarUpdates" },
        Null,
    },
    { flexible = props.Hide.PluginUpdates.icon, { provider = " " }, Null },
    {
        flexible = props.Hide.PluginUpdates.value,
        { provider = function(self) return #self.Checker.updated end, hl = "BarUpdates" },
        Null,
    },
    { flexible = props.Hide.PluginUpdates.value, { provider = Sep.gap }, Null },
}

M.CursorPosition = {
    {
        flexible = props.Hide.CursorPosition,
        { provider = ("%s %%l : %s %%c "):format(icons.line[1], icons.column[1]) },
        { provider = "%l:%c " },
    },
}

M.CursorLine = {
    provider = ("%s %%l "):format(icons.line[1]),
}

M.LinesTotal = {
    init = function(self) self.mode = vim.api.nvim_get_mode()["mode"] end,
    -- Re-evaluate the component only on ModeChanged event!
    -- Also allorws the statusline to be re-evaluated when entering operator-pending mode
    update = {
        "ModeChanged",
        pattern = "*:*",
        callback = vim.schedule_wrap(function() vim.cmd("redrawstatus") end),
    },
    provider = ("%s %%L"):format(icons.linesTotal[1]),
    hl = function(self) return get_vim_mode_color(self.mode) end,
}

M.WindowNumber = {
    { provider = function(self) return ("%s %s"):format(icons.window[1], self.winnr) end },
    { provider = Sep.gap },
}

-- Source
-- Neelfrost - https://github.com/Neelfrost/nvim-config/blob/df89fdcb49ce9080ccf1c54d33a939f341017be2/lua/user/plugins/config/heirline/components.lua#L255-L291
M.SearchResults = {
    condition = function(self)
        if vim.api.nvim_buf_line_count(0) > 50000 then return end

        local query = vim.fn.getreg("/")
        if query == "" or query:find("@") then return end

        local active = false
        local search_count = vim.fn.searchcount({ recompute = 1, maxcount = -1 })

        if vim.v.hlsearch and vim.v.hlsearch == 1 and search_count.total > 0 then active = true end

        if not active then return end

        self.count = search_count

        return true
    end,
    init = function(self) self.mode = vim.api.nvim_get_mode()["mode"] end,
    { provider = (" %s "):format(Sep.sep) },
    {
        provider = function(self)
            return table.concat({ icons.search[1], " ", self.count.current, "/", self.count.total })
        end,
    },
    hl = function(self) return { fg = get_vim_mode_color(self.mode).fg, bg = get_vim_mode_color(self.mode).bg } end,
}

M.GitBlame = {
    condition = conditions.is_git_repo,
    init = function(self) self.blame_line = vim.b.gitsigns_blame_line or "" end,
    update = {
        "CursorHold",
        callback = vim.schedule_wrap(function() vim.cmd("redrawstatus") end),
    },
    { flexible = props.Hide.GitBlame, { provider = Sep.gap }, Null },
    {
        flexible = props.Hide.GitBlame,
        {
            provider = function(self) return self.blame_line end,
        },
    },
}

M.GitStatus = {
    condition = conditions.is_git_repo,
    init = function(self)
        self.status_dict = vim.b.gitsigns_status_dict or ""
        self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
        self.countAdded = self.status_dict.added or 0
        self.countRemoved = self.status_dict.removed or 0
        self.countChanged = self.status_dict.changed or 0
    end,
    { flexible = props.Hide.GitBranch, { provider = Sep.gap }, Null },
    {
        flexible = props.Hide.GitBranch,
        {
            provider = function(self)
                return ("%s %s %s"):format(icons.git.repo[1], icons.git.branch[1], self.status_dict.head)
            end,
            hl = { bold = true },
        },
        {
            provider = function() return ("%s "):format(icons.git.repo[1]) end,
            hl = { bold = true },
        },
    },
    {
        flexible = props.Hide.GitSigns.icon,
        {
            provider = function(self) return self.countAdded > 0 and (" %s"):format(icons.git.added[1]) end,
            hl = "GitSignsAdd",
        },
        Null,
    },
    {
        flexible = props.Hide.GitSigns.value,
        {
            provider = function(self) return self.countAdded > 0 and (" %s"):format(self.countAdded) end,
            hl = "GitSignsAdd",
        },
        Null,
    },
    {
        flexible = props.Hide.GitSigns.icon,
        {
            provider = function(self) return self.countRemoved > 0 and (" %s"):format(icons.git.deleted[1]) end,
            hl = "GitSignsDelete",
        },
        Null,
    },
    {
        flexible = props.Hide.GitSigns.value,
        {
            provider = function(self) return self.countRemoved > 0 and (" %s"):format(self.countRemoved) end,
            hl = "GitSignsDelete",
        },
        Null,
    },
    {
        flexible = props.Hide.GitSigns.icon,
        {
            provider = function(self) return self.countChanged > 0 and (" %s"):format(icons.git.changed[1]) end,
            hl = "GitSignsChange",
        },
        Null,
    },
    {
        flexible = props.Hide.GitSigns.value,
        {
            provider = function(self) return self.countChanged > 0 and (" %s"):format(self.countChanged) end,
            hl = "GitSignsChange",
        },
        Null,
    },
}

M.TerminalName = {
    condition = function() return conditions.buffer_matches({ buftype = { "terminal" } }) end,
    {
        provider = function()
            local terminalName, _ = vim.api.nvim_buf_get_name(0):gsub(".*:/bin/", "")
            return ("%s %s"):format(icons.terminal[1], terminalName)
        end,
    },
}

local LspBlock = {
    condition = conditions.lsp_attached,
    init = function(self)
        -- LspClients
        self.Clients = vim.lsp.get_clients({ bufnr = 0 })
        self.Sources = require("null-ls.sources").get_available(vim.bo.filetype)
        -- LspDiagnostics
        self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
        self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
        self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
    end,
}

local LspClients = {
    condition = function(self) return next(self.Clients) ~= nil end,
    update = { "LspAttach", "LspDetach", "BufEnter" },
    {
        flexible = props.Hide.lspIcon,
        {
            provider = ("%s "):format(icons.lsp.icon[1]),
        },
        Null,
    },
    {
        provider = function(self)
            -- Source:
            -- LunarVim - https://github.com/LunarVim/LunarVim/blob/a79de08d40f08e9a3b753175df11283ed737067c/lua/lvim/core/lualine/components.lua#L85-L116
            local lsp_servers = {}

            for _, client in pairs(self.Clients) do
                table.insert(lsp_servers, client.name)
            end

            return ("[%s]"):format(table.concat(lsp_servers, " "))
        end,
    },
}

local LspNullLsGap = {
    condition = function(self) return (next(self.Clients) ~= nil) and (next(self.Sources) ~= nil) end,
    update = { "LspAttach", "LspDetach", "BufEnter" },
    provider = Sep.gap,
}

local NullLsSources = {
    condition = function(self) return next(self.Sources) ~= nil end,
    update = { "LspAttach", "LspDetach", "BufEnter" },
    {
        flexible = props.Hide.nullLsIcon,
        {
            provider = ("%s "):format(icons.lsp.null_ls[1]),
        },
        Null,
    },
    {
        provider = function(self)
            local null_ls_sources = {}

            for _, source in ipairs(self.Sources) do
                table.insert(null_ls_sources, source.name)
            end

            return ("[%s] "):format(table.concat(null_ls_sources, " "))
        end,
    },
}

local LspDiagnostics = {
    condition = conditions.has_diagnostics,
    update = { "DiagnosticChanged", "BufEnter" },
    static = {
        errorIcon = icons.lsp.error[1],
        warnIcon = icons.lsp.warn[1],
        infoIcon = icons.lsp.info[1],
        hintIcon = icons.lsp.hint[1],
    },
    {
        flexible = props.Hide.lspDiagnosticIcons,
        {
            provider = function(self)
                return self.errors > 0 and ("%s%s %s"):format(Sep.gap, self.errorIcon, self.errors)
            end,
            hl = { fg = utils.get_highlight("DiagnosticError").fg },
        },
        {
            provider = function(self) return self.errors > 0 and ("%s%s"):format(Sep.gap, self.errors) end,
            hl = { fg = utils.get_highlight("DiagnosticError").fg },
        },
    },
    {
        flexible = props.Hide.lspDiagnosticIcons,
        {
            provider = function(self)
                return self.warnings > 0 and ("%s%s %s"):format(Sep.gap, self.warnIcon, self.warnings)
            end,
            hl = { fg = utils.get_highlight("DiagnosticWarn").fg },
        },
        {
            provider = function(self) return self.warnings > 0 and ("%s%s"):format(Sep.gap, self.warnings) end,
            hl = { fg = utils.get_highlight("DiagnosticWarn").fg },
        },
    },
    {
        flexible = props.Hide.lspDiagnosticIcons,
        {
            provider = function(self) return self.info > 0 and ("%s%s %s"):format(Sep.gap, self.infoIcon, self.info) end,
            hl = { fg = utils.get_highlight("DiagnosticInfo").fg },
        },
        {
            provider = function(self) return self.info > 0 and ("%s%s"):format(Sep.gap, self.info) end,
            hl = { fg = utils.get_highlight("DiagnosticInfo").fg },
        },
    },
    {
        flexible = props.Hide.lspDiagnosticIcons,
        {
            provider = function(self) return self.hints > 0 and ("%s%s %s"):format(Sep.gap, self.hintIcon, self.hints) end,
            hl = { fg = utils.get_highlight("DiagnosticHint").fg },
        },
        {
            provider = function(self) return self.hints > 0 and ("%s%s"):format(Sep.gap, self.hints) end,
            hl = { fg = utils.get_highlight("DiagnosticHint").fg },
        },
    },
    { flexible = props.Hide.LspDiagnostics, { provider = Sep.gap }, Null },
}

M.LspBlock = utils.insert(
    LspBlock,
    { flexible = props.Hide.lspClients, { provider = Sep.gap }, Null },
    { flexible = props.Hide.lspClients, LspClients, Null },
    { flexible = props.Hide.lspClients, { provider = Sep.gap }, Null },
    { flexible = math.min(props.Hide.lspClients, props.Hide.nullLsSources), LspNullLsGap, Null },
    { flexible = props.Hide.nullLsSources, NullLsSources, Null },
    LspDiagnostics
)

M.CloseButton = {
    update = { "WinNew", "WinClosed", "BufEnter" },
    {
        provider = icons.close[1],
        on_click = {
            minwid = function() return vim.api.nvim_get_current_win() end,
            callback = function(_, minwid) vim.api.nvim_win_close(minwid, true) end,
            name = "heirline_winbar_close_button",
        },
    },
}

M.ViMode = {
    init = function(self) self.mode = vim.api.nvim_get_mode()["mode"] end,
    -- Re-evaluate the component only on ModeChanged event!
    -- Also allorws the statusline to be re-evaluated when entering operator-pending mode
    update = {
        "ModeChanged",
        pattern = "*:*",
        callback = vim.schedule_wrap(function() vim.cmd("redrawstatus") end),
    },
    {
        provider = function(self) return ("%%2(%s%%)"):format(props.ModeNames[self.mode]) end,
    },
    hl = function(self) return get_vim_mode_color(self.mode) end,
}

return M
