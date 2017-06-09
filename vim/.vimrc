" Both required for vundle
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#begin()


" Let Vundle manage Vundle
Bundle 'gmarik/vundle'

" Plugins
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/nerdcommenter'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'millermedeiros/vim-statline'
Bundle 'benmills/vimux'
Bundle 'sjl/gundo.vim.git'
Bundle 'Lokaltog/vim-easymotion'
if !has('nvim')
  Bundle 'Shougo/neocomplete.vim'
endif
Bundle 'https://github.com/skwp/vim-conque.git'
Bundle 'reedes/vim-lexical'

" Filetype Plugins
Bundle 'vim-scripts/openscad.vim'
Bundle 'sudar/vim-arduino-syntax'
Bundle 'guns/vim-clojure-static'
Bundle 'tpope/vim-fireplace'
Bundle 'tfnico/vim-gradle'
Bundle 'fatih/vim-go'
Bundle 'kchmck/vim-coffee-script'
Bundle 'fidian/hexmode'
Plugin 'JuliaLang/julia-vim'
Plugin 'mfukar/robotframework-vim' 
Plugin 'nvie/vim-flake8'
Plugin 'tell-k/vim-autopep8'
Plugin 'rust-lang/rust.vim'

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

if ! &diff
  "let Tlist_Auto_Open = 1
  "autocmd VimEnter * NERDTree
endif
" Display taglist in right window
let Tlist_Use_Right_Window = 1
let tlist_clojure_settings = 'lisp;f:function'

let g:ConqueTerm_Color = 1
let g:ConqueTerm_TERM = 'screen-256color'
let g:ConqueTerm_SendVisKey = '<Leader>!'

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
map :! :VimuxPromptCommand<cr>

syntax on

filetype on
filetype indent on
filetype plugin on

au BufNewFile,BufRead *.S set filetype=S syntax=asmx86_64
au BufNewFile,BufRead *.s set filetype=S syntax=asmx86_64
au BufNewFile,BufRead *.h set filetype=h syntax=c
au BufNewFile,BufRead *.md set filetype=markdown
au BufNewFile,BufRead *.txt set filetype=markdown
au BufNewFile,BufRead .gitignore set filetype=gitignore
au BufNewFile,BufRead LICENSE set filetype=LICENSE
autocmd BufWritePost *.md silent !pandoc -o ~/preview.pdf %
"autocmd BufWritePost *.tex silent !pdflatex %
autocmd BufWritePost *.solid.py silent !python %

colorscheme molokai-transparent

" Highlight NOTE, INFO, IDEA
if has("autocmd")
  if v:version > 701
    autocmd Syntax * call matchadd('Todo', '\W\zs\(NOTE\|INFO\|SEE\|IDEA\)')
    autocmd Syntax * call matchadd('Debug', '\W\zs\(@filename\|@file\|@description\|@author\|@brief\|@param\|@retval\|@return\)')
  endif
endif

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

let g:EasyMotion_leader_key = '<Leader>'
 
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

" Line length limits
if exists('+colorcolumn')
  highlight colorcolumn ctermbg=208
  set colorcolumn=110
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>110v.\+', -1)
endif

let g:autopep8_max_line_length=110

command W silent w !sudo tee % > /dev/null

set completeopt=longest,menuone,preview

 " Disable AutoComplPop.
let g:acp_enableAtStartup = 0
if !has('nvim')
  " Use neocomplete.
  let g:neocomplete#enable_at_startup = 1
  " Use smartcase.
  let g:neocomplete#enable_smart_case = 1
endif

" <TAB>: completion.
inoremap <expr><TAB>  "\<C-n>"

" Put the cursor back to the edit window
autocmd VimEnter * wincmd p
" Reorient screen for templates...
autocmd VimEnter * normal! zb

autocmd VimEnter * RainbowParenthesesToggle
autocmd Syntax * RainbowParenthesesLoadRound
autocmd Syntax * RainbowParenthesesLoadSquare
autocmd Syntax * RainbowParenthesesLoadBraces

" Rainbow parens colors
let g:rbpt_colorpairs = [ 
	\ ['white', 'white'],
	\ ['magenta', 'magenta'],
	\ ['cyan', 'cyan'],
	\ ['blue', 'blue'],
	\ ['green', 'green'],
	\ ['yellow', 'yellow'],
	\ ['red', 'red'],
	\ ]
let g:rbpt_max = 7

hi link EasyMotionTarget Function
hi link EasyMotionShade  Comment

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

" Tab autocomplete
"inoremap <expr> <tab> "\<C-n>"
"inoremap <expr> <s-tab> pumvisible() ? "\<C-p>" : "\<s-tab>"
"inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

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

function s:CloseIfOnlyNerdTreeOrTagListLeft()
  if tabpagenr("$") == 1 && winnr("$") == 2
    let window1 = bufname(winbufnr(1))
    let window2 = bufname(winbufnr(2))
    if exists("t:NERDTreeBufName") && window1 == "__Tag_List__"
      q
      q
    elseif exists("t:NERDTreeBufName") && window2 == "__Tag_List__"
      q
      q
    endif
  elseif tabpagenr("$") == 1 && winnr("$") == 1
    if exists("t:NERDTreeBufName")
      q
    elseif bufname(winbufnr(1)) == "__Tag_List__"
      q
    endif
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

" Undo buffer panel
nnoremap <Leader>u GundoToggle<CR>

" NERDComment
"   <leader>c*
"   <leader>c<slpace> toggle comment for line(s)
"
" Tab parens matching
nnoremap <Leader><tab> %
vnoremap <Leader><tab> %

" ViMux
nnoremap <Leader>: :VimuxPromptCommand<cr>
"nnoremap <Leader>! :call VimuxRunCommand(getline("."))<cr>

" Clojure Dox
"nnoremap <Leader>d :Doc <c-r>=expand("<cword>")<cr><cr>
"vnoremap <Leader>d :Doc <c-r>=expand("<cword>")<cr><cr>

" Go Dox
nnoremap <Leader>d :GoDoc<cr>
" Python syntax
autocmd FileType python map <buffer> <Leader>s :call Flake8()<CR>
" Source local vimrc
if filereadable("~/.localvimrc")
  so ~/.localvimrc
endif
