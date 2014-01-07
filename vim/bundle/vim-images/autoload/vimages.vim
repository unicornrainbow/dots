" vim-images.vim - Image pasting for vim
" Maintainer:   Blake Taylor <http://blakefrost.com/>
" Version:      0.1

if exists("g:loaded_vimages") || &cp
  finish
endif
let g:loaded_vimages = 1

function! s:warn(msg)
  echohl WarningMsg
  echomsg a:msg
  echohl NONE
endfunction

function! vimages#PasteImage()
  " Paste image from clipboard accroding to date/time
  let date_path = strftime("%Y/%m/%d/")
  let images_root = '/Users/blake/' "TODO: Inject this

  let images_path = 'images/captures/' . date_path
  let images_dir  = images_root . images_path
  let file = strftime("%T") . '.png'

  " Make sure the directory exists
  execute 'silent !mkdir -p ' . images_root . images_path
  execute "silent !pngpaste " . images_dir . file

  " Test that the file exists
  if filereadable(images_dir . file)
    execute "normal a \<BS>".'![](/'.images_path.file.')'
    normal! 02l
    startinsert!
  else
    echo "Couldn't paste image. perhaps no image data in clipboard?:"
  endif
  redraw!
endfunction
