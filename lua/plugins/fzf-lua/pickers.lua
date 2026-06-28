local M = {}

local function fzf() return require("fzf-lua") end

-- Shared layout for the LSP location pickers: vertical preview, never auto-jump on a single result.
local lsp_opts = {
    jump1 = false,
    winopts = {
        preview = { layout = "vertical", vertical = "down:50%" },
    },
}

function M.lsp_references() fzf().lsp_references(lsp_opts) end

function M.lsp_definitions() fzf().lsp_definitions(lsp_opts) end

function M.lsp_type_definitions() fzf().lsp_typedefs(lsp_opts) end

function M.lsp_implementations() fzf().lsp_implementations(lsp_opts) end

-- Sessions: list possession sessions, load on <Enter>, delete on <C-d>.
function M.sessions()
    local ok, query = pcall(require, "possession.query")
    if not ok then
        USER.loading_error_msg("possession.nvim")
        return
    end

    local names = {}
    for _, data in ipairs(query.as_list()) do
        table.insert(names, data.name)
    end
    table.sort(names)

    fzf().fzf_exec(names, {
        prompt = "Sessions> ",
        actions = {
            ["enter"] = function(selected)
                if selected[1] then require("possession.session").load(selected[1]) end
            end,
            ["ctrl-d"] = function(selected)
                if selected[1] then require("possession.session").delete(selected[1]) end
            end,
        },
    })
end

-- Snippets: list LuaSnip snippets for the current filetype and expand the selection; the preview
-- pane renders the snippet body via a custom builtin previewer.
function M.snippets()
    local ok, luasnip = pcall(require, "luasnip")
    if not ok then
        USER.loading_error_msg("LuaSnip")
        return
    end

    local ft = vim.bo.filetype
    local entries, by_label = {}, {}
    for _, snip in ipairs(luasnip.get_snippets(ft) or {}) do
        local desc = type(snip.dscr) == "table" and snip.dscr[1] or snip.dscr
        local label = string.format("%s — %s", snip.trigger or "", desc or snip.name or "")
        table.insert(entries, label)
        by_label[label] = snip
    end

    if vim.tbl_isempty(entries) then
        vim.notify("No snippets for filetype: " .. (ft ~= "" and ft or "<none>"), vim.log.levels.INFO)
        return
    end
    table.sort(entries)

    -- Custom builtin previewer: render the selected snippet's docstring (the snippet body with its
    -- placeholders) into the preview buffer, syntax-highlighted for the current filetype.
    local builtin = require("fzf-lua.previewer.builtin")
    local SnippetPreviewer = builtin.base:extend()

    function SnippetPreviewer:new(o, opts, fzf_win)
        SnippetPreviewer.super.new(self, o, opts, fzf_win)
        setmetatable(self, SnippetPreviewer)
        return self
    end

    function SnippetPreviewer:populate_preview_buf(entry_str)
        local snip = by_label[entry_str]
        local buf = self:get_tmp_buffer()
        local doc = snip and snip:get_docstring() or { "" }
        -- get_docstring() may return a string or a table of lines; normalize to lines.
        local lines = type(doc) == "table" and doc or vim.split(doc, "\n", { plain = true })
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
        vim.bo[buf].filetype = ft
        self:set_preview_buf(buf)
        self.win:update_preview_scrollbar()
    end

    fzf().fzf_exec(entries, {
        prompt = "Snippets> ",
        previewer = SnippetPreviewer,
        actions = {
            ["enter"] = function(selected)
                local snip = selected[1] and by_label[selected[1]]
                if snip then
                    vim.cmd("startinsert!")
                    vim.defer_fn(function() luasnip.snip_expand(snip) end, 20)
                end
            end,
        },
    })
end

-- Dir-scoped search: pick a directory, then scope files/live_grep to it.
local function pick_dir(callback)
    fzf().fzf_exec("fd --type d --hidden --exclude .git", {
        prompt = "Directory> ",
        actions = {
            ["enter"] = function(selected)
                if selected[1] then callback(selected[1]) end
            end,
        },
    })
end

function M.dir_grep()
    pick_dir(function(dir) fzf().live_grep({ cwd = dir }) end)
end

function M.dir_files()
    pick_dir(function(dir) fzf().files({ cwd = dir }) end)
end

return M
