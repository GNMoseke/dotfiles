require("garrett.set")
require("garrett.keybinds")
require("garrett.lazy_init")

local augroup = vim.api.nvim_create_augroup
local autocommand = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

-- Stuff that I want to override for specific md files (obsidian-style)
local note_overrides = augroup('NoteOverrides', {})

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

autocommand('BufReadPost', {
    group = note_overrides,
    pattern = os.getenv('HOME') .. "/Documents/Notes/*.md",
    callback = function()
        vim.opt.conceallevel = 1
    end
})

vim.cmd.colorscheme "catppuccin"
