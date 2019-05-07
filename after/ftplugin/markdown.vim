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


" Some Markdown implementations are aggressive about turning (non-list)
" text into code blocks if it is indented four spaces. I like to indent
" link references and certain other text by two spaces to set it apart.

setlocal expandtab
setlocal shiftwidth=2
try
    " Introduced in 7.3.693
    setlocal softtabstop=-1
catch /^Vim(set):E487/
    let &l:softtabstop = &shiftwidth
endtry
