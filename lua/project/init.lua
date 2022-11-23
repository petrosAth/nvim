---Creates a file with the given content on the specified path.
---@param path string The path of the file
---@param file string The name of the file
---@param content? table Text content in the form of a table with one line of
---text per entry.
local function create_file(path, file, content)
    content = content or {}
    local file_path = string.format("%s/%s", path, file)
    if vim.fn.isdirectory(path) == 0 then
        vim.fn.mkdir(path, "p")
    end
    os.execute("touch " .. file_path)

    for _, line in ipairs(content) do
        os.execute(string.format("echo '%s' >> %s", line, file_path))
    end
end

---Open a new buffer in the current window with the given name, pointing at the
---given path. If content is given, populate it with it. Also create the needed
---directories if they don't exist.
---@param dir string Parent directory of the file.
---@param file string Name of the file.
---@param content? table Text content in the form of a table with one line of
---text per entry.
---@param cursor? table Starting cursor position.
local function create_buffer(dir, file, content, cursor)
    content = content or {}
    cursor = cursor or {}

    if vim.fn.isdirectory(dir) == 0 then
        vim.fn.mkdir(dir, "p")
    end

    vim.cmd.edit(dir .. "/" .. file)

    local buf_id = vim.api.nvim_win_get_buf(0)
    vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, content)
    vim.api.nvim_win_set_cursor(0, cursor)
end

---Create and populate .gitignore file
local function create_gitignore()
    local cwd = vim.fn.getcwd()
    local nvim_cfg_dir = USER.config_path
    local templates_dir = USER.local_config.templates
    local file = ".gitignore"

    local gitignore_template = nvim_cfg_dir .. "/" .. templates_dir .. "/" .. file
    local content = vim.fn.readfile(gitignore_template)

    vim.fn.writefile(content, cwd .. "/" .. file, "a")
end

---Load custom hexokinase palettes from the project's local configuration
---directory. If the current working directory is the Neovim config path, load
---the currently active theme palette as well.
---@param cwd string Current working directory.
---@param config_dir string Local project's configuration directory.
---@return table palettes Table containing the palettes.
local function get_palettes(cwd, config_dir)
    local dir = USER.local_config.palettes_dir
    local path = config_dir .. "/" .. dir
    local palettes = {}

    if vim.fn.fnamemodify(cwd, ":t") == "nvim" then
        local current_theme_palette = USER.config_path .. "/lua/config/hexokinase-config/theme-palettes/" .. USER.theme .. ".json"
        table.insert(palettes, current_theme_palette)
    end

    if vim.fn.isdirectory(path) == 0 then
        vim.fn.mkdir(path, "p")
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
    local dir = USER.local_config.spell_dir
    local file = "en.utf-8.add"
    local path = config_dir .. "/" .. dir

    if vim.fn.isdirectory(path) == 0 then
        vim.fn.mkdir(path, "p")
    end

    return cwd .. "/" .. config_dir .. "/" .. dir .. "/" .. file
end

---Load the project's local config files.
---@param cwd string Current working directory.
---@param config table Table containing the loading options.
function USER.load_local_config(cwd, config)
    local dir = USER.local_config.dir

    if config.use_session then
        vim.cmd.ProjectCreateSession()
    end
    if config.use_spellfile or config.use_vale then
        vim.opt.spellfile = get_spell_file(cwd, dir)
    end
    if config.use_vale then
        vim.cmd.ProjectCreateValeConfig()
    end
    if config.use_palettes then
        vim.g.Hexokinase_palettes = get_palettes(cwd, dir)
    end
    if config.use_format_on_save then
        vim.cmd.LspToggleAutoFormat()
    end
end

vim.api.nvim_create_user_command("ProjectCreateConfig", function()
    local dir = USER.local_config.dir
    local file = USER.local_config.file
    local content = {
        [[USER.load_local_config(vim.fn.getcwd(), {]],
        [[    use_session        = false,]],
        [[    use_spellfile      = false,]],
        [[    use_vale           = false,]],
        [[    use_palettes       = false,]],
        [[    use_format_on_save = false,]],
        [[})]],
    }

    create_gitignore()
    vim.fn.mkdir(dir, "p")
    create_buffer(dir, file, content, { 2, 25 })
    vim.cmd.redraw()
end, { desc = "Create a project local config file, and open it in the current window" })

vim.api.nvim_create_user_command("ProjectCreatePalette", function()
    local config_dir = USER.local_config.dir
    local dir = USER.local_config.palettes_dir
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
end, { desc = "Create a palette template in the local project's configuration directory" })

vim.api.nvim_create_user_command("ProjectCreateValeConfig", function()
    local cwd = vim.fn.getcwd()
    local local_cfg_dir = USER.local_config.dir
    local nvim_cfg_dir = USER.config_path
    local templates_dir = USER.local_config.templates
    local vale_dir = USER.local_config.vale_dir
    local vocab_dir = cwd .. "/" .. local_cfg_dir .. "/" .. vale_dir .. "/Vocab/Project"
    local vale_file = ".vale.ini"
    local spell_file_path = get_spell_file(cwd, local_cfg_dir)

    vim.fn.mkdir(vocab_dir, "p")
    os.execute("ln -s " .. spell_file_path .. " " .. vocab_dir .. "/accept.txt")
    create_file(vocab_dir, "/reject.txt")

    local copy_vale_template = string.format("cp %s/%s/%s %s", nvim_cfg_dir, templates_dir, vale_file, cwd)
    os.execute(copy_vale_template)
end, { desc = "Create a palette template in the local project's configuration directory" })
