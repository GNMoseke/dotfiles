require("garrett.set")
require("garrett.keybinds")
require("garrett.lazy_init")

local augroup = vim.api.nvim_create_augroup
local autocommand = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

autocommand('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
	vim.highlight.on_yank({
	    higroup = 'IncSearch',
	    timeout = 40,
	})
    end,
})

vim.cmd.colorscheme "catppuccin"
