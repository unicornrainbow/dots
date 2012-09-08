syntax on
set nocompatible
set encoding=utf-8
set modelines=0

" Pathogen
call pathogen#infect()
filetype plugin indent on

" Basics
set ruler
set number
set showcmd
set laststatus=2
set nowrap
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set backspace=indent,eol,start
set clipboard=unnamed
set history=50
set hidden

" Set a textwrap
set tw=80

" Turn on spelling checking for text files.
autocmd BufNewFile,BufRead *.txt setlocal spell
autocmd BufNewFile,BufRead *.md  setlocal spell

" Color Scheme
set background=dark
color jellybeans

" Folds
set foldmethod=manual
set nofoldenable

" Indent
set autoindent
set smartindent

" List Characters
set listchars=tab:▸\ ,trail:·

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Scrollbars
set scrolloff=2
set sidescrolloff=2
set numberwidth=2

" Swap and backup files
set nobackup
set nowritebackup
set directory=~/.vim/backup

" Tags
set tags=./tags

let mapleader=","
inoremap jj <esc>

if has("autocmd")
  " Auto-close fugitive buffers
  autocmd BufReadPost fugitive://* set bufhidden=delete

  " Treat JSON files like JavaScript
  au BufNewFile,BufRead *.json set ft=javascript
endif

" Clear the search buffer when hitting return
" :nnoremap <cr> :nohlsearch<cr>

