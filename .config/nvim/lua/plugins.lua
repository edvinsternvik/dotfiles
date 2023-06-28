vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

	-- LSP
	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/nvim-cmp'
	use 'L3MON4D3/LuaSnip'
	use 'saadparwaiz1/cmp_luasnip'

	-- Theme
	use 'joshdick/onedark.vim'

	-- Misc
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

	use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

	use 'tpope/vim-fugitive'
	use 'tpope/vim-commentary'
	use 'windwp/nvim-autopairs'
end)
