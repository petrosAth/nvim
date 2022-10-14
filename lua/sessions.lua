---Extract the current working directory name for use as a session name.
---Returns the session's name and a boolean value indicating if there is
---alreade a session with the same name.
---@param cwd string The current working directory.
---@return string name Session's name.
---@return boolean exists True if the name is already used.
local function get_session_name(cwd)
    local saved = PA.data_path .. "/sessions/"
    local session = vim.fn.fnamemodify(cwd, ":t")

    if vim.fn.filereadable(saved .. session .. ".json") == 1 then
        return session, true
    end

    return session, false
end

---Save the local session, using the name of the current working directory.
---@param cwd string The current working directory.
function PA.save_local_session(cwd)
    cwd = cwd or vim.fn.getcwd()
    local session, available = get_session_name(cwd)

    if not available then
        vim.cmd.PossessionSave(session)
    end
end

---Load the local session based on the current working directory. If it doesn't
---exist throw a notification.
---@param cwd string The current working directory.
function PA.load_local_session(cwd)
    cwd = cwd or vim.fn.getcwd()
    local session, available = get_session_name(cwd)

    if not available then
        vim.notify("Cannot find local session", "error")
    else
        vim.cmd.PossessionLoad(session)
    end
end
