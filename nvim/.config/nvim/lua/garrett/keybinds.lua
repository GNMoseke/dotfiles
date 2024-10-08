vim.g.mapleader = " "
--vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- center cursor on jump
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

-- move selection around
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Stole this one from a tutorial
vim.keymap.set("x", "<leader>p", [["_dP]])

-- LSP
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
