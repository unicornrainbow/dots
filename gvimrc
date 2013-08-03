" Remove menu bar
set guioptions-=m
set guioptions+=c

" Remove toolbar
set guioptions-=T

set guifont=Droid\ Sans\ Mono\ for\ Powerline:h14
let g:Powerline_symbols = 'fancy'

" Ignore compiled assets
set wildignore+=public/assets/*
set wildignore+=public/stylesheets/compiled/*
set wildignore+=public/javascripts/compiled/*
set wildignore+=tmp/**
set wildignore+=*/tmp/*,*.so,*.swp,*.zip

" let g:ctrlp_custom_ignore = {
"     \ 'dir':  '\.git$\|\.hg$\|\.svn$\|\.deploy$'
"     \ }

function! CleanClose(tosave)
if (a:tosave == 1)
    w!
endif
let todelbufNr = bufnr("%")
let newbufNr = bufnr("#")
if ((newbufNr != -1) && (newbufNr != todelbufNr) && buflisted(newbufNr))
    exe "b".newbufNr
else
    bnext
endif

if (bufnr("%") == todelbufNr)
    new
endif
exe "bd".todelbufNr
endfunction
