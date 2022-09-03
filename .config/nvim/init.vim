" --- Plugins
source ~/.config/nvim/plugins.vim

" ----- Keybinds
source ~/.config/nvim/keybinds.vim

" ----- Configuration

" Theme
source ~/.config/nvim/theme.vim

" General vim config
set relativenumber
set smarttab
set cindent
set tabstop=4
set shiftwidth=4
set expandtab
set scrolloff=24
set number relativenumber
set hidden
syntax on

" Disable continuation of comments when creating new lines
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro

" Open new splits below/to the right by default
set splitbelow splitright

" Plugin configurations
luafile ~/.config/nvim/plugin_config.lua

" Lsp configuration
luafile ~/.config/nvim/lsp.lua
