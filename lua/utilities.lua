function USER.loading_error_msg(plugin_name)
    vim.notify(plugin_name, "ERROR", { title = "Loading failed" })
end

---Returns true if the provided directory is part of a git repository
---@param cwd string
---@return boolean
function USER.is_git_repo(cwd) return vim.uv.fs_stat(cwd .. "/.git") and true or false end
