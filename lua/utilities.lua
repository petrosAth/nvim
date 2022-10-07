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

---Creates a file with the given content on the specified path.
---@param path string The path of the file
---@param file string? The name of the file
---@param contents string? The content of the file
local function create_local_config_file(path, file, contents)
    file = file or ""
    contents = contents or ""

    if vim.fn.isdirectory(path) == 0 then
        vim.fn.mkdir(path)
        if file ~= "" then
            vim.cmd("!echo -e '" .. contents .. "' > " .. path .. file)
        end
    end
end

---Load custom hexokinase palettes from the project's local config directory.
---If the current working directory is the Neovim config path, load the
---currently active theme palette as well.
---@param cwd string Current working directory
---@return table palettes A table with all the palettes present in the local config palette directory
local function load_palettes(cwd)
    local path = cwd .. "/.nvim/palettes/"
    local file = "palette.json"
    local contents = [[{\
    \n  "colour_table": {\
    \n    "color1": "\#ffffff",\
    \n    "color2": "\#000000"\
    \n  }\
    \n}]]

    create_local_config_file(path, file, contents)

    if vim.fn.fnamemodify(cwd, ":t") == "nvim" then
        local current_theme_palette = _G.user.config_path
            .. "/lua/config/hexokinase/theme-palettes/"
            .. _G.user.theme
            .. ".json"
        table.insert(_G.user.palettes, current_theme_palette)
    end

    for _, palette in pairs(vim.fn.readdir(path)) do
        table.insert(_G.user.palettes, path .. palette)
    end

    return _G.user.palettes
end

---Return spell file's path in the project's local config directory. The "spell"
---directory is created if it isn't available.
---@param cwd string Current working directory
---@return string path Spell file's path
local function get_spell_file_dir(cwd)
    local path = cwd .. "/.nvim/spell/"

    create_local_config_file(path)

    return path
end

---Load the project's local config files.
---@param cwd string Current working directory
---@param config table Loading options
function _G.user.load_local_config(cwd, config)
    if string.find(cwd, "%.nvim") ~= nil then
        return
    end

    if config.use_palettes == true then
        vim.g.Hexokinase_palettes = load_palettes(cwd)
    end
    if config.use_spellfile == true then
        vim.opt.spellfile = get_spell_file_dir(cwd) .. "en.utf-8.add"
    end
end

---Create a project local config file, and open it in the editor.
---@param cwd string Current working directory
function _G.user.create_local_config(cwd)
    local path = cwd .. "/.nvim/"
    local file = "init.local.lua"
    local contents = [[_G.user.load_local_config(vim.fn.getcwd(), {\
    \n    use_palettes  = false,\
    \n    use_spellfile = true,\
    \n})]]

    create_local_config_file(path, file, contents)
    vim.cmd(":e " .. path .. file)
    vim.cmd.redraw()
end
