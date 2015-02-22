let tabsize = 4
execute "setlocal tabstop=".tabsize
execute "setlocal shiftwidth=".tabsize
"execute "setlocal backspace=".tabsize


if exists('+colorcolumn')
  highlight colorcolumn ctermbg=208
  setlocal colorcolumn=100
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>100v.\+', -1)
endif
