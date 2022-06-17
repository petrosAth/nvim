local telescope = require("telescope")
local builtin = require("telescope.builtin")
local i = require("styling").icons
local b = require("styling").borders.default
local bn = require("styling").borders.none

local M = {}

M.borderchars = {
--  prompt  = { "🬂",   "▐",   "🬭",   "▌",   "🬕",   "🬨",   "▐",   "▌"   }
    prompt  = { b.t,   b.r,   b.b,   b.l,   b.tl,  b.tr,  b.br,  b.bl  },
--  results = { "🬂",   "▐",   "🬭",   "▌",   "🬛",   "🬫",   "🬷",   "🬲"   },
    results = { b.t,   b.r,   b.b,   b.l,   b.tl,  b.tr,  b.br,  b.bl  },
--  preview = { "🬂",   "▐",   "🬭",   "▌",   "🬕",   "🬨",   "🬷",   "🬲"   },
    preview = { b.t,   b.r,   bn.b,  b.l,   b.tl,  b.tr,  b.r,   b.l   },
        }

-- Customize buffers display to look like LeaderF
-- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes
function M.custom_buffers(opts)
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
end

function M.find_recent()
    telescope.extensions.frecency.frecency{
        prompt_title = "Recent Files",
    }
end

function M.project()
    telescope.extensions.project.project{
        display_type = "full",
        results_title = "Results",
        layout_config = {
            width = 0.5,
            height = 0.6
        }
    }
end

function M.buffers()
    builtin.buffers {
        entry_maker = M.custom_buffers(),
        previewer = false,
        layout_strategy = "vertical",
        layout_config = {
            width = 0.6,
            height = 0.6
        }
    }
end

function M.registers(opts)
    if opts == "small" then
        builtin.registers {
            results_title = false,
            sorting_strategy = "ascending",
            layout_strategy = "cursor",
            layout_config = {
                width = 0.2,
                height = 0.4
            },
            borderchars = {
--              prompt  = { "🬂",   "▐",   "🬭",   "▌",   "🬕",   "🬨",   "▐",   "▌"   }
                prompt  = { b.t,   b.r,   b.b,   b.l,   b.tl,  b.tr,  b.br,  b.bl  },
--              results = { "🬂",   "▐",   "🬭",   "▌",   "🬛",   "🬫",   "🬷",   "🬲"   },
                results = { "▀",   b.r,   b.b,   b.l,   "▀",   "▀",   b.br,  b.bl  },
--              preview = { "🬂",   "▐",   "🬭",   "▌",   "🬕",   "🬨",   "🬷",   "🬲"   },
                preview = { b.t,   b.r,   b.b,   b.l,   b.tl,  b.tr,  b.br,  b.bl  },
            }
        }
    elseif opts == "large" then
        builtin.registers {
            layout_config = {
                width = 0.95,
                height = 0.95
            },
        }
    end
end

function M.lsp_references()
    builtin.lsp_references({
        jump_type = 'never',
        layout_strategy = "vertical",
        layout_config = {
            preview_height = 0.5,
            prompt_position = "bottom",
            width = 0.4,
            height = 0.8
        },
        borderchars = M.borderchars
    })
end

function M.lsp_definitions()
    builtin.lsp_definitions({
        jump_type = 'never',
        layout_strategy = "vertical",
        layout_config = {
            preview_height = 0.5,
            prompt_position = "bottom",
            width = 0.4,
            height = 0.8
        },
        borderchars = M.borderchars
    })
end

function M.notify()
    telescope.extensions.notify.notify{
        results_title = "Results",
        prompt_title = "Notifications",
        layout_strategy = "vertical",
        layout_config = {
            preview_height = 0.3,
            prompt_position = "bottom",
            width = 0.4,
            height = 0.5
        },
        borderchars = M.borderchars
    }
end

return M
