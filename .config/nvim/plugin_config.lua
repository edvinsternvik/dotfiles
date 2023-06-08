-- nvim-autopairs config
require("nvim-autopairs").setup {}

-- telescope config
require("telescope").load_extension "file_browser"

-- lualine config
require('lualine').setup {
  options = { theme = 'molokai' }
}

-- leap config
require('leap').add_default_mappings()
require('leap').opts.highlight_unlabeled_phase_one_targets = true
