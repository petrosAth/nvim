local notify = require("notify")
local timeout = 1000
local i = USER.styling.icons
local b = USER.styling.borders.default
local client_notifs = {}
local spinner_frames = i.loading.braille

notify.setup({
    -- Animation style (see below for details)
    stages = "slide",

    -- Function called when a new window is opened, use for changing win settings/config
    on_open = function(win)
        if vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_win_set_config(win, {
                border = {
                    { b.tl, "FloatBorder" },
                    { b.t, "FloatBorder" },
                    { b.tr, "FloatBorder" },
                    { b.r, "FloatBorder" },
                    { b.br, "FloatBorder" },
                    { b.b, "FloatBorder" },
                    { b.bl, "FloatBorder" },
                    { b.l, "FloatBorder" },
                },
            })
        end
    end,

    -- Default timeout for notifications
    timeout = timeout,

    -- For stages that change opacity this is treated as the highlight behind the window
    -- Set this to either a highlight group or an RGB hex value e.g. "#000000"
    background_colour = "Normal",

    -- Minimum width for notification windows
    minimum_width = 50,

    -- Icons for the different levels
    icons = {
        ERROR = i.lsp.error[1],
        WARN = i.lsp.warn[1],
        INFO = i.lsp.info[1],
        DEBUG = i.bug[1],
        TRACE = i.location[1],
    },
})

vim.notify = notify

-- Utility functions shared between progress reports for LSP and DAP
local function get_notif_data(client_id, token)
    if not client_notifs[client_id] then
        client_notifs[client_id] = {}
    end

    if not client_notifs[client_id][token] then
        client_notifs[client_id][token] = {}
    end

    return client_notifs[client_id][token]
end

local function update_spinner(client_id, token)
    local notif_data = get_notif_data(client_id, token)

    if notif_data.spinner then
        local new_spinner = (notif_data.spinner + 1) % #spinner_frames
        notif_data.spinner = new_spinner

        notif_data.notification = vim.notify(nil, nil, {
            hide_from_history = true,
            icon = spinner_frames[new_spinner],
            replace = notif_data.notification,
        })

        vim.defer_fn(function()
            update_spinner(client_id, token)
        end, 100)
    end
end

local function format_title(title, client_name)
    return client_name .. (#title > 0 and ": " .. title or "")
end

local function format_message(message, percentage)
    return (percentage and percentage .. "%\t" or "") .. (message or "")
end

local null_ls_token = nil
local function is_spam_message(client_id, result, val)
    local name = vim.lsp.get_client_by_id(client_id).name
    local bad_filetype = { "lua", "zsh" }

    if name == "null-ls" then
        if result.token == null_ls_token then
            return true
        end
        for _, filetype in pairs(bad_filetype) do
            if vim.bo.filetype == filetype then
                if val.title == "diagnostics" and val.message == nil then
                    null_ls_token = result.token
                    return true
                end
            end
        end
    end
end

-- LSP integration
-- Make sure to also have the snippet with the common helper functions in your config!
vim.lsp.handlers["$/progress"] = function(_, result, ctx)
    local client_id = ctx.client_id
    local val = result.value

    if not val.kind then
        return
    end

    if is_spam_message(client_id, result, val) then
        return
    end

    local notif_data = get_notif_data(client_id, result.token)

    if val.kind == "begin" then
        local message = format_message(val.message, val.percentage)

        notif_data.notification = vim.notify(message, "info", {
            title = format_title(val.title, vim.lsp.get_client_by_id(client_id).name),
            icon = spinner_frames[1],
            timeout = false,
            hide_from_history = false,
        })

        notif_data.spinner = 1
        update_spinner(client_id, result.token)
    elseif val.kind == "report" and notif_data then
        notif_data.notification = vim.notify(format_message(val.message, val.percentage), "info", {
            replace = notif_data.notification,
            hide_from_history = false,
        })
    elseif val.kind == "end" and notif_data then
        notif_data.notification = vim.notify(val.message and format_message(val.message) or "Complete", "info", {
            icon = i.done[1],
            replace = notif_data.notification,
            timeout = timeout,
        })

        notif_data.spinner = nil
    end
end
