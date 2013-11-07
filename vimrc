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

" Set wildmenu, this is essential
set wildmenu

" Open new splits to the right
set splitright

" Set a textwrap
set tw=80

" Turn on spelling checking for text files.
autocmd BufNewFile,BufRead *.txt setlocal spell
autocmd BufNewFile,BufRead *.md  setlocal spell

" Color Scheme
set background=dark
color jellybeans

" Folds
set foldmethod=syntax   "fold based on syntax
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1         "this is just what i use

" Indent
set autoindent
set cindent
set smartindent
filetype on
filetype plugin on
filetype indent on

" List Characters
"set listchars=tab:▸\ ,trail:·

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
inoremap jj <ESC>:w<cr>

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
set wildignore+=*/public/coffeescripts/*
set wildignore+=*/public/api_docs/*
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
autocmd BufWritePre * silent! %s/\s\+$//e
" Turn tabs into spaces
autocmd BufWritePre * silent! retab
" Remove blank lines at end of file.
function! <SID>DelEmptyLinesEnd()
    let l = line(".")
    let c = col(".")
    v/\_s*\S/d
    call cursor(l, c)
endfunction
autocmd BufWritePre * :call <SID>DelEmptyLinesEnd()

" Quiet annoying bell.
set visualbell

" function for formatting json.
function! DoFormatJSON()
  :%!python -m json.tool
endfunction

command! FormatJSON call DoFormatJSON()

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
function! DoFormatXML()
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
command! FormatXML call DoFormatXML()

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
" This real slows down moving up and down line by line
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

" Toggle pane with tt
nmap tt <C-w>ww


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

au BufWinLeave *.rb mkview
au BufWinEnter *.rb silent loadview

" Save my eyes! Decent syntax highlighting for erb.
autocmd BufRead,BufNewFile *.erb set filetype=eruby.html


" Support for mobile_app filetype
autocmd BufNewFile,BufRead *.mobile.erb     let b:eruby_subtype = 'html'
autocmd BufNewFile,BufRead *.mobile_app.erb let b:eruby_subtype = 'html'
autocmd BufNewFile,BufRead *.mobile.erb     set syntax=eruby
autocmd BufNewFile,BufRead *.mobile_app.erb set syntax=eruby

" Vim Wiki
let g:vimwiki_list = [{'path': '~/Dropbox/wiki', 'path_html': '~/Dropbox/wiki_html'}]


" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>


" Make sure taglist get a copy to exuberant ctags and not gnu ctags
let Tlist_Ctags_Cmd='/usr/local/bin/ctags'
" ,ct to toggle cats
nmap <leader>ct :TlistToggle<CR>


function! DisableIndent()
        set autoindent&
        set cindent&
        set smartindent&
        set indentexpr&
endfunction

au filetype vimwiki call DisableIndent()

" RABL Highlighting
au BufRead,BufNewFile *.rabl setf ruby

" Unload buffers when I closeing tabs
set nohidden

function! Wipeout()
  " list of *all* buffer numbers
  let l:buffers = range(1, bufnr('$'))

  " what tab page are we in?
  let l:currentTab = tabpagenr()
  try
    " go through all tab pages
    let l:tab = 0
    while l:tab < tabpagenr('$')
      let l:tab += 1

      " go through all windows
      let l:win = 0
      while l:win < winnr('$')
        let l:win += 1
        " whatever buffer is in this window in this tab, remove it from
        " l:buffers list
        let l:thisbuf = winbufnr(l:win)
        call remove(l:buffers, index(l:buffers, l:thisbuf))
      endwhile
    endwhile

    " if there are any buffers left, delete them
    if len(l:buffers)
      execute 'bwipeout' join(l:buffers)
    endif
  finally
    " go back to our original tab page
    execute 'tabnext' l:currentTab
  endtry
endfunction
command! Wipeout :call Wipeout()

" Disable spelling for help http://stackoverflow.com/a/13899772/32384
autocmd BufEnter /usr/local/Cellar/macvim/7.3-65/MacVim.app/Contents/Resources/vim/runtime/doc/*.txt  set nospell
autocmd BufLeave /usr/local/Cellar/macvim/7.3-65/MacVim.app/Contents/Resources/vim/runtime/doc/*.txt  set spell

augroup ProjectSetup
" Set 4 space tabs for lpc
au BufRead,BufEnter /Users/blake/Projects/launchpadcentral/* set tabstop=4 softtabstop=4 shiftwidth=4 expandtab cindent
augroup END

" ,yp - Yank absolute path
nmap ,yp :let @*=expand("%:p")<CR>
" .yr - Yank relative path
nmap ,yr :let @*=expand("%")<CR>

" Insert date with F5
:nnoremap <F5> "=strftime("%c")<CR>P
:inoremap <F5> <C-R>=strftime("%c")<CR>

" Vim calulator http://vim.wikia.com/wiki/Using_vim_as_calculator
:ino <C-A> <C-O>yiW<End>=<C-R>=<C-R>0<CR>
