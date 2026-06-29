---Display an error notification when a plugin fails to load via `require`.
---Call this immediately after a failed `pcall(require, ...)` guard.
---@param plugin_name string The plugin or module name that failed to load (e.g. "flash.nvim")
function USER.loading_error_msg(plugin_name)
    vim.notify(string.format("%s failed to load", plugin_name), vim.log.levels.ERROR, { title = "Loading failed" })
end

---Returns a truthy value when the current buffer belongs to a git repository,
---`nil` otherwise. Relies on `vim.b.gitsigns_head` and
---`vim.b.gitsigns_status_dict` — the buffer-local variables populated by
---gitsigns. Returns `nil` when gitsigns is not active for the buffer.
---@return string|table|nil # branch name string, status-dict table, or nil if not in a repo
function USER.is_git_repo() return vim.b.gitsigns_head or vim.b.gitsigns_status_dict end

---Scales a total editor dimension by `percentage`, clamped to [min, max].
---Uses total editor size (vim.o.columns / vim.o.lines), not the current window.
---@param dimensions "cols"|"lines"
---@param percentage number fraction of the dimension (e.g. 0.85)
---@param min number minimum return value
---@param max number maximum return value
---@return number
function USER.editor_scale(dimensions, percentage, min, max)
    local size = dimensions == "cols" and vim.o.columns or vim.o.lines
    return math.max(min, math.min(math.ceil(percentage * size), max))
end
