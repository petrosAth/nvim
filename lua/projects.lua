---Creates a file with the given content on the specified path.
---@param path string The path of the file
---@param file string The name of the file
---@param content table Text content in the form of a table with one line of
---text per entry.
local function create_file(path, file, content)
    if vim.fn.isdirectory(path) == 0 then
        vim.fn.mkdir(path)
    end

    for _, line in ipairs(content) do
        os.execute("echo '" .. line .. "' >> " .. path .. "/" .. file)
    end
end

---Open a new buffer in the current window with the given name, pointing at the
---given path. If content is given, populate it with it. Also create the needed
---directories if they don't exist.
---@param dir string Parent directory of the file.
---@param file string Name of the file.
---@param content table Text content in the form of a table with one line of
---text per entry.
---@param cursor table Starting cursor position.
local function create_buffer(dir, file, content, cursor)
    content = content or {}
    cursor = cursor or {}

    if vim.fn.isdirectory(dir) == 0 then
        vim.fn.mkdir(dir)
    end

    vim.cmd.edit(dir .. "/" .. file)
    local buf_id = vim.api.nvim_win_get_buf(0)

    vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, content)
    vim.api.nvim_win_set_cursor(0, cursor)
end

---Create and populate .gitignore file
---@param cwd string? Current working directory.
local function create_gitignore(cwd)
    cwd = cwd or vim.fn.getcwd()
    local file = ".gitignore"
    local content = {
        [[/.nvim/spell/]],
    }

    create_file(cwd, file, content)
end

---Create a palette template in the local project's configuration directory.
---The palettes folder is created if it doesn't exist.
---@param config_dir string Local project's configuration directory
function PA.create_local_palette(config_dir)
    config_dir = config_dir or PA.local_config.dir
    local dir = PA.local_config.palettes_dir
    local file = "palette.json"
    local path = config_dir .. "/" .. dir
    local content = {
        [[{]],
        [[  "colour_table": {]],
        [[    "color": "#ffffff"]],
        [[  }]],
        [[}]],
    }

    create_buffer(path, file, content, { 3, 5 })
end

---Load custom hexokinase palettes from the project's local configuration
---directory. If the current working directory is the Neovim config path, load
---the currently active theme palette as well.
---@param cwd string Current working directory.
---@param config_dir string Local project's configuration directory.
---@return table palettes Table containing the palettes.
local function get_palettes(cwd, config_dir)
    local dir = PA.local_config.palettes_dir
    local path = config_dir .. "/" .. dir
    local palettes = {}

    if vim.fn.fnamemodify(cwd, ":t") == "nvim" then
        local current_theme_palette = PA.config_path .. "/lua/config/hexokinase/theme-palettes/" .. PA.theme .. ".json"
        table.insert(palettes, current_theme_palette)
    end

    if vim.fn.isdirectory(path) == 0 then
        vim.fn.mkdir(path)
    end

    for _, palette in pairs(vim.fn.readdir(path)) do
        table.insert(palettes, path .. "/" .. palette)
    end

    return palettes
end

---Return spell file's path in the project's local configuration directory. The
---"spell" directory is created if it doesn't exist.
---@param cwd string Current working directory.
---@param config_dir string Local project's configuration directory.
---@return string path Spell file's path.
local function get_spell_file(cwd, config_dir)
    local dir = PA.local_config.spell_dir
    local file = "en.utf-8.add"
    local path = config_dir .. "/" .. dir

    if vim.fn.isdirectory(path) == 0 then
        vim.fn.mkdir(path)
    end

    return cwd .. "/" .. config_dir .. "/" .. dir .. "/" .. file
end

---Load the project's local config files.
---@param cwd string Current working directory.
---@param config table Table containing the loading options.
function PA.load_local_config(cwd, config)
    local dir = PA.local_config.dir

    if config.use_session == true then
        PA.save_local_session(cwd)
    end
    if config.use_spellfile == true then
        vim.opt.spellfile = get_spell_file(cwd, dir)
    end
    if config.use_palettes == true then
        vim.g.Hexokinase_palettes = get_palettes(cwd, dir)
    end
end

---Create a project local config file, and open it in the current window.
function PA.create_local_config()
    local dir = PA.local_config.dir
    local file = PA.local_config.file
    local content = {
        [[PA.load_local_config(vim.fn.getcwd(), {]],
        [[    use_session   = false,]],
        [[    use_spellfile = false,]],
        [[    use_palettes  = false,]],
        [[})]],
    }

    create_gitignore()
    vim.fn.mkdir(dir)
    create_buffer(dir, file, content, { 2, 20 })
    vim.cmd.redraw()
end

---Edit the local config file in the current window.
---@param cwd string? Current working directory.
function PA.edit_local_config(cwd)
    cwd = cwd or vim.fn.getcwd()
    local dir = PA.local_config.dir
    local file = PA.local_config.file

    vim.cmd.edit(dir .. "/" .. file)
end

---Edit the .gitignore file in the current window.
---@param cwd string? Current working directory.
function PA.edit_gitignore(cwd)
    cwd = cwd or vim.fn.getcwd()

    vim.cmd.edit(cwd .. "/" .. ".gitignore")
end
