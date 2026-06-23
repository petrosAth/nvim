-- Parsers to install eagerly. Any other language is installed on demand the
-- first time a matching buffer is opened (see the FileType autocommand below),
-- preserving the old `auto_install = true` behaviour.
local ensure_installed = {
    "bash",
    "c",
    "css",
    "html",
    "javascript",
    "json",
    "lua",
    "markdown",
    "markdown_inline",
    "php",
    "python",
    "query",
    "regex",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "yaml",
}

-- Enable treesitter features for a buffer: highlighting (Neovim), folds
-- (Neovim) and indentation (nvim-treesitter).
local function enable_features(bufnr)
    pcall(vim.treesitter.start, bufnr)

    vim.api.nvim_buf_call(bufnr, function()
        vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.wo[0][0].foldmethod = "expr"
    end)

    vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
end

-- Highlight/fold/indent are not enabled automatically on the `main` branch; we
-- wire them up per buffer and install missing parsers on demand.
local function setup_features(nvim_treesitter)
    local augroup = vim.api.nvim_create_augroup("UserTreesitter", { clear = true })

    vim.api.nvim_create_autocmd("FileType", {
        group = augroup,
        callback = function(args)
            local bufnr = args.buf
            local ft = vim.bo[bufnr].filetype
            local lang = vim.treesitter.language.get_lang(ft)
            if not lang then return end

            local installed = nvim_treesitter.get_installed("parsers")
            if vim.list_contains(installed, lang) then
                enable_features(bufnr)
            elseif vim.list_contains(nvim_treesitter.get_available(), lang) then
                -- Install on demand, then enable once compilation finishes.
                nvim_treesitter.install(lang):await(function()
                    if vim.api.nvim_buf_is_valid(bufnr) then vim.schedule(function() enable_features(bufnr) end) end
                end)
            end
        end,
    })

    -- Enable features for buffers already loaded before the autocommand existed
    -- (e.g. the very first file opened on startup).
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(bufnr) then vim.api.nvim_exec_autocmds("FileType", { buffer = bufnr }) end
    end
end

-- Lightweight replacement for the old `incremental_selection` module, which no
-- longer exists on the `main` branch. Expands/shrinks the visual selection
-- along the treesitter node hierarchy.
local function setup_incremental_selection()
    local history = {}

    local function node_to_selection(node)
        local srow, scol, erow, ecol = node:range()
        vim.api.nvim_win_set_cursor(0, { srow + 1, scol })
        vim.cmd("normal! v")
        -- `ecol` is exclusive; step back one column to land on the last char.
        local end_col = ecol > 0 and ecol - 1 or 0
        vim.api.nvim_win_set_cursor(0, { erow + 1, end_col })
    end

    local function init_selection()
        history = {}
        local node = vim.treesitter.get_node()
        if not node then return end
        history[#history + 1] = node
        node_to_selection(node)
    end

    local function node_incremental()
        local current = history[#history]
        if not current then return init_selection() end
        local parent = current:parent()
        while parent and parent:range() == current:range() do
            parent = parent:parent()
        end
        if not parent then return end
        history[#history + 1] = parent
        node_to_selection(parent)
    end

    local function scope_incremental()
        local current = history[#history]
        if not current then return init_selection() end
        -- Walk up until the enclosing node spans more lines (approximates scope).
        local srow = current:range()
        local parent = current:parent()
        while parent do
            local psrow, _, perow = parent:range()
            if psrow < srow or perow > select(3, current:range()) then break end
            parent = parent:parent()
        end
        if not parent then return end
        history[#history + 1] = parent
        node_to_selection(parent)
    end

    local function node_decremental()
        if #history <= 1 then return end
        history[#history] = nil
        node_to_selection(history[#history])
    end

    local opts = { silent = true }
    vim.keymap.set("n", "<CR>", init_selection, vim.tbl_extend("force", opts, { desc = "Init selection" }))
    vim.keymap.set("x", "<CR>", node_incremental, vim.tbl_extend("force", opts, { desc = "Increment node" }))
    vim.keymap.set("x", "<S-CR>", scope_incremental, vim.tbl_extend("force", opts, { desc = "Increment scope" }))
    vim.keymap.set("x", "<BS>", node_decremental, vim.tbl_extend("force", opts, { desc = "Decrement node" }))
end

local function setup_textobjects()
    local loaded, textobjects = pcall(require, "nvim-treesitter-textobjects")
    if not loaded then
        USER.loading_error_msg("nvim-treesitter-textobjects")
        return
    end

    textobjects.setup({
        select = {
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
        },
        move = {
            -- whether to set jumps in the jumplist
            set_jumps = true,
        },
    })

    local select = require("nvim-treesitter-textobjects.select")
    local move = require("nvim-treesitter-textobjects.move")

    -- select
    local select_maps = {
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
    }
    for lhs, query in pairs(select_maps) do
        vim.keymap.set(
            { "x", "o" },
            lhs,
            function() select.select_textobject(query, "textobjects") end,
            { silent = true, desc = "Select " .. query }
        )
    end

    -- move
    local move_maps = {
        goto_next_start = {
            ["]a"] = "@parameter.inner",
            ["]m"] = "@function.outer",
            ["]]"] = "@class.outer",
        },
        goto_next_end = {
            ["]A"] = "@parameter.outer",
            ["]M"] = "@function.outer",
            ["]["] = "@class.outer",
        },
        goto_previous_start = {
            ["[a"] = "@parameter.inner",
            ["[m"] = "@function.outer",
            ["[["] = "@class.outer",
        },
        goto_previous_end = {
            ["[A"] = "@parameter.inner",
            ["[M"] = "@function.outer",
            ["[]"] = "@class.outer",
        },
    }
    for fn, maps in pairs(move_maps) do
        for lhs, query in pairs(maps) do
            vim.keymap.set(
                { "n", "x", "o" },
                lhs,
                function() move[fn](query, "textobjects") end,
                { silent = true, desc = fn .. " " .. query }
            )
        end
    end
end

local function setup_context_commentstring()
    local loaded, context_commentstring = pcall(require, "ts_context_commentstring")
    if not loaded then
        USER.loading_error_msg("ts_context_commentstring")
        return
    end

    context_commentstring.setup()
end

return {
    {
        -- The goal of nvim-treesitter is both to provide a simple and easy way to use the interface for tree-sitter in
        -- Neovim and to provide some basic functionality such as highlighting based on it.
        -- NOTE: the `main` branch is a full rewrite required for Neovim 0.12+; it does not support lazy-loading.
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        dependencies = {
            -- Syntax aware text-objects, select, move, swap, and peek support.
            {
                "nvim-treesitter/nvim-treesitter-textobjects",
                branch = "main",
            },
            -- Neovim treesitter plugin for setting the commentstring based on the cursor location in a file.
            "JoosepAlviste/nvim-ts-context-commentstring",
        },
        config = function()
            local loaded, nvim_treesitter = pcall(require, "nvim-treesitter")
            if not loaded then
                USER.loading_error_msg("nvim-treesitter")
                return
            end

            nvim_treesitter.install(ensure_installed)

            setup_features(nvim_treesitter)
            setup_incremental_selection()
            setup_textobjects()
            setup_context_commentstring()
        end,
    },
}
