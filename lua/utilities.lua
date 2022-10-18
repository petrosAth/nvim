---Edit a file or directory using a system program.
---Source: Neelfrost Neovim config
---https://github.com/Neelfrost/nvim-config/blob/bdffbc3c74fc5ee8b5789c8d9e3e68c0f1163e34/lua/user/utils.lua
---@param prog string Any system program with terminal functionality
---@param args string Path for a file or directory to edit
function PA.launch_ext_prog(prog, args)
    vim.cmd("!" .. prog .. " " .. args)
    vim.cmd.redraw()
end

---Open URL using the system internet browser.
---@param url string Any URL
function PA.open_url(url)
    if url ~= nil then
        url = string.gsub(url:gsub("^.+%(", ""), "%)$", "")
        url = string.gsub(string.gsub(url:gsub(",$", ""), "^['\"]", ""), "['\",]$", "")

        if string.match(url, "^%w[%w-]*/[%w-_.]+$") then
            vim.cmd([[!firefox --new-tab https://github.com/]] .. url)
        elseif string.match(url, "^ftps?://.*") then
            vim.cmd([[!firefox --new-tab ]] .. url)
        elseif string.match(url, "^https?://.*") then
            vim.cmd([[!firefox --new-tab ]] .. url)
        elseif string.match(url, "^[%w]+[%w-]+%.+[%w]+[%w-]+$") then
            vim.cmd([[!firefox --new-tab ]] .. url)
        elseif string.match(url, "^[%w]+[%w-]+%.+[%w]+[%w-]+[./]+.*") then
            vim.cmd([[!firefox --new-tab ]] .. url)
        else
            print("No URL found!")
        end
    else
        print("No URL found!")
    end
    vim.cmd.redraw()
end

---- Source: Ecovim ----------------------------------------------------------------------------------------------------
-- https://github.com/ecosse3/nvim/blob/58559b65f0e15384c3ed76b41bb3636a43141a0e/lua/lsp/functions.lua#L3-L25

---Create augroup and enable auto format on save.
function PA.enable_format_on_save()
    local group = vim.api.nvim_create_augroup("format_on_save", { clear = false })
    vim.api.nvim_create_autocmd("BufWritePre", {
        callback = function()
            vim.lsp.buf.format({
                filter = function(client)
                    return client.name == "null-ls"
                end,
            })
        end,
        group = group,
    })
    require("notify")("Enabled format on save", "info", { title = "LSP", timeout = 2000 })
end

---Delete augroup and disable auto format on save.
function PA.disable_format_on_save()
    vim.api.nvim_del_augroup_by_name("format_on_save")
    require("notify")("Disabled format on save", "info", { title = "LSP", timeout = 2000 })
end

---Toggle auto format on save.
function PA.toggle_format_on_save()
    if vim.fn.exists("#format_on_save#BufWritePre") == 0 then
        PA.enable_format_on_save()
    else
        PA.disable_format_on_save()
    end
end

vim.api.nvim_create_user_command("LspToggleAutoFormat", "lua PA.toggle_format_on_save()", {})
------------------------------------------------------------------------------------------------------------------------
