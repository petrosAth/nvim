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
local function create_gitignore(type)
    local legal_types = {
        django = ".django",
    }
    local cwd = vim.uv.cwd()
    local templates_dir = USER.local_config.templates
    local gitignore_file = string.format("%s/.gitignore", cwd)
    local gitignore_template_file = string.format("%s/.gitignore", templates_dir)
    if type then gitignore_template_file = string.format("%s%s", gitignore_template_file, legal_types[type]) end

    local gitignore_template = vim.fn.readfile(gitignore_template_file)

    vim.fn.writefile(gitignore_template, gitignore_file, "a")
end

---Load custom palettes from the project's local configuration
---directory. If the current working directory is the Neovim config path, load
---the currently active theme palette as well.
---@return table palettes Table containing the palettes.
local function get_palettes()
    local cwd = vim.uv.cwd()
    local local_cfg_dir = string.format("%s/%s", cwd, USER.local_config.dir)
    local palettes_dir = string.format("%s/%s", local_cfg_dir, USER.local_config.palettes_dir)
    local palettes = {}

    if vim.fn.fnamemodify(cwd, ":t") == "nvim" then
        palettes = require(string.format("themes.palettes.%s", USER.theme)).base
    end

    vim.fn.mkdir(palettes_dir, "p")

    for _, palette in pairs(vim.fn.readdir(palettes_dir)) do
        palette = dofile(string.format("%s/%s", palettes_dir, palette))
        palettes = vim.tbl_deep_extend("error", palettes, palette)
    end

    return palettes
end

---Return spell file's path in the project's local configuration directory. The
---"spell" directory is created if it doesn't exist.
---@return string path Spell file's path.
local function get_spell_file()
    local cwd = vim.uv.cwd()
    local local_cfg_dir = string.format("%s/%s", cwd, USER.local_config.dir)
    local spell_dir = string.format("%s/%s", local_cfg_dir, USER.local_config.spell_dir)
    local spell_file = string.format("%s/en.utf-8.add", spell_dir)

    vim.fn.mkdir(spell_dir, "p")

    return spell_file
end

---Load the project's local config files.
---@param config table Table containing the loading options.
function USER.load_local_config(config)
    if config.use_session then vim.cmd.ProjectCreateSession() end
    if config.use_spellfile then vim.opt.spellfile = get_spell_file() end
    if config.use_palettes then USER.local_config.palettes = get_palettes() end
    if config.use_prettier then vim.cmd.ProjectCreatePrettierConfig() end
    if config.use_editorconfig then vim.cmd.ProjectCreateEditorConfig() end
    if config.use_format_on_save then vim.cmd.LspToggleAutoFormat() end
end

vim.api.nvim_create_user_command("ProjectCreateConfig", function()
    local cwd = vim.uv.cwd()
    local templates_dir = USER.local_config.templates
    local local_cfg_dir = string.format("%s/%s", cwd, USER.local_config.dir)
    local local_cfg_file = ".nvim.lua"

    create_gitignore()

    vim.fn.mkdir(local_cfg_dir, "p")
    local local_cfg_template_file = string.format("%s/%s", templates_dir, local_cfg_file)
    os.execute(string.format("cp %s %s", local_cfg_template_file, cwd))

    create_buffer(string.format("%s/%s", cwd, local_cfg_file), { 2, 25 })
    vim.cmd.redraw()
end, { desc = "Create a project local config file, and open it in the current window" })

vim.api.nvim_create_user_command("ProjectCreatePalette", function()
    local cwd = vim.uv.cwd()
    local templates_dir = USER.local_config.templates
    local local_cfg_dir = string.format("%s/%s", cwd, USER.local_config.dir)
    local palettes_dir = string.format("%s/%s", local_cfg_dir, USER.local_config.palettes_dir)
    local palette_file = string.format("%s/%s", palettes_dir, USER.local_config.palette_file)

    vim.fn.mkdir(palettes_dir, "p")
    local palette_template_file = string.format("%s/%s", templates_dir, USER.local_config.palette_file)
    os.execute(string.format("cp %s %s", palette_template_file, palettes_dir))

    create_buffer(palette_file, { 3, 5 })
end, { desc = "Create a palette template in the local project's configuration directory" })

vim.api.nvim_create_user_command("ProjectCreatePrettierConfig", function()
    local cwd = vim.uv.cwd()
    local templates_dir = USER.local_config.templates
    local prettier_file = USER.local_config.prettier_file

    if vim.fn.filereadable(string.format("%s/%s", cwd, prettier_file)) == 0 then
        local prettier_file_template = string.format("%s/%s", templates_dir, prettier_file)
        os.execute(string.format("cp %s %s", prettier_file_template, cwd))
    end
end, { desc = "Create prettier config file in the project root." })

vim.api.nvim_create_user_command("ProjectCreateEditorConfig", function()
    local cwd = vim.uv.cwd()
    local templates_dir = USER.local_config.templates
    local editorconfig_file = ".editorconfig"

    if vim.fn.filereadable(string.format("%s/%s", cwd, editorconfig_file)) == 0 then
        local editorconfig_file_template = string.format("%s/%s", templates_dir, editorconfig_file)
        os.execute(string.format("cp %s %s", editorconfig_file_template, cwd))
    end
end, { desc = "Create EditorConfig file in the project root." })

vim.api.nvim_create_user_command(
    "ProjectCreateGitignore",
    function() create_gitignore() end,
    { desc = "Create or update the .gitignore file." }
)

vim.api.nvim_create_user_command(
    "ProjectAppendGitignoreDjango",
    function() create_gitignore("django") end,
    { desc = "Create or update the .gitignore file with Django-specific rules." }
)
