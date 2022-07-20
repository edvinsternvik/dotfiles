let mapleader=" "

vmap <C-k> <plug>NERDCommenterToggle \| gv

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fe <cmd>Telescope file_browser<cr>

" Splits
noremap <silent> <C-Left> :vertical resize +5<CR>
noremap <silent> <C-Right> :vertical resize -5<CR>
noremap <silent> <C-Up> :resize +5<CR>
noremap <silent> <C-Down> :resize -5<CR>

" Keep selection after indenting
vnoremap < <gv
vnoremap > >gv

"Clear the "last search pattern" register on escape
nmap <esc> :noh<CR>

"
" Go to header/cpp file
autocmd FileType cpp,h nnoremap <buffer> <A-o> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>
