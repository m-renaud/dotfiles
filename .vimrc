" Turn on syntax highlighting...
syn on

" Turn on file type detection...
filetype on
filetype plugin indent on

" Set up default settings...
set autoindent
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set nonumber

" Turn off settings if this is a Makefile...
autocmd BufRead,BufNewFile Makefile* set noexpandtab
autocmd BufRead,BufNewFile *.mak set noexpandtab


" automatically give executable permissions if file begins with #! and
" contains '/bin/' in the path
function ModeChange()
  if getline(1) =~ "^#!.*/bin/"
    silent !chmod +x <afile>
  endif
endfunction
autocmd BufWritePost * call ModeChange()


" Fix syntax highlighting so it can be seen with a dark background...
if &t_Co > 1
  highlight clear
  set background=dark
  if exists("syntax on")
    syntax reset
  endif
  highlight Normal ctermfg=gray ctermbg=black guifg=gray guibg=black
  "highlight Normal cterm=white ctermbg=black guifg=white guibg=black
  "highlight Comment ctermfg=darkgray guifg=darkgray
  "other: Comment Constant Identifier Statement PreProc Type Special Error Todo
  "other: Directory StatusLine Normal Search
  highlight clear
endif


" Go to the last spot we were at when last editting...
augroup JumpCursorOnEdit 
  au! 
  autocmd BufReadPost * 
    \ if expand("<afile>:p:h") !=? $TEMP | 
    \   if line("'\"") > 1 && line("'\"") <= line("$") | 
    \     let JumpCursorOnEdit_foo = line("'\"") | 
    \     let b:doopenfold = 1 | 
    \     if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) | 
    \        let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 | 
    \        let b:doopenfold = 2 | 
    \     endif | 
    \     exe JumpCursorOnEdit_foo |         
    \   endif | 
    \ endif 
  " Need to postpone using "zv" until after reading the modelines. 
  autocmd BufWinEnter * 
    \ if exists("b:doopenfold") | 
    \   exe "normal zv" | 
    \   if(b:doopenfold > 1) | 
    \       exe  "+".1 | 
    \   endif | 
    \   unlet b:doopenfold | 
    \ endif 
augroup END


" Paste mode On/Off Toggle w/F8
map <F8> :call Paste_on_off()<CR>
set pastetoggle=<F8>

let paste_mode = 0  "0=normal, 1=paste

func! Paste_on_off()
  if g:paste_mode == 0
    set paste
    let g:paste_mode = 1
  else
    set nopaste
    let g:paste_mode = 0
  endif
  return
endfunc


" Toggle number On/Off w/F9
map <F9> :call Number_on_off()<CR>
let number_mode = 0  "0=off, 1=on

func! Number_on_off()
  if g:number_mode == 0
    set number
    let g:number_mode = 1
  else
    set nonumber
    let g:number_mode = 0
  endif
endfunc


" Enable the ability to auto-close tags...
"autocmd FileType htm,html,svg,xml,xsl source ~/.vim/scripts/closetag.vim

