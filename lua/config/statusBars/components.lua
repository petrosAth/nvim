local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
local h = require("config.statusBars.helperTables")
local i = PA.styling.icons
local M = {}

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
        return self.icon and self.icon .. h.Separator.mid.provider
    end,
}

local FileType = {
    provider = function(self)
        return string.upper(self.fileType)
    end,
}

M.FileTypeBlock = utils.insert(
    FileTypeBlock,
    { flexible = h.Hide.FileTypeBlock.value, { h.Separator.left }, { h.Null } },
    { flexible = h.Hide.FileTypeBlock.icon, { FileTypeIcon }, { h.Null } },
    { flexible = h.Hide.FileTypeBlock.icon, { h.Null } },
    { flexible = h.Hide.FileTypeBlock.value, { FileType }, { h.Null } },
    { flexible = h.Hide.FileTypeBlock.value, { h.Separator.right }, { h.Null } }
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
    { flexible = h.Hide.FileFormatBlock.value, { h.Separator.left }, { h.Null } },
    { flexible = h.Hide.FileFormatBlock.icon, { FileFormatIcon }, { h.Null } },
    { flexible = h.Hide.FileFormatBlock.icon, { h.Separator.mid }, { h.Null } },
    { flexible = h.Hide.FileFormatBlock.value, { FileFormat }, { h.Null } },
    { flexible = h.Hide.FileFormatBlock.value, { h.Separator.right }, { h.Null } }
)

M.FileEncoding = {
    init = function(self)
        self.fileEncoding = vim.bo.fileencoding
    end,

    { flexible = h.Hide.FileEncoding, { h.Separator.left }, { h.Null } },
    {
        flexible = h.Hide.FileEncoding,
        {
            provider = function(self)
                return string.upper(self.fileEncoding)
            end,
        },
        { h.Null },
    },
    { flexible = h.Hide.FileEncoding, { h.Separator.right }, { h.Null } },
}

M.FileReadOnly = {
    condition = function()
        return not vim.bo.modifiable or vim.bo.readonly
    end,

    {
        flexible = h.Hide.FileReadOnly,
        {
            { h.Separator.left },
            { provider = i.lock[1] },
            { h.Separator.right },
        },
        { h.Null },
    },
}

M.FileModified = {
    condition = function()
        return vim.bo.modified
    end,

    {
        flexible = h.Hide.FileModified,
        {
            { h.Separator.left },
            { provider = i.edit[1] },
            { h.Separator.right },
        },
        { h.Null },
    },

    hl = "WinBarModifiedCurrent",
}

local FileNameBlock = {
    init = function(self)
        self.fileName = vim.api.nvim_buf_get_name(0)
        self.filePath = vim.fn.fnamemodify(self.fileName, ":.")
    end,
    static = {
        typeList = {
            { title = "aerial", customTitle = "AERIAL" },
            { title = "DiffviewFileHistory", customTitle = "DIFFVIEW" },
            { title = "DiffviewFiles", customTitle = "DIFFVIEW" },
            { title = "diff", customTitle = "DIFF PANEL" },
            { title = "help", customTitle = "HELP" },
            { title = "minimap", customTitle = "MINIMAP" },
            { title = "neo-tree", customTitle = "NEOTREE" },
            { title = "NvimTree", customTitle = "NVIMTREE" },
            { title = "Outline", customTitle = "OUTLINE" },
            { title = "qf", customTitle = "QUICKFIX" },
            { title = "terminal", customTitle = "TERMINAL" },
            { title = "Trouble", customTitle = "TROUBLE" },
            { title = "undotree", customTitle = "UNDOTREE" },
        },
    },
}

