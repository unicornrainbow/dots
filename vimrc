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

" Color Scheme
set background=dark

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
:nnoremap <cr> :nohlsearch<cr>

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

" Bind :Q to :q and :W to :w
command! Q q
command! W w
command! Wq wq
command! Qall qall

" Splitting, resizing and moving around split windows
map <C-S> :split<CR>
map <C-V> :vsplit<CR>
map <C-H> <C-W>h
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-L> <C-W>l
map <C-Q> :q<CR>
map = <C-W>+
map - <C-W>-

" Find merge conflict markers
nmap <silent> <leader>cf <esc>/\v^[<=>]{7}( .*\|$)<cr>

" Plugins
map <leader>a :Ack<space>
map <leader>g<space> :Git<space>
map <leader>gs :Gstatus<cr>
map <leader>gr :Gread<cr>
map <leader>gw :Gwrite<cr>
map <leader>gb :Gblame<cr>
map <leader>gd :Gdiff<cr>
map <leader>c :Rcontroller<space>
map <leader>m :Rmodel<space>
map <leader>v :Rview<space>
map <leader>n :NERDTree<cr>
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
let g:ctrlp_map="<leader>f"
let g:ctrlp_custom_ignore="\.git$"
let g:gist_clip_command="pbcopy"
let g:gist_detect_filetype=1
let g:gist_private=1
let g:EasyMotion_leader_key=";"
let g:NERDTreeWinSize=30
let g:Powerline_symbols="fancy"
let g:Powerline_theme="default"
let g:Powerline_colorscheme="skwp"
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
endif
