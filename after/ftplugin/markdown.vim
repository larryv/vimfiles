" after/ftplugin/markdown.vim
" ---------------------------
"
" Written in 2016, 2019, 2021-2022 by Lawrence Velázquez <vq@larryv.me>.
"
" To the extent possible under law, the author(s) have dedicated all
" copyright and related and neighboring rights to this software to the
" public domain worldwide.  This software is distributed without any
" warranty.
"
" You should have received a copy of the CC0 Public Domain Dedication
" along with this software.  If not, see
" <https://creativecommons.org/publicdomain/zero/1.0/>.
"
" SPDX-License-Identifier: CC0-1.0


" Indenting with four spaces is universally recognized
" (https://brettterpstra.com/2015/08/24/write-better-markdown/#indentation).

setlocal expandtab
setlocal shiftwidth=4
try
    " Introduced in 7.3.693
    setlocal softtabstop=-1
catch /\m\C^Vim(setlocal):E487:/
    let &l:softtabstop = &l:shiftwidth ? &l:shiftwidth : &l:tabstop
endtry


" Make formatting of lists work for items of more than two lines.
setlocal autoindent
