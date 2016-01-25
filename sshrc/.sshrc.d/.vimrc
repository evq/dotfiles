" Slimmed down vimrc for use with sshrc

" Both required for vundle
set nocompatible
filetype off

filetype plugin indent on
" End of Vundle stuffs

set smartindent

let tabsize = 2
" No hard tabs, spaces only
set expandtab
execute "set tabstop=".tabsize
execute "set shiftwidth=".tabsize
execute "set backspace=".tabsize

" Command mode completion
set wildmenu
set wildmode=list:longest

" Start scrolling on 5th line from edge
set scrolloff=5

set encoding=utf-8
set visualbell

" Highlight current line
set cursorline
" Fast scrolling
set ttyfast
" Show position info in bottom right
set ruler 

" Relative numbering (current line is always 0) if possible
if version >= 703
  set relativenumber
else
  set number
endif

" Very magic messes with next match so this is disabled for now
"nnoremap / /\v
" Very magic by default in searches
cnoremap s/ s/\v

imap jj <ESC>

" Case insensitive search
set ignorecase

" Uppercase sensitive search
set smartcase

" Global replace by default
set gdefault

" Look in higher directories if ctags not found in pwd
set tags=tags;/
" Tab ctags nav
"nnoremap <tab> <C-]>
"vnoremap <tab> <C-]> 
"nnoremap <s-tab> <C-t>
"vnoremap <s-tab> <C-t> 

" Spelling suggestions on tab in normal mode
let g:lexical#spell_key = '<tab>'

let mapleader = " "

nmap \ :s/^\s\+//<CR>

syntax on

filetype on
filetype indent on
filetype plugin on

au BufNewFile,BufRead *.S set filetype=S syntax=asmx86_64
au BufNewFile,BufRead *.s set filetype=S syntax=asmx86_64
au BufNewFile,BufRead *.h set filetype=h syntax=c
au BufNewFile,BufRead *.md set filetype=markdown
au BufNewFile,BufRead .gitignore set filetype=gitignore
au BufNewFile,BufRead LICENSE set filetype=LICENSE
autocmd BufWritePost *.md silent !pandoc -o ~/preview.pdf %
autocmd BufWritePost *.tex silent !pdflatex %
autocmd BufWritePost *.solid.py silent !python %

colorscheme molokai-transparent

" Continue comment after pressing enter (+=o for after pressing o)
set fo+=r 

set comments=sl:/*,mb:\ *,elx:\ */

set noswapfile
set mouse=a
" Better mouse support for WIDE windows
if !has('nvim')
  set ttym=xterm2
endif
if has('mouse_sgr')
  set ttymouse=sgr
endif

" Make sure clipboard always works, even if DISPLAY is wrong
" xhost should be fairly compatible (seems to be present on mac)
call system('xhost')
if v:shell_error != 1 
  if has('unnamedplus')
    set clipboard=unnamed,unnamedplus
  else
    set clipboard=unnamed
  endif
endif

if exists('+colorcolumn')
  highlight colorcolumn ctermbg=208
  set colorcolumn=110
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

command W silent w !sudo tee % > /dev/null

set completeopt=longest,menuone,preview

" <TAB>: completion.
inoremap <expr><TAB>  "\<C-n>"

" Put the cursor back to the edit window
autocmd VimEnter * wincmd p
" Reorient screen for templates...
autocmd VimEnter * normal! zb

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
"autocmd WinEnter * call s:CloseIfOnlyNerdTreeOrTagListLeft()
autocmd WinEnter * call s:DiffClose()

if version >= 703
  autocmd InsertEnter * :set number
  autocmd InsertLeave * :set relativenumber
endif

function s:DiffClose()
  if &diff && tabpagenr("$") == 1 && winnr("$") == 1
    qa
  endif
endfunction

function Twotofour()
  set list
  set tabstop=2
  set noexpandtab
  retab!
  set expandtab
  set tabstop=4
  retab
endfunction

let &titlestring = "vim(" . expand("%:t") . ")"
if &term == "xterm-256color"
  set t_ts=k
  set t_fs=\
endif
if &term == "xterm-256color"
  set title
endif

" (Known) Leader Bindings

" Paste mode toggle
"set pastetoggle=<leader>p

" Navigation
nnoremap <Leader>j 20j
nnoremap <Leader>k 20k

" Tab parens matching
nnoremap <Leader><tab> %
vnoremap <Leader><tab> %

" Source local vimrc
if filereadable("~/.localvimrc")
  so ~/.localvimrc
endif
