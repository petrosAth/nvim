local builtin = require("telescope.builtin")
local cb = require("cosmetics").border.table

local M = {}

M.borderchars = {--{{{
 -- prompt  = {   "─",   "│",   " ",   "│",   "╭",   "╮",   "│",   "│"  },
    prompt  = {  cb.t,  cb.r,  cb.b,  cb.l, cb.tl, cb.tr, cb.br,  cb.bl },
 -- results = {   "─",   "│",   "─",   "│",   "├",   "┤",  "╯",  "╰"  },
    results = {  cb.t,  cb.r,  cb.b,  cb.l, cb.tl, cb.tr, cb.br,  cb.bl },
 -- preview = {   "─",   "│",   "─",   "│",   "╭",   "╮",  "╯",  "╰"  },
    preview = {  cb.t,  cb.r,  cb.b,  cb.l, cb.tl, cb.tr, cb.br,  cb.bl }
}--}}}

-- Customize buffers display to look like LeaderF
-- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes
function M.custom_buffers(opts)--{{{
    local devicons = require"nvim-web-devicons"
    local entry_display = require("telescope.pickers.entry_display")

    local filter = vim.tbl_filter
    local map = vim.tbl_map

    opts = opts or {}
    local default_icons, _ = devicons.get_icon("file", "", {default = true})

    local bufnrs = filter(function(b)
        return 1 == vim.fn.buflisted(b)
    end, vim.api.nvim_list_bufs())

    local max_bufnr = math.max(unpack(bufnrs))
    local bufnr_width = #tostring(max_bufnr)

    local max_bufname = math.max(
        unpack(
            map(function(bufnr)
                return vim.fn.strdisplaywidth(vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":p:t"))
            end, bufnrs)
        )
    )

    local displayer = entry_display.create {
        separator = " ",
        items = {
            { width = bufnr_width },
            { width = 4 },
            { width = vim.fn.strwidth(default_icons) },
            { width = max_bufname },
            { remaining = true },
        },
    }

    local make_display = function(entry)
        return displayer {
            {entry.bufnr, "TelescopeResultsNumber"},
            {entry.indicator, "TelescopeResultsComment"},
            {entry.devicons, entry.devicons_highlight},
            entry.file_name,
            {entry.dir_name, "Comment"}
        }
    end

    return function(entry)
        local bufname = entry.info.name ~= "" and entry.info.name or "[No Name]"
        local hidden = entry.info.hidden == 1 and "h" or "a"
        local readonly = vim.api.nvim_buf_get_option(entry.bufnr, "readonly") and "=" or " "
        local changed = entry.info.changed == 1 and "+" or " "
        local indicator = entry.flag .. hidden .. readonly .. changed

        local dir_name = vim.fn.fnamemodify(bufname, ":p:h")
        local file_name = vim.fn.fnamemodify(bufname, ":p:t")

        local icons, highlight = devicons.get_icon(bufname, string.match(bufname, "%a+$"), { default = true })

        return {
            valid = true,

            value = bufname,
            ordinal = entry.bufnr .. " : " .. file_name,
            display = make_display,

            bufnr = entry.bufnr,

            lnum = entry.info.lnum ~= 0 and entry.info.lnum or 1,
            indicator = indicator,
            devicons = icons,
            devicons_highlight = highlight,

            file_name = file_name,
            dir_name = dir_name,
        }
    end
end--}}}

-- Custom telescope pickers
-- Return lsp workspace root dir if exists, else return cwd
-- local function custom_cwd()--{{{
--     local exists, lsp_cwd = pcall(vim.lsp.buf.list_workspace_folders)
--     if (exists) then
--         return lsp_cwd[1]
--     else
--         return vim.fn.getcwd()
--     end
-- end--}}}

function M.find_files()--{{{
    builtin.find_files {
        -- cwd = custom_cwd(),
        results_title = "File search",
		prompt_title = false
    }
end--}}}

function M.find_recent()--{{{
    require("telescope").extensions.frecency.frecency {
        results_title = "Recent",
		prompt_title = false
    }
end--}}}

