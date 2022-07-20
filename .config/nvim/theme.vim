colorscheme molokai

" Fix parenthesis colors in molokai
hi MatchParen guifg=#FD971F guibg=#000000 gui=bold

" Set background semi transparent
hi Normal     guifg=NONE    guibg=NONE

" Set colors
if (has("termguicolors"))
    set termguicolors
endif

