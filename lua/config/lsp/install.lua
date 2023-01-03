local M = {}

local function get_lsp_servers(servers)
    local remap = require("mason-lspconfig.mappings.server").lspconfig_to_package
    local mapped_servers = {}

    for _, server in ipairs(servers) do
        table.insert(mapped_servers, remap[server])
    end

    return mapped_servers
end

local function get_null_ls_sources()
    local sources_table = require("null-ls").get_sources()
    local sources = {}

    for _, source in ipairs(sources_table) do
        if source["name"] ~= "zsh" then
            table.insert(sources, source["name"])
        end
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
        vim.notify("mason-tool-installer.nvim", "ERROR", { title = "Loading failed" })
        return
    end

    mason_tool_installer.setup({
        ensure_installed = ensure_installed(servers),
        auto_update = false,
        run_on_start = true,
    })
end

return M
