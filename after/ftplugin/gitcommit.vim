" vimfiles - My Vim configuration
"
" Written in 2016, 2019 by Lawrence Velázquez <vq@larryv.me>
"
" To the extent possible under law, the author(s) have dedicated all
" copyright and related and neighboring rights to this software to the
" public domain worldwide. This software is distributed without any
" warranty.
"
" You should have received a copy of the CC0 Public Domain Dedication
" along with this software. If not, see
" <https://creativecommons.org/publicdomain/zero/1.0/>.


" Recognize bulleted lists instead of numbered lists. I never use
" numbered lists in Git commit messages.
setlocal autoindent
let &l:formatlistpat = '^\s*[-*]\s*'
setlocal formatoptions+=n
