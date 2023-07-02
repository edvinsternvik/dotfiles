-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 0
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Search highlight
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Don't continue comments on new line
vim.api.nvim_create_autocmd("BufEnter", {
    callback = function() vim.opt.formatoptions:remove({'c', 'r', 'o'}) end
})

-- Misc
vim.opt.scrolloff = 8
vim.opt.termguicolors = true
vim.opt.updatetime = 50
