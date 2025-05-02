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

-- FIXME: this hacks around double borders in telescope. can be removed
-- after https://github.com/nvim-lua/plenary.nvim/pull/649
vim.api.nvim_create_autocmd("User", {
  pattern = "TelescopeFindPre",
  callback = function()
    vim.opt_local.winborder = "none"
    vim.api.nvim_create_autocmd("WinLeave", {
      once = true,
      callback = function()
        vim.opt_local.winborder = "rounded"
      end,
    })
  end,
})

vim.cmd.colorscheme "catppuccin"
