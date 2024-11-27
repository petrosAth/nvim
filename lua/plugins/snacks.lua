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
        statuscolumn = { enabled = false },
        terminal = { enabled = false },
        toggle = {
            enabled = true,
            map = vim.keymap.set, -- keymap.set function to use
            which_key = true, -- integrate with which-key to show enabled/disabled icons and colors
            notify = true, -- show a notification when toggling
            -- icons for enabled/disabled states
            icon = {
                enabled = " ",
                disabled = " ",
            },
            -- colors for enabled/disabled states
            color = {
                enabled = "green",
                disabled = "yellow",
            },
        },
        win = { enabled = false },
        words = { enabled = false },
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
                title = " Notification History ",
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

return {
    -- A collection of small QoL plugins for Neovim
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    dependencies = {
        -- (Neo)Vim plugin for automatically highlighting other uses of the word under the cursor using either LSP,
        -- Tree-sitter, or regex matching.
        "RRethy/vim-illuminate",
    },
    config = function()
        local loaded, snacks = pcall(require, "snacks")
        if not loaded then
            USER.loading_error_msg("snacks.nvim")
            return
        end

        setup(snacks)
        lsp_notification_config()
    end,
    init = function()
        vim.api.nvim_create_autocmd("User", {
            pattern = "VeryLazy",
            callback = function()
                require("snacks").toggle.option("spell", { name = "Spelling" }):map("<F1>s")
                require("snacks").toggle.option("wrap", { name = "Wrap" }):map("<F1>w")
                require("snacks").toggle.option("cursorcolumn", { name = "Cursor column" }):map("<F1>c")
                require("snacks").toggle.diagnostics():map("<F1>d")
                require("snacks").toggle
                    .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
                    :map("<F1>C")
                require("snacks").toggle.treesitter():map("<F1>t")
                require("snacks").toggle.inlay_hints():map("<F1>h")
            end,
        })
    end,
}
