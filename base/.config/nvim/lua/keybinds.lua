-- Set leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Paste over selected without updating any registers
vim.keymap.set("x", "<leader>p",  "\"_dP")

-- Delete without updating any registers
vim.keymap.set({"n", "v"}, "<leader>d", "\"_d")

-- Keep selection after indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Replace word under cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
