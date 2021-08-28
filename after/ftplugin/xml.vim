" after/ftplugin/xml.vim
" ----------------------
"
" Written in 2021 by Lawrence Velázquez <vq@larryv.me>.
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


" Indent XML property list files using tabs, as Apple's tools do.

if [expand('%:e')] ==? ['plist']
    setlocal noexpandtab

    try
        " Needs patch 7.3.629.
        setlocal shiftwidth=0
    catch /\m\C^Vim(setlocal):E487:/
        let &l:shiftwidth = &l:tabstop
    endtry

    try
        " Needs patch 7.3.693.
        setlocal softtabstop=-1
    catch /\m\C^Vim(setlocal):E487:/
        let &l:softtabstop = &l:shiftwidth ? &l:shiftwidth : &l:tabstop
    endtry
endif
