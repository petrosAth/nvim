---Open file or directory with a system program
---Source: Neelfrost Neovim config
---https://github.com/Neelfrost/nvim-config/blob/634cf9db1ee5000e3e8d0bdad5050986caa3a057/lua/user/utils.lua#L23-L28
---@param program string Any system program with terminal functionality
---@vararg string args Arguments for program
local function launch_with_system_program(program, ...)
    vim.fn.system(string.format("%s %s", program, table.concat({ ... }, " ")))
end

vim.api.nvim_create_user_command("LaunchFile", function(args)
    local program = args.args
    local path = vim.fn.expand("%:p")

    launch_with_system_program(program, path)
end, { nargs = "*", desc = "Open file using a system program" })

vim.api.nvim_create_user_command("LaunchDir", function(args)
    local program = args.args
    local path = vim.fn.expand("%:p:h")

    launch_with_system_program(program, path)
end, { nargs = "*", desc = "Open directory using a system program" })

---Extract url from the word under the cursor.
---@param url string Any string.
---@return string url The extracted url if it is valid, or an empty string.
local function extract_url(url)
    if url ~= nil then
        url = string.gsub(url:gsub("^.+%(", ""), "%)$", "")
        url = string.gsub(string.gsub(url:gsub(",$", ""), "^['\"]", ""), "['\",]$", "")

        if string.match(url, "^%w[%w-]*/[%w-_.]+$") then
            return string.format("https://github.com/%s", url)
        elseif string.match(url, "^ftps?://.*") then
            return url
        elseif string.match(url, "^https?://.*") then
            return url
        elseif string.match(url, "^[%w]+[%w-]+%.+[%w]+[%w-]+$") then
            return url
        elseif string.match(url, "^[%w]+[%w-]+%.+[%w]+[%w-]+[./]+.*") then
            return url
        else
            return ""
        end
    end

    return ""
end

vim.api.nvim_create_user_command("LaunchURL", function(args)
    local program = args.args
    local url = extract_url(vim.fn.expand("<cWORD>"))

    if url ~= "" then
        launch_with_system_program(program, url)
    else
        print("No URL found!")
    end
end, { nargs = 1, desc = "Open URL using the system internet browser" })

---- Source: Ecovim ----------------------------------------------------------------------------------------------------
-- https://github.com/ecosse3/nvim/blob/58559b65f0e15384c3ed76b41bb3636a43141a0e/lua/lsp/functions.lua#L3-L25

---Create augroup and enable auto format on save.
local function enable_auto_format()
    local group = vim.api.nvim_create_augroup("AutoFormat", { clear = false })
    vim.api.nvim_create_autocmd("BufWritePre", {
        callback = function()
            vim.lsp.buf.format({
                filter = function(client) return client.name == "null-ls" end,
            })
        end,
        group = group,
    })
    vim.notify("Enabled format on save", "INFO", { title = "LSP" })
end

---Delete augroup and disable auto format on save.
local function disable_format_on_save()
    vim.api.nvim_del_augroup_by_name("AutoFormat")
    vim.notify("Disabled format on save", "INFO", { title = "LSP" })
end

---Toggle auto format on save.
local function toggle_format_on_save()
    if vim.fn.exists("#AutoFormat#BufWritePre") == 0 then
        enable_auto_format()
    else
        disable_format_on_save()
    end
end

vim.api.nvim_create_user_command(
    "LspToggleAutoFormat",
    function() toggle_format_on_save() end,
    { desc = "Toggle auto format on save" }
)
------------------------------------------------------------------------------------------------------------------------
