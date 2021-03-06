" vimfiles - My Vim configuration
"
" Written in 2019 by Lawrence Velázquez <vq@larryv.me>
"
" To the extent possible under law, the author(s) have dedicated all
" copyright and related and neighboring rights to this software to the
" public domain worldwide. This software is distributed without any
" warranty.
"
" You should have received a copy of the CC0 Public Domain Dedication
" along with this software. If not, see
" <https://creativecommons.org/publicdomain/zero/1.0/>.

setlocal nospell

" Indent with tabs because `git config` does.
setlocal noexpandtab
try
    " Introduced in 7.3.629.
    setlocal shiftwidth=0
catch /^Vim(setlocal):E487/
    let &l:shiftwidth = &tabstop
endtry
