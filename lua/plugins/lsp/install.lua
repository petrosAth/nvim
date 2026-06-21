local M = {}

local function get_lsp_servers(servers)
    local remap = require("mason-lspconfig.mappings").get_mason_map().lspconfig_to_package
    local mapped_servers = {}

    for _, server in ipairs(servers) do
        table.insert(mapped_servers, remap[server])
    end

    return mapped_servers
end

-- Maps a null-ls source name to its mason.nvim package name, for the sources
-- whose null-ls name differs from the mason package name. Map a source to
-- `false` to skip it entirely when no installable mason package exists.
local null_ls_to_mason = {
    phpcsfixer = "php-cs-fixer", -- null-ls calls it "phpcsfixer"; mason "php-cs-fixer"
    zsh = false, -- `zsh -n` uses the system shell; no mason package exists
}

local function get_null_ls_sources()
    local sources_table = require("null-ls").get_sources()
    local sources = {}

    for _, source in ipairs(sources_table) do
        local mapped = null_ls_to_mason[source["name"]]
        if mapped ~= false then table.insert(sources, mapped or source["name"]) end
    end

    return sources
end

local ensure_installed = function(servers)
    local tools = get_lsp_servers(servers)
    vim.list_extend(tools, get_null_ls_sources())

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
