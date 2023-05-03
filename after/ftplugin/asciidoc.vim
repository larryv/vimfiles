" after/ftplugin/asciidoc.vim
" ---------------------------
"
" SPDX-License-Identifier: CC0-1.0
"
" Written in 2023 by Lawrence Velazquez <vq@larryv.me>.
"
" To the extent possible under law, the author has dedicated all
" copyright and related and neighboring rights to this software to the
" public domain worldwide.  This software is distributed without any
" warranty.
"
" You should have received a copy of the CC0 Public Domain Dedication
" along with this software.  If not, see
" <https://creativecommons.org/publicdomain/zero/1.0/>.


" Don't auto-wrap non-comment lines.  Some AsciiDoc elements cannot span
" multiple lines, and those that can often preserve the line breaks.
setlocal formatoptions-=t
