vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<Space>", vim.cmd.NOP)
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "<C-w>|", vim.cmd.vsplit)
vim.keymap.set("n", "<C-w>-", vim.cmd.split)
