---Extract the current working directory name for use as a session name.
---Returns the session's name and a boolean value indicating if there is
---alreade a session with the same name.
---@param cwd string The current working directory.
---@return string name Session's name.
---@return boolean exists True if the name is already used.
local function get_session_name(cwd)
    local saved = vim.fn.stdpath("data") .. "/sessions/"
    local session = vim.fn.fnamemodify(cwd, ":t")

    if vim.fn.filereadable(saved .. session .. ".json") == 1 then
        return session, true
    end

    return session, false
end

vim.api.nvim_create_user_command("ProjectCreateSession", function()
    local cwd = vim.fn.getcwd()
    local session, available = get_session_name(cwd)

    if not available then
        vim.cmd.PossessionSave(session)
    end
end, { desc = "Save the local session, using the name of the current working directory" })

vim.api.nvim_create_user_command("ProjectLoadSession", function()
    local cwd = vim.fn.getcwd()
    local session, available = get_session_name(cwd)

    if not available then
        vim.notify("Cannot find local session", "error")
    else
        vim.cmd.PossessionLoad(session)
    end
end, { desc = "Load the local session based on the current working directory. If it doesn't exist throw a notification" })
