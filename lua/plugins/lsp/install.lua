local M = {}

local function get_lsp_servers(servers)
    local remap = require("mason-lspconfig.mappings").get_mason_map().lspconfig_to_package
    local mapped_servers = {}

    for _, server in ipairs(servers) do
        table.insert(mapped_servers, remap[server])
    end

    return mapped_servers
end

-- Maps a conform/nvim-lint tool name to its mason.nvim package name, for the
-- tools whose plugin name differs from the mason package name. Map a tool to
-- `false` to skip it entirely when no installable mason package exists.
local tool_to_mason = {
    php_cs_fixer = "php-cs-fixer", -- conform calls it "php_cs_fixer"; mason "php-cs-fixer"
    zsh = false, -- `zsh -n` uses the system shell; no mason package exists
}

-- Collect the mason package for every formatter (conform) and linter
-- (nvim-lint) configured for any filetype, de-duplicated. Both plugins are set
-- up in config.lua before this runs, so their tables are already populated.
local function get_formatter_linter_tools()
    local seen = {}
    local tools = {}

    local function add(name)
        local mapped = tool_to_mason[name]
        if mapped == false then return end
        local package = mapped or name
        if not seen[package] then
            seen[package] = true
            table.insert(tools, package)
        end
    end

    for _, formatters in pairs(require("conform").formatters_by_ft) do
        for _, name in ipairs(formatters) do
            add(name)
        end
    end

    for _, linters in pairs(require("lint").linters_by_ft) do
        for _, name in ipairs(linters) do
            add(name)
        end
    end

    return tools
end

local ensure_installed = function(servers)
    local tools = get_lsp_servers(servers)
    vim.list_extend(tools, get_formatter_linter_tools())

    return tools
end

function M.setup(servers)
    local loaded, mason_tool_installer = pcall(require, "mason-tool-installer")
    if not loaded then
        USER.loading_error_msg("mason-tool-installer")
        return
    end

    mason_tool_installer.setup({
        ensure_installed = ensure_installed(servers),
        auto_update = false,
        run_on_start = true,
    })
end

return M
