---Spqwn an error notification with the argument as the message body
---@param plugin_name string
function USER.loading_error_msg(plugin_name) vim.notify(plugin_name, "ERROR", { title = "Loading failed" }) end

---Returns true if the provided directory is part of a git repository
---@param cwd string
---@return boolean
function USER.is_git_repo() return vim.b.gitsigns_head or vim.b.gitsigns_status_dict end
