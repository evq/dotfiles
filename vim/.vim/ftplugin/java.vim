let tabsize = 4
execute "set tabstop=".tabsize
execute "set shiftwidth=".tabsize
"execute "set backspace=".tabsize


if exists('+colorcolumn')
  highlight colorcolumn ctermbg=208
  set colorcolumn=100
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>100v.\+', -1)
endif
