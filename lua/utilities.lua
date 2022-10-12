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

---Creates a directory or file with the given content on the specified path.
---@param path string The path of the directory or file
---@param file string? The name of the file
---@param contents string? The content of the file
local function create_element(path, file, contents)
    file = file or ""
    contents = contents or ""

    if vim.fn.isdirectory(path) == 0 then
        vim.fn.mkdir(path)
        if file ~= "" then
            vim.cmd("!echo -e '" .. contents .. "' > " .. path .. file)
        end
    end
    vim.cmd.redraw()
end

---Deletes a file or folder, if it exists.
---@param path string The path of the element
---@param name string? The name of the element
local function delete_element(path, name)
    if vim.fn.isdirectory(path .. name) == 1 then
        vim.cmd("silent w !rm -rf " .. path .. name)
    elseif vim.fn.filereadable(path .. name) == 1 then
        vim.cmd("silent w !rm " .. path .. name)
    end
    vim.cmd.redraw()
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

    create_element(path, file, contents)

    if vim.fn.fnamemodify(cwd, ":t") == "nvim" then
        local current_theme_palette = PA.config_path
            .. "/lua/config/hexokinase/theme-palettes/"
            .. PA.theme
            .. ".json"
        table.insert(PA.palettes, current_theme_palette)
    end

    for _, palette in pairs(vim.fn.readdir(path)) do
        table.insert(PA.palettes, path .. palette)
    end

    return PA.palettes
end

---Return spell file's path in the project's local config directory. The "spell"
---directory is created if it isn't available.
---@param cwd string Current working directory
---@return string path Spell file's path
local function get_spell_file_dir(cwd)
    local path = cwd .. "/.nvim/spell/"

    create_element(path)

    return path
end

---Load the project's local config files.
---@param cwd string Current working directory
---@param config table Loading options
function PA.load_local_config(cwd, config)
    if string.find(cwd, "%.nvim") ~= nil then
        return
    end

    if config.use_session == true then
        PA.load_local_session(cwd)
        PA.save_local_session(cwd)
    end
    if config.use_spellfile == true then
        vim.opt.spellfile = get_spell_file_dir(cwd) .. "en.utf-8.add"
    end
    if config.use_palettes == true then
        vim.g.Hexokinase_palettes = load_palettes(cwd)
    end
end

---Create a project local config file, and open it in the editor.
function PA.create_local_config()
    local cwd = vim.fn.getcwd() .. "/.nvim/"
    local file = "init.local.lua"
    local contents = [[PA.load_local_config(vim.fn.getcwd(), {\
    \n    use_session   = true,\
    \n    use_spellfile = false,\
    \n    use_palettes  = false,\
    \n})]]

    create_element(cwd, file, contents)
    vim.cmd(":e " .. cwd .. file)
    vim.cmd.redraw()
end

---Delete the project's local config file.
function PA.delete_local_config(cwd)
    cwd = cwd or vim.fn.getcwd()
    local dir = "/.nvim/"

    delete_element(cwd, dir)
    vim.cmd.redraw()
end

function PA.get_session_name(cwd)
    cwd = cwd or vim.fn.getcwd()
    local saved = PA.data_path .. "/possession/"
    local session = vim.fn.fnamemodify(cwd, ":t")
    local available = true

    if vim.fn.filereadable(saved .. session .. ".json") == 1 then
        return session, available
    end

    return session, not available
end

function PA.save_local_session(cwd)
    cwd = cwd or vim.fn.getcwd()
    local session, available = PA.get_session_name(cwd)

    if available then
        return
    end

    vim.cmd.PossessionSave(session)
end

function PA.load_local_session(cwd)
    cwd = cwd or vim.fn.getcwd()
    local session, available = PA.get_session_name(cwd)

    if not available then
        vim.notify("There is no saved session for this project", "error")
    else
        vim.cmd.PossessionLoad(session)
    end
end
