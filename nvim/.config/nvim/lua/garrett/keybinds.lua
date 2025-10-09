vim.g.mapleader = " "

-- center cursor on jump
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

-- LSP
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- move selection around
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Stay in visual mode when indenting code
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

-- Stole this one from a tutorial, paste and keep register
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Yank to system clipboard
vim.keymap.set({ 'v' }, '<leader>y', [["+y]])
vim.keymap.set('n', '<leader>yy', [["+yg$]])