" Ignorable Files
set wildignore+=*.o,*.r,*.class,*.pyc,*.so,*.sl,*.tar,*.tgz,*.gz,*.dmg,*.zip
set wildignore+=*.pdf,*/CVS/*,*/.svn/*,*/.git/*,*.toc,*.aux,*.dvi,*.log,*.lck
set wildignore+=*.pem,*.priv,*.pub,*.sassc,*.scssc,*.pid,*.jar,*.DS_Store
set wildignore+=*.gif,*.jpg,*.jpeg,*.png,*.doc,*.xls
" Ignore Rails folders
set wildignore+=*/app/certs/*,*/log/*,*/solr/*,*/tmp/*
" Ignore Node folders
set wildignore+=*/node_modules/*
" Ignore compiled assets
set wildignore+=*/public/assets/*
set wildignore+=*/public/javascripts/compiled/*
set wildignore+=*/public/stylesheets/compiled/*
set wildignore+=*/.deploy/*

" Bind :Q to :q and :W to :w
command! Q q
command! W w
command! Wq wq
command! Qall qall

" Splitting, resizing and moving around split windows
map <C-H> <C-W>h
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-L> <C-W>l
map <C-Q> :q<CR>
map = <C-W>+
map - <C-W>-

" Find merge conflict markers
" nmap <silent> <leader>cf <esc>/\v^[<=>]{7}( .*\|$)<cr>

" Plugins
"map <leader>a :Ack<space>
map <leader>a :A<cr>
map <leader>g<space> :Git<space>
map <leader>gs :Gstatus<cr>
map <leader>gr :Gread<cr>
map <leader>gw :Gwrite<cr>
map <leader>gb :Gblame<cr>
map <leader>gd :Gdiff<cr>
map <leader>c :Rcontroller<space>
map <leader>m :Rmodel<space>
map <leader>v :Rview<space>
map <leader>n :NERDTreeToggle<cr>
map <Leader>rp :PromptVimTmuxCommand<CR>
map <Leader>rl :RunLastVimTmuxCommand<CR>
map <Leader>ri :InspectVimTmuxRunner<CR>
map <Leader>rx :CloseVimTmuxPanes<CR>
map <Leader>rs :InterruptVimTmuxRunner<CR>

" Quick application access
nmap <Leader>sc :silent !open /Applications/Google\ Chrome.app<CR>
nmap <Leader>sf :silent !open /Applications/Flint.app<CR>
nmap <Leader>si :silent !open /Applications/iTerm.app<CR>
nmap <Leader>sm :silent !open /Applications/Sequel\ Pro.app<CR>
nmap <Leader>ss :silent !open /Applications/Skype.app<CR>

let g:rails_statusline=0
let g:ctrlp_map="<leader>p"
let g:ctrlp_custom_ignore="\.git$"
let g:gist_clip_command="pbcopy"
let g:gist_detect_filetype=1
let g:gist_private=1
let g:EasyMotion_leader_key=";"
let g:NERDTreeWinSize=30
let g:Powerline_symbols="fancy"
let g:Powerline_theme="default"
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1

" MacVim
if has("gui_macvim")
  set background=dark
  set guioptions-=b
  set guioptions-=r
  set guioptions-=L
  set guioptions-=T
  set guifont=Monaco:h12

  " Style
  set transparency=5
endif

" Mouse support in vim
set mouse=a

" Delete Trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e
" Turn tabs into spaces
autocmd BufWritePre * :retab
" Remove blank lines at end of file.
"autocmd BufWritePre * :v/\_s*\S/d

" Quiet annoying bell.
set visualbell

" ,b to fuzzy search buffer.
map <leader>b :CtrlPBuffer<CR>

" Enter command mode with ;
"nmap ; :

" ,p for fuzzy file (This overrides nerdtrees jumo to parent. Maybe not so
" good.)
map <leader>p :CtrlP<CR>

" Don't manage working directory. Use whatever vim has.
let g:ctrlp_working_path_mode = 0

" Swap buffers with ,l
nmap <leader>l <C-^>

" +/- for resizing windows.
map + 2<c-w>+
map _ 2<c-w>-

" Left to right window resizing
" map <c-m> <c-w><
" map <c-n> <c-w>>

" Fullscreen
" map <c-w>F <c-w>_<c-w><Bar>

" Walk through window with arrows.
map <c-Up> <c-w>k
map <c-Down> <c-w>j
map <c-Left> <c-w>h
map <c-Right> <c-w>l

" Pretty format xml.
" type :PrettyXML
function! DoPrettyXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  1s/<?xml .*?>//e
  " insert fake tags around the entire document.
  " This will permit us to pretty-format excerpts of
  " XML that may contain multiple top-level elements.
  0put ='<PrettyXML>'
  $put ='</PrettyXML>'
  silent %!xmllint --format -
  " xmllint will insert an <?xml?> header. it's easy enough to delete
  " if you don't want it.
  " delete the fake tags
  2d
  $d
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  silent %<
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction
command! PrettyXML call DoPrettyXML()

" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" Open new tabs with cmmand-t
imap <D-t> <Esc>:tabnew<CR>
map <D-t> <Esc>:tabnew<CR>

" ================ Syntax ============================
" Show syntax highlighting groups for word under cursor with <C-S-P>
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

"Relative line numbers
"autocmd BufEnter * set relativenumber

" Disable arrow keys in vim
"noremap  <Up> <C-w><Up>
"noremap! <Up> <Esc>
"noremap  <Down> <C-w><Down>
"noremap! <Down> <Esc>
"noremap  <Left> <C-w><Left>
"noremap! <Left> <Esc>
"noremap  <Right> <C-w><Right>
"noremap! <Right> <Esc>


" Handle splitting
nmap ss :split<CR>
nmap vv :vsplit<CR>

" Leader shortcuts for Rails commands
map <Leader>m :Rmodel
map <Leader>v :Rview
map <Leader>u :Runittest
map <Leader>f :Rfunctionaltest
map <Leader>tm :RTmodel
map <Leader>tc :RTcontroller
map <Leader>tv :RTview
map <Leader>tu :RTunittest
map <Leader>tf :RTfunctionaltest
map <Leader>sm :RSmodel
map <Leader>sc :RScontroller
map <Leader>sv :RSview
map <Leader>su :RSunittest
map <Leader>sf :RSfunctionaltest

" File highlighting
au BufNewFile,BufRead *.jst set filetype=html

" Disable Ex Mode
map Q <Nop>

"Go to last edit location with ,.
nnoremap ,. '.

" Move lines up/down with CMD+j/k
nnoremap <D-j> :m+<CR>==
nnoremap <D-k> :m-2<CR>==
inoremap <D-j> <Esc>:m+<CR>==gi
inoremap <D-k> <Esc>:m-2<CR>==gi
vnoremap <D-j> :m'>+<CR>gv=gv
vnoremap <D-k> :m-2<CR>gv=gv

" Toggle comments
" Commenting out, use <leader>c<space> instead
"map <D-/> <leader>c<space>


" Execute open rspec buffer
" Thanks to Ian Smith-Heisters
function! RunSpec(args)
 execute ":! rspec % -cfn " . a:args
endfunction

" Mappings
" run one rspec example or describe block based on cursor position
map !s :call RunSpec("-l " . <C-r>=line('.')<CR>)
" run full rspec file
map !S :call RunSpec("")
