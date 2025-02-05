local function lsp_notification_config()
    local progress = vim.defaulttable()
    local icons = USER.styling.icons

    vim.api.nvim_create_autocmd("LspProgress", {
        ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
        callback = function(ev)
            local client = vim.lsp.get_client_by_id(ev.data.client_id)
            local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
            if not client or type(value) ~= "table" then return end
            local p = progress[client.id]

            for i = 1, #p + 1 do
                if i == #p + 1 or p[i].token == ev.data.params.token then
                    p[i] = {
                        token = ev.data.params.token,
                        msg = ("%3d%% %s%s"):format(
                            value.kind == "end" and 100 or value.percentage or 100,
                            value.title or "",
                            value.message and (" **%s**"):format(value.message) or ""
                        ),
                        done = value.kind == "end",
                    }
                    break
                end
            end

            local msg = {} ---@type string[]
            progress[client.id] = vim.tbl_filter(function(v) return table.insert(msg, v.msg) or not v.done end, p)

            local spinner = icons.loading.sphere
            vim.notify(table.concat(msg, "\n"), "info", {
                id = "lsp_progress",
                title = client.name,
                opts = function(notif)
                    notif.icon = #progress[client.id] == 0 and icons.lsp.loaded[1]
                        ---@diagnostic disable-next-line: undefined-field
                        or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
                end,
            })
        end,
    })
end

local function setup(snacks)
    local icons = USER.styling.icons
    local borders = USER.styling.borders.default

    snacks.setup({
        bigfile = {
            setup = function(ctx)
                vim.cmd("NoMatchParen")
                vim.cmd("SatelliteDisable")
                vim.cmd("Gitsigns detach")
                snacks.util.wo(0, { foldmethod = "manual", statuscolumn = "", conceallevel = 0 })
                vim.b.minianimate_disable = true
                vim.schedule(function() vim.bo[ctx.buf].syntax = ctx.ft end)
                require("illuminate").pause()
            end,
        },
        bufdelete = { enabled = false },
        dashboard = { enabled = false },
        debug = { enabled = false },
        git = { enabled = false },
        gitbrowse = { enabled = true },
        indent = {
            indent = {
                char = icons.indent.char[2],
                hl = {
                    "SnacksIndent1",
                    "SnacksIndent2",
                },
            },
            scope = {
                char = icons.indent.context_char[1],
                underline = false,
            },
        },
        lazygit = { enabled = false },
        notify = { enabled = true },
        notifier = {
            margin = { top = 1, right = 3, bottom = 1 },
            icons = {
                error = icons.lsp.error[1],
                warn = icons.lsp.warn[1],
                info = icons.lsp.info[1],
                debug = icons.bug[1],
                trace = icons.location[1],
            },
            top_down = false,
            more_format = string.format(" %s %%d lines ", icons.arrow.hollow.b),
        },
        quickfile = { enabled = false },
        rename = { enabled = true },
        scroll = { enabled = true },
        statuscolumn = { enabled = false },
        terminal = { enabled = false },
        toggle = { enabled = true },
        win = { enabled = false },
        words = {
            debounce = 500,
            modes = { "n", "i", "c" },
        },
        styles = {
            ["notification.history"] = {
                border = {
                    { borders.tl, "FloatBorder" },
                    { borders.t, "FloatBorder" },
                    { borders.tr, "FloatBorder" },
                    { borders.r, "FloatBorder" },
                    { borders.br, "FloatBorder" },
                    { borders.b, "FloatBorder" },
                    { borders.bl, "FloatBorder" },
                    { borders.l, "FloatBorder" },
                },
                minimal = true,
                width = 100,
                height = 0.6,
                wo = {
                    winhighlight = "FloatNormal:SnacksNotifierHistory",
                    colorcolumn = "",
                    conceallevel = 3,
                    number = true,
                    relativenumber = true,
                },
                keys = {
                    q = "close",
                    ["<Esc>"] = "close",
                },
            },
        },
    })
end

local function create_autocmd(snacks)
    vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
            snacks.toggle.option("spell", { name = "Spelling" }):map("<F1>s")
            snacks.toggle.option("wrap", { name = "Wrap" }):map("<F1>w")
            snacks.toggle.option("cursorcolumn", { name = "Cursor column" }):map("<F1>c")
            snacks.toggle.diagnostics():map("<F1>d")
            snacks.toggle
                .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
                :map("<F1>C")
            snacks.toggle.treesitter():map("<F1>t")
            snacks.toggle.inlay_hints():map("<F1>h")
            snacks.toggle.profiler():map("<F1>pp")
            snacks.toggle.profiler_highlights():map("<F1>ph")
        end,
    })
end

return {
    -- A collection of small QoL plugins for Neovim
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    config = function()
        local loaded, snacks = pcall(require, "snacks")
        if not loaded then
            USER.loading_error_msg("snacks.nvim")
            return
        end

        setup(snacks)
        create_autocmd(snacks)
        lsp_notification_config()
    end,
    opts = {
        filter = function(buf)
            return vim.g.snacks_indent ~= false and vim.b[buf].snacks_indent ~= false and vim.bo[buf].buftype == ""
        end,
    },
}
