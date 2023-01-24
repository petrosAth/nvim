---Open a new buffer in the current window with the given name, pointing at the
---given path. If content is given, populate it with it. Also create the needed
---directories if they don't exist.
---@param file string path of the file.
---@param cursor? table Starting cursor position.
local function create_buffer(file, cursor)
    cursor = cursor or {}
    vim.cmd.edit(file)
    vim.api.nvim_win_set_cursor(0, cursor)
end

---Create and populate .gitignore file
local function create_gitignore()
    local cwd = vim.fn.getcwd()
    local templates_dir = USER.local_config.templates
    local gitignore_file = cwd .. "/.gitignore"

    local gitignore_template = vim.fn.readfile(templates_dir .. "/.gitignore")

    vim.fn.writefile(gitignore_template, gitignore_file, "a")
end

---Load custom hexokinase palettes from the project's local configuration
---directory. If the current working directory is the Neovim config path, load
---the currently active theme palette as well.
---@return table palettes Table containing the palettes.
local function get_palettes()
    local cwd = vim.fn.getcwd()
    local local_cfg_dir = cwd .. "/" .. USER.local_config.dir
    local palettes_dir = local_cfg_dir .. "/" .. USER.local_config.palettes_dir
    local palettes = {}

    if vim.fn.fnamemodify(cwd, ":t") == "nvim" then
        local current_theme_palette = vim.fn.stdpath("config")
            .. "/lua/plugins/hexokinase/theme-palettes/"
            .. USER.theme
            .. ".json"
        table.insert(palettes, current_theme_palette)
    end

    vim.fn.mkdir(palettes_dir, "p")

    for _, palette in pairs(vim.fn.readdir(palettes_dir)) do
        table.insert(palettes, palettes_dir .. "/" .. palette)
    end

    return palettes
end

---Return spell file's path in the project's local configuration directory. The
---"spell" directory is created if it doesn't exist.
---@return string path Spell file's path.
local function get_spell_file()
    local cwd = vim.fn.getcwd()
    local local_cfg_dir = cwd .. "/" .. USER.local_config.dir
    local spell_dir = local_cfg_dir .. "/" .. USER.local_config.spell_dir
    local spell_file = spell_dir .. "/en.utf-8.add"

    vim.fn.mkdir(spell_dir, "p")

    return spell_file
end

---Load the project's local config files.
---@param config table Table containing the loading options.
function USER.load_local_config(config)
    if config.use_session then
        vim.cmd.ProjectCreateSession()
    end
    if config.use_spellfile or config.use_vale then
        vim.opt.spellfile = get_spell_file()
    end
    if config.use_vale then
        vim.cmd.ProjectCreateValeConfig()
    end
    if config.use_palettes then
        vim.g.Hexokinase_palettes = get_palettes()
    end
    if config.use_prettier then
        vim.cmd.ProjectCreatePrettierConfig()
    end
    if config.use_format_on_save then
        vim.cmd.LspToggleAutoFormat()
    end
end

vim.api.nvim_create_user_command("ProjectCreateConfig", function()
    local cwd = vim.fn.getcwd()
    local templates_dir = USER.local_config.templates
    local local_cfg_dir = cwd .. "/" .. USER.local_config.dir
    local local_cfg_file = USER.local_config.file

    create_gitignore()

    vim.fn.mkdir(local_cfg_dir, "p")
    local local_cfg_template_file = templates_dir .. "/" .. local_cfg_file
    os.execute("cp " .. local_cfg_template_file .. " " .. local_cfg_dir)

    create_buffer(local_cfg_dir .. "/" .. local_cfg_file, { 2, 25 })
    vim.cmd.redraw()
end, { desc = "Create a project local config file, and open it in the current window" })

vim.api.nvim_create_user_command("ProjectCreatePalette", function()
    local cwd = vim.fn.getcwd()
    local templates_dir = USER.local_config.templates
    local local_cfg_dir = cwd .. "/" .. USER.local_config.dir
    local palettes_dir = local_cfg_dir .. "/" .. USER.local_config.palettes_dir
    local palette_file = palettes_dir .. "/" .. USER.local_config.palette_file

    vim.fn.mkdir(palettes_dir, "p")
    local palette_template_file = templates_dir .. "/" .. USER.local_config.palette_file
    os.execute("cp " .. palette_template_file .. " " .. palettes_dir)

    create_buffer(palette_file, { 3, 5 })
end, { desc = "Create a palette template in the local project's configuration directory" })

vim.api.nvim_create_user_command("ProjectCreateValeConfig", function()
    local cwd = vim.fn.getcwd()
    local templates_dir = USER.local_config.templates
    local local_cfg_dir = cwd .. "/" .. USER.local_config.dir
    local vale_dir = local_cfg_dir .. "/" .. USER.local_config.vale_dir
    local vale_file = USER.local_config.vale_file
    local spell_file_path = get_spell_file()

    vim.fn.mkdir(vale_dir, "p")
    if vim.fn.filereadable(vale_dir .. "/accept.txt") == 0 then
        os.execute("ln -s " .. spell_file_path .. " " .. vale_dir .. "/accept.txt")
    end
    if vim.fn.filereadable(vale_dir .. "/reject.txt") == 0 then
        os.execute("touch " .. vale_dir .. "/reject.txt")
    end
    if vim.fn.filereadable(vale_dir .. "/" .. vale_file) == 0 then
        local vale_template = templates_dir .. "/" .. vale_file
        os.execute("cp " .. vale_template .. " " .. cwd)
    end
end, { desc = "Create vale config file in the project root, and place styles in the local config directory." })

vim.api.nvim_create_user_command("ProjectCreatePrettierConfig", function()
    local cwd = vim.fn.getcwd()
    local templates_dir = USER.local_config.templates
    local prettier_file = USER.local_config.prettier_file

    if vim.fn.filereadable(cwd .. "/" .. prettier_file) == 1 then
        local prettier_file_template = templates_dir .. "/" .. prettier_file
        os.execute("cp " .. prettier_file_template .. " " .. cwd)
    end
end, { desc = "Create prettier config file in the project root." })
