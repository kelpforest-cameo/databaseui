set ts=2 sw=2
syntax on
set spell
highlight spellbad ctermbg=white ctermfg=black
au BufWinLeave * silent! mkview
au BufWinEnter * silent! loadview
filetype plugin indent on
