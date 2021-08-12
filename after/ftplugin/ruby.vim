" after/ftplugin/ruby.vim
" -----------------------
"
" Written in 2016, 2021 by Lawrence Velázquez <vq@larryv.me>.
"
" To the extent possible under law, the author(s) have dedicated all
" copyright and related and neighboring rights to this software to the
" public domain worldwide. This software is distributed without any
" warranty.
"
" You should have received a copy of the CC0 Public Domain Dedication
" along with this software. If not, see
" <https://creativecommons.org/publicdomain/zero/1.0/>.
"
" SPDX-License-Identifier: CC0-1.0


" Rubyists seem to prefer two-space indenting. Weirdos.

setlocal expandtab
setlocal shiftwidth=2
try
    " Introduced in 7.3.693
    setlocal softtabstop=-1
catch /\m\C^Vim(setlocal):E487:/
    let &l:softtabstop = &shiftwidth
endtry
