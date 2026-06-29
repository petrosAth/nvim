vim.api.nvim_create_user_command("LaunchFile", function()
    local _, err = vim.ui.open(vim.fn.expand("%:p"))
    if err then vim.notify(err, vim.log.levels.ERROR) end
end, { nargs = 0, desc = "Open the current file with the system default handler" })

vim.api.nvim_create_user_command("LaunchDir", function()
    local _, err = vim.ui.open(vim.fn.expand("%:p:h"))
    if err then vim.notify(err, vim.log.levels.ERROR) end
end, { nargs = 0, desc = "Open the current directory with the system default handler" })

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

vim.api.nvim_create_user_command("LaunchURL", function()
    local url = extract_url(vim.fn.expand("<cWORD>"))
    if url == "" then
        vim.notify("No URL found under cursor", vim.log.levels.WARN)
        return
    end
    local _, err = vim.ui.open(url)
    if err then vim.notify(err, vim.log.levels.ERROR) end
end, { nargs = 0, desc = "Open the URL under the cursor with the system default browser" })

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
    vim.notify("Enabled format on save", vim.log.levels.INFO, { title = "LSP" })
end

---Delete augroup and disable auto format on save.
local function disable_format_on_save()
    vim.api.nvim_del_augroup_by_name("AutoFormat")
    vim.notify("Disabled format on save", vim.log.levels.INFO, { title = "LSP" })
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