local FilePath = {
    provider = function(self)
        local filePath = self.filePath

        for _, type in pairs(self.typeList) do
            if vim.bo.filetype == type.title or self.filePath == type.title or vim.bo.buftype == type.title then
                return ""
            end
        end

        if filePath == "" then
            return ""
        end

        if not conditions.width_percent_below(#self.filePath, 0.40) then
            filePath = vim.fn.pathshorten(self.filePath)
        end

        filePath = vim.fn.fnamemodify(filePath, ":.:h")

        return "%<" .. i.dir[1] .. " " .. filePath .. "/" .. h.Separator.mid.provider
    end,
}

local FileName = {
    provider = function(self)
        local fileName = vim.fn.fnamemodify(self.fileName, ":t")

        for _, type in pairs(self.typeList) do
            if vim.bo.filetype == type.title or self.filePath == type.title or vim.bo.buftype == type.title then
                return type.customTitle
            end
        end

        if fileName == "" then
            return "[No Name]"
        end

        return i.file[1] .. " " .. fileName
    end,
}

M.FileNameBlock = utils.insert(
    FileNameBlock,
    { flexible = h.Hide.FileName, { h.Separator.left }, { h.Null } },
    { flexible = h.Hide.FilePath, { FilePath }, { h.Null } },
    { flexible = h.Hide.FileName, { FileName }, { h.Null } },
    { flexible = h.Hide.FileName, { h.Separator.right }, { h.Null } }
)

M.Paste = {
    init = function(self)
        if require("hydra.statusline").is_active() then
            self.mode = "hydra"
        else
            self.mode = vim.fn.mode(1) -- :h mode()
        end

        -- execute this only once, this is required if you want the ViMode
        -- component to be updated on operator pending mode
        if not self.once then
            vim.api.nvim_create_autocmd("ModeChanged", {
                pattern = "*:*o",
                command = "redrawstatus",
            })
            self.once = true
        end
    end,
    static = {
        mode_colors = h.ModeHighlightGroups,
    },
    condition = function()
        return vim.o.paste
    end,

    { h.Separator.left },
    { provider = "PASTE" },
    { h.Separator.right },

    hl = function(self)
        local mode = self.mode:sub(1, 1) -- get only the first mode character
        local highlight = utils.get_highlight(self.mode_colors[mode])
        return { fg = highlight.fg, bg = highlight.bg, bold = true }
    end,
}

M.Wrap = {
    init = function(self)
        if require("hydra.statusline").is_active() then
            self.mode = "hydra"
        else
            self.mode = vim.fn.mode(1) -- :h mode()
        end

        -- execute this only once, this is required if you want the ViMode
        -- component to be updated on operator pending mode
        if not self.once then
            vim.api.nvim_create_autocmd("ModeChanged", {
                pattern = "*:*o",
                command = "redrawstatus",
            })
            self.once = true
        end
    end,
    static = {
        mode_colors = h.ModeHighlightGroups,
    },
    condition = function()
        return vim.o.wrap
    end,

    { h.Separator.left },
    { provider = "WRAP" },
    { h.Separator.right },

    hl = function(self)
        local mode = self.mode:sub(1, 1) -- get only the first mode character
        local highlight = utils.get_highlight(self.mode_colors[mode])
        return { fg = highlight.fg, bg = highlight.bg, bold = true }
    end,
}

M.Spell = {
    condition = function()
        return vim.wo.spell
    end,

    { flexible = h.Hide.Spell.value, { h.Separator.left }, { h.Null } },
    {
        flexible = h.Hide.Spell.icon,
        {
            provider = function()
                return "暈"
            end,
        },
        { h.Null },
    },
    {
        flexible = h.Hide.Spell.value,
        {
            provider = function()
                return vim.bo.spelllang
            end,
        },
        { h.Null },
    },
    { flexible = h.Hide.Spell.value, { h.Separator.right }, { h.Null } },
}

M.Treesitter = {
    condition = function()
        -- Source
        -- LunarVim - https://github.com/LunarVim/LunarVim/blob/a79de08d40f08e9a3b753175df11283ed737067c/lua/lvim/core/lualine/components.lua#L74-L80
        local bufnr = vim.api.nvim_get_current_buf()
        local is_active = pcall(next, vim.treesitter.highlighter.active[bufnr])

        return is_active
    end,

    { flexible = h.Hide.Treesitter.value, { h.Separator.left }, { h.Null } },
    { flexible = h.Hide.Treesitter.icon, { provider = i.treesiter[1] }, { h.Null } },
    { flexible = h.Hide.Treesitter.icon, { h.Separator.mid }, { h.Null } },
    { flexible = h.Hide.Treesitter.value, { provider = "TS" }, { h.Null } },
    { flexible = h.Hide.Treesitter.value, { h.Separator.right }, { h.Null } },
}

M.CursorPosition = {
    { flexible = h.Hide.CursorPosition, { h.Separator.left }, { h.Null } },
    {
        flexible = h.Hide.CursorPosition,
        {
            provider = i.line[1] .. " %l" .. " : " .. i.column[1] .. " %c",
        },
        {
            provider = "%l:%c",
        },
    },
    { flexible = h.Hide.CursorPosition, { h.Separator.right }, { h.Null } },
}

M.CursorLineSpecial = {
    condition = function()
        return conditions.buffer_matches({
            buftype = {},
            filetype = { "qf", "Trouble" },
        })
    end,

    { h.Separator.left },
    { provider = i.line[1] .. " %l" },
    { h.Separator.right },
}

M.LinesTotal = {
    init = function(self)
        if require("hydra.statusline").is_active() then
            self.mode = "hydra"
        else
            self.mode = vim.fn.mode(1) -- :h mode()
        end

        -- execute this only once, this is required if you want the ViMode
        -- component to be updated on operator pending mode
        if not self.once then
            vim.api.nvim_create_autocmd("ModeChanged", {
                pattern = "*:*o",
                command = "redrawstatus",
            })
            self.once = true
        end
    end,
    static = {
        mode_colors = h.ModeHighlightGroups,
    },
    { h.Separator.left },
    { provider = i.linesTotal[1] .. " %L" },
    { h.Separator.right },

    hl = function(self)
        local mode = self.mode:sub(1, 1) -- get only the first mode character
        local highlight = utils.get_highlight(self.mode_colors[mode])
        return { fg = highlight.fg, bg = highlight.bg, bold = true }
    end,
}

M.LinesTotalSpecial = {
    init = function(self)
        if require("hydra.statusline").is_active() then
            self.mode = "hydra"
        else
            self.mode = vim.fn.mode(1) -- :h mode()
        end

        -- execute this only once, this is required if you want the ViMode
        -- component to be updated on operator pending mode
        if not self.once then
            vim.api.nvim_create_autocmd("ModeChanged", {
                pattern = "*:*o",
                command = "redrawstatus",
            })
            self.once = true
        end
    end,
    static = {
        mode_colors = h.ModeHighlightGroups,
    },
    condition = function()
        return conditions.buffer_matches({
            buftype = {},
            filetype = { "qf", "Trouble" },
        })
    end,

    { h.Separator.left },
    { provider = i.linesTotal[1] .. " %L" },
    { h.Separator.right },

    hl = function(self)
        local mode = self.mode:sub(1, 1) -- get only the first mode character
        local highlight = utils.get_highlight(self.mode_colors[mode])
        return { fg = highlight.fg, bg = highlight.bg, bold = true }
    end,
}

M.WindowNumber = {
    { h.Separator.left },
    {
        provider = function(self)
            return i.window[1] .. " " .. self.winnr
        end,
    },
    { h.Separator.right },

    hl = "WinBarWindowNumber",
}

M.CloseButton = {
    { h.Separator.left },
    { provider = i.close[1] },
    on_click = {
        callback = function()
            vim.cmd.quit()
        end,
        name = "heirline_closeButton",
    },
    { h.Separator.right },
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

    { h.Separator.left },
    {
        provider = function(self)
            return table.concat({ i.search[1], " ", self.count.current, "/", self.count.total })
        end,
    },
    { h.Separator.right },

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

    { h.Separator.left },
    {
        flexible = h.Hide.GitBranch,
        { -- git branch name
            provider = function(self)
                return i.git.repo[1] .. " " .. i.git.branch[1] .. " " .. self.status_dict.head
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
        flexible = h.Hide.GitSigns.icon,
        {
            provider = function(self)
                return self.countAdded > 0 and (h.Separator.mid.provider .. i.git.added[1])
            end,
            -- hl = { fg = utils.get_highlight("GitSignsAdd").fg },
            hl = "GitSignsAdd",
        },
        {
            h.Null,
        },
    },

    {
        flexible = h.Hide.GitSigns.value,
        {
            provider = function(self)
                return self.countAdded > 0 and (" " .. self.countAdded)
            end,
            hl = "GitSignsAdd",
        },
        {
            h.Null,
        },
    },

    {
        flexible = h.Hide.GitSigns.icon,
        {
            provider = function(self)
                return self.countRemoved > 0 and (h.Separator.mid.provider .. i.git.deleted[1])
            end,
            hl = "GitSignsDelete",
        },
        {
            h.Null,
        },
    },

    {
        flexible = h.Hide.GitSigns.value,
        {
            provider = function(self)
                return self.countRemoved > 0 and (" " .. self.countRemoved)
            end,
            hl = "GitSignsDelete",
        },
        {
            h.Null,
        },
    },

    {
        flexible = h.Hide.GitSigns.icon,
        {
            provider = function(self)
                return self.countChanged > 0 and (h.Separator.mid.provider .. i.git.changed[1])
            end,
            hl = "GitSignsChange",
        },
        {
            h.Null,
        },
    },

    {
        flexible = h.Hide.GitSigns.value,
        {
            provider = function(self)
                return self.countChanged > 0 and (" " .. self.countChanged)
            end,
            hl = "GitSignsChange",
        },
        {
            h.Null,
        },
    },

    { h.Separator.right },
}

local LspBlock = {
    condition = conditions.lsp_attached,
    init = function(self)
        -- LspClients
        self.Clients = vim.lsp.buf_get_clients()
        -- LspDiagnostics
        self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
        self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
        self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
    end,
}

M.LspClients = {
    condition = conditions.lsp_attached,

    provider = function(self)
        -- Source:
        -- LunarVim - https://github.com/LunarVim/LunarVim/blob/a79de08d40f08e9a3b753175df11283ed737067c/lua/lvim/core/lualine/components.lua#L85-L116
        local ClientNames = {}
        local clientNames = ""

        if not next(self.Clients) then
            return ""
        end

        for _, client in pairs(self.Clients) do
            table.insert(ClientNames, client.name)
        end

        clientNames = "[" .. table.concat(ClientNames, " ") .. "]"

        -- return ClientNames
        return clientNames
    end,
}

M.LspDiagnostics = {
    condition = conditions.has_diagnostics,

    static = {
        errorIcon = i.lsp.error[1],
        warnIcon = i.lsp.warn[1],
        infoIcon = i.lsp.info[1],
        hintIcon = i.lsp.hint[1],
    },

    {
        flexible = h.Hide.lspDiagnosticIcons,
        {
            provider = function(self)
                return self.errors > 0 and (h.Separator.mid.provider .. self.errorIcon .. " " .. self.errors)
            end,
            hl = { fg = utils.get_highlight("DiagnosticError").fg },
        },
        {
            provider = function(self)
                return self.errors > 0 and (h.Separator.mid.provider .. self.errors)
            end,
            hl = { fg = utils.get_highlight("DiagnosticError").fg },
        },
    },

    {
        flexible = h.Hide.lspDiagnosticIcons,
        {
            provider = function(self)
                return self.warnings > 0 and (h.Separator.mid.provider .. self.warnIcon .. " " .. self.warnings)
            end,
            hl = { fg = utils.get_highlight("DiagnosticWarn").fg },
        },
        {
            provider = function(self)
                return self.warnings > 0 and (h.Separator.mid.provider .. self.warnings)
            end,
            hl = { fg = utils.get_highlight("DiagnosticWarn").fg },
        },
    },

    {
        flexible = h.Hide.lspDiagnosticIcons,
        {
            provider = function(self)
                return self.info > 0 and (h.Separator.mid.provider .. self.infoIcon .. " " .. self.info)
            end,
            hl = { fg = utils.get_highlight("DiagnosticInfo").fg },
        },
        {
            provider = function(self)
                return self.info > 0 and (h.Separator.mid.provider .. self.info)
            end,
            hl = { fg = utils.get_highlight("DiagnosticInfo").fg },
        },
    },

    {
        flexible = h.Hide.lspDiagnosticIcons,
        {
            provider = function(self)
                return self.hints > 0 and (h.Separator.mid.provider .. self.hintIcon .. " " .. self.hints)
            end,
            hl = { fg = utils.get_highlight("DiagnosticHint").fg },
        },
        {
            provider = function(self)
                return self.hints > 0 and (h.Separator.mid.provider .. self.hints)
            end,
            hl = { fg = utils.get_highlight("DiagnosticHint").fg },
        },
    },
}

M.LspBlock = utils.insert(
    LspBlock,

    { h.Separator.left },
    { flexible = h.Hide.lspIcon, {
        provider = i.lsp.lspIcon[1] .. " ",
    }, {
        h.Null,
    } },
    { flexible = h.Hide.lspClients, M.LspClients, { h.Null } },
    { M.LspDiagnostics },
    { h.Separator.right }
)

M.TerminalName = {
    { h.Separator.left },
    {
        provider = function()
            local terminalName, _ = vim.api.nvim_buf_get_name(0):gsub(".*:/bin/", "")
            return i.terminal[1] .. " " .. terminalName
        end,
    },
    { h.Separator.right },
}

M.ViMode = {
    -- get vim current mode, this information will be required by the provider
    -- and the highlight functions, so we compute it only once per component
    -- evaluation and store it as a component attribute
    init = function(self)
        if require("hydra.statusline").is_active() then
            self.mode = "hydra"
        else
            self.mode = vim.fn.mode(1) -- :h mode()
        end
        self.fileName = vim.api.nvim_buf_get_name(0)
        self.fileName = vim.fn.fnamemodify(self.fileName, ":t")

        -- execute this only once, this is required if you want the ViMode
        -- component to be updated on operator pending mode
        if not self.once then
            vim.api.nvim_create_autocmd("ModeChanged", {
                pattern = "*:*o",
                command = "redrawstatus",
            })
            self.once = true
        end
    end,
    -- Now we define some dictionaries to map the output of mode() to the
    -- corresponding string and color. We can put these into `static` to compute
    -- them at initialisation time.
    static = {
        mode_names = h.ModeNames,
        mode_colors = h.ModeHighlightGroups,
    },

    -- We can now access the value of mode() that, by now, would have been
    -- computed by `init()` and use it to index our strings dictionary.
    -- note how `static` fields become just regular attributes once the
    -- component is instantiated.
    -- To be extra meticulous, we can also add some vim statusline syntax to
    -- control the padding and make sure our string is always at least 2
    -- characters long. Plus a nice Icon.
    provider = function(self)
        local mode = self.mode_names[self.mode]

        -- print mode if in command mode
        if self.mode ~= "c" then
            -- print HYDRA if hydra is active
            if require("hydra.statusline").is_active() then
                mode = "HYDRA"
            end
        end

        return h.Separator.left.provider .. "%2(" .. mode .. "%)"
    end,

    h.Separator.right,

    -- Same goes for the highlight. Now the foreground will change according to the current mode.
    hl = function(self)
        local mode = self.mode:sub(1, 1) -- get only the first mode character
        local highlight = utils.get_highlight(self.mode_colors[mode])
        return { fg = highlight.fg, bg = highlight.bg, bold = true }
    end,
}

return M
