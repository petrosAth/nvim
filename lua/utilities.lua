---Edit a file or directory using a system program.
---Source: Neelfrost Neovim config
---https://github.com/Neelfrost/nvim-config/blob/bdffbc3c74fc5ee8b5789c8d9e3e68c0f1163e34/lua/user/utils.lua
---@param prog string Any system program with terminal functionality
---@param args string Path for a file or directory to edit
function _G.launch_ext_prog(prog, args)
    vim.cmd("!" .. prog .. " " .. args)
    vim.cmd.redraw()
end

---Open URL using the system internet browser.
---@param url string Any URL
function _G.open_url(url)
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
