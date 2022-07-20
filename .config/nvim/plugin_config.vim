" -- telescope config
lua << EOF
require("telescope").load_extension "file_browser"
EOF

" -- lualine configuration
lua << END
require'lualine'.setup {
  options = { theme = 'molokai' }
}
END
