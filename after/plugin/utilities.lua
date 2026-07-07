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
        callback = function(args)
            require("conform").format({ bufnr = args.buf, lsp_format = "fallback", timeout_ms = 500 })
        end,
        group = group,
    })
    vim.notify("Enabled format on save", vim.log.levels.INFO, { title = "Format" })
end

---Delete augroup and disable auto format on save.
local function disable_format_on_save()
    vim.api.nvim_del_augroup_by_name("AutoFormat")
    vim.notify("Disabled format on save", vim.log.levels.INFO, { title = "Format" })
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
    "ToggleAutoFormat",
    function() toggle_format_on_save() end,
    { desc = "Toggle auto format on save" }
)

---Format the whole buffer, or a range when invoked with one (e.g. `:5,10Format`
---or from Visual mode via `'<,'>`). Deriving the range from the command's
---`line1`/`line2` with the full line length avoids conform's visual-detection
---off-by-one, which makes range-aware formatters like stylua skip the last line.
vim.api.nvim_create_user_command("Format", function(args)
    local range = nil
    if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = { start = { args.line1, 0 }, ["end"] = { args.line2, end_line:len() } }
    end
    require("conform").format({ async = true, lsp_format = "fallback", range = range })
end, { range = true, desc = "Format buffer or range with conform" })
------------------------------------------------------------------------------------------------------------------------
