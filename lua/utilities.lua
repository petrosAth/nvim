-- Source:
-- https://github.com/Neelfrost/nvim-config/blob/bdffbc3c74fc5ee8b5789c8d9e3e68c0f1163e34/lua/user/utils.lua
-- Launch external program
function _G.launch_ext_prog(prog, args)
    vim.api.nvim_command("!" .. prog .. " " .. args)
    vim.cmd.redraw()
end

-- Open link in browser
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

---Load custom hexokinase palettes from the project's local config directory.
---If the current working directory is the Neovim config path, load the
---currently active theme palette as well.
---@param cwd string Current working directory
---@return table palettes A table with all the palettes present in the local config palette directory
function _G.user.load_palettes(cwd)
    local local_config = cwd .. "/.nvim/palettes/"

    if vim.fn.fnamemodify(cwd, ":t") == "nvim" then
        local current_theme_palette = CONFIG_PATH
            .. "/lua/config/hexokinase/theme-palettes/"
            .. _G.user.theme
            .. ".json"
        table.insert(_G.user.palettes, current_theme_palette)
    end

    for _, palette in pairs(vim.fn.readdir(local_config)) do
        table.insert(_G.user.palettes, local_config .. palette)
    end

    return _G.user.palettes
end

---Return spell file's path in the project's local config directory. It also
---creates the "spell" directory in case it doesn't exist.
---@param cwd string Current working directory
---@return string path Spell file's path
function _G.user.spell_file_dir(cwd)
    local local_config = cwd .. "/.nvim/spell/"
    if vim.fn.isdirectory(local_config) == 0 then
        vim.fn.mkdir(local_config)
    end

    return local_config
end