function M.live_grep()--{{{
    builtin.live_grep {
        -- cwd = custom_cwd(),
        results_title = "ripGREP search",
        prompt_title = false
    }
end--}}}

function M.file_browser()--{{{
    builtin.file_browser {
        -- cwd = custom_cwd(),
        results_title = "File explorer",
        prompt_title = false,
    }
end--}}}

function M.project()--{{{
    require('telescope').extensions.project.project{
        display_type = 'full',
        prompt_title = false,
        layout_config = {
            width = 0.5,
            height = 0.6
        }
    }
end--}}}

function M.buffers()--{{{
    builtin.buffers {
        entry_maker = M.custom_buffers(),
        previewer = false,
        layout_strategy = "vertical",
        layout_config = {
            width = 0.6,
            height = 0.6
        }
    }
end--}}}

function M.registers(opts)--{{{
    if opts == "small" then--{{{
        builtin.registers {
            results_title = "Registers",
            prompt_title = false,
            sorting_strategy = "ascending",
            layout_strategy = "cursor",
            layout_config = {
                width = 0.2,
                height = 0.4
            },
            borderchars = {
                prompt  = { cb.t,  cb.r,  cb.b,  cb.l, cb.tl, cb.tr, cb.br,  cb.bl },
                results = { cb.t,  cb.r,  cb.b,  cb.l, cb.ml, cb.mr, cb.br,  cb.bl },
                preview = { cb.t,  cb.r,  cb.b,  cb.l, cb.tl, cb.tr, cb.br,  cb.bl }
            }
            }--}}}
    elseif opts == "large" then--{{{
        builtin.registers {
            results_title = "Registers",
            prompt_title = false,
            layout_config = {
                width = 0.99,
                height = 0.99
            },
        }
    end--}}}
end--}}}

function M.lsp_code_actions()--{{{
    builtin.lsp_code_actions({
        results_title = "LSP Code actions",
        prompt_title = false,
        previewer = false,
		sorting_strategy = "ascending",
        layout_strategy = "cursor",
        layout_config = {
            width = 0.4,
            height = 0.2
        },
        borderchars = {
            prompt  = { cb.t,  cb.r,  cb.b,  cb.l, cb.tl, cb.tr, cb.br,  cb.bl },
            results = { cb.t,  cb.r,  cb.b,  cb.l, cb.ml, cb.mr, cb.br,  cb.bl },
            preview = { cb.t,  cb.r,  cb.b,  cb.l, cb.tl, cb.tr, cb.br,  cb.bl }
        }
    })
end--}}}

function M.lsp_references()--{{{
    builtin.lsp_references({
        results_title = "LSP References",
        prompt_title = false,
        jump_type = 'never',
        layout_strategy = "vertical",
        layout_config = {
            preview_height = 0.6,
            prompt_position = "bottom",
            width = 80,
            height = 30
        }
    })
end--}}}

function M.lsp_definitions()--{{{
    builtin.lsp_definitions({
        results_title = "LSP Definitions",
        prompt_title = false,
        jump_type = 'never',
        layout_strategy = "vertical",
        layout_config = {
            preview_height = 0.6,
            prompt_position = "bottom",
            width = 80,
            height = 30
        }
    })
end--}}}

function M.lsp_type_definitions()--{{{
    builtin.lsp_type_definitions({
        results_title = "LSP Type Definitions",
        prompt_title = false,
        jump_type = 'never',
        layout_strategy = "vertical",
        layout_config = {
            preview_height = 0.6,
            prompt_position = "bottom",
            width = 80,
            height = 30
        }
    })
end--}}}

function M.lsp_implementations()--{{{
    builtin.lsp_implementations({
        results_title = "LSP Implementations",
        prompt_title = false,
        jump_type = 'never',
        layout_strategy = "vertical",
        layout_config = {
            preview_height = 0.6,
            prompt_position = "bottom",
            width = 80,
            height = 30
        }
    })
end--}}}

return M
