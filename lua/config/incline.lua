local type_list = {
    -- Filetypes
    "help",
    "qf",
    -- Buftypes
    "nofile",
    "nowrite",
    "quickfix",
    "terminal",
}

local only_show_win_number = function(bufid)
    local buftype = vim.api.nvim_buf_get_option(bufid, "buftype")
    local filetype = vim.api.nvim_buf_get_option(bufid, "filetype")
	for _, type in pairs(type_list) do
		if buftype == type or filetype == type then
			return true
		end
	end
end

require("incline").setup({
    debounce_threshold = {
        falling = 50,
        rising = 10,
    },
    hide = {
        cursorline = true,
        focused_win = true,
        only_win = false,
    },
    highlight = {
        groups = {
            InclineNormal = {
                default = false,
                group = "InclineNormal",
            },
            InclineNormalNC = {
                default = false,
                group = "InclineNormalNC",
            },
        },
    },
    ignore = {
        buftypes = {},
        filetypes = {
            "alpha",
            "lspinfo",
            "lsp-installer",
            "packer",
        },
        floating_wins = true,
        unlisted_buffers = false,
        wintypes = {},
    },
    render = function(props)
        local bufname = vim.api.nvim_buf_get_name(props.buf)
        local bufid = vim.api.nvim_buf_get_number(props.buf)
        local fnamemodify = vim.fn.fnamemodify
        local winwidth = vim.fn.winwidth(props.win)
        if bufname == "" then
            return "[No name]"
        elseif only_show_win_number(bufid) then
            return " " .. vim.api.nvim_win_get_number(props.win)
        else
            if #fnamemodify(bufname, ":~:.") < winwidth - 13 and fnamemodify(bufname, ":h") ~= "." then
                return " " .. fnamemodify(bufname, ":~:.") .. " │  " .. vim.api.nvim_win_get_number(props.win)
            elseif #fnamemodify(bufname, ":t") < winwidth - 13 then
                return " " .. fnamemodify(bufname, ":t") .. " │  " .. vim.api.nvim_win_get_number(props.win)
            else
                return " " .. vim.api.nvim_win_get_number(props.win)
            end
        end
    end,
    window = {
        margin = {
            horizontal = 2,
            vertical = 1,
        },
        options = {
            signcolumn = "no",
            wrap = false,
        },
        padding = 1,
        padding_char = " ",
        placement = {
            horizontal = "right",
            vertical = "bottom",
        },
        width = "fit",
        winhighlight = {
            active = {
                EndOfBuffer = "None",
                Normal = "InclineNormal",
                Search = "None",
            },
            inactive = {
                EndOfBuffer = "None",
                Normal = "InclineNormalNC",
                Search = "None",
            },
        },
        zindex = 10,
    },
})
