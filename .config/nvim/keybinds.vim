let mapleader=" "

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fe <cmd>Telescope file_browser<cr>
nnoremap <leader>fr <cmd>Telescope lsp_references<cr>
nnoremap <leader>gs <cmd>Telescope git_status<cr>

" Splits
noremap <silent> <C-Left> :vertical resize +5<CR>
noremap <silent> <C-Right> :vertical resize -5<CR>
noremap <silent> <C-Up> :resize +5<CR>
noremap <silent> <C-Down> :resize -5<CR>

" Keep selection after indenting
vnoremap < <gv
vnoremap > >gv

" Clear the "last search pattern" register on escape
nmap <esc> :noh<CR>

" Comment
nmap <leader>k gcc

" Comment and keep selection
vmap <leader>k gcgv

" Only use global marks, and keep last visited position instead of going to the marked position
nnoremap <silent> ' :execute 'buffer' getpos("'" . toupper(nr2char(getchar()) ))[0]<cr>
nnoremap <silent> <expr> m "m".toupper(nr2char(getchar()))

" Go to header/cpp file
autocmd FileType cpp,h nnoremap <buffer> <A-o> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>
