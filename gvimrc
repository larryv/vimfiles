" vimfiles - My Vim configuration
"
" Written in 2012, 2016, 2019-2020 by Lawrence Velázquez <vq@larryv.me>
"
" To the extent possible under law, the author(s) have dedicated all
" copyright and related and neighboring rights to this software to the
" public domain worldwide. This software is distributed without any
" warranty.
"
" You should have received a copy of the CC0 Public Domain Dedication
" along with this software. If not, see
" <https://creativecommons.org/publicdomain/zero/1.0/>.


" I don't want a toolbar; this isn't Office.
set guioptions-=T

" Showing inactive menu items aids discoverability.
set guioptions+=g

" Absolute line numbers on the left.
set number

try
    source ~/.gvimrc.local
catch /^Vim(source):E484/
endtry
