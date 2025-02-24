" set_opts.utf-8.vim
" ------------------
"
" SPDX-License-Identifier: CC0-1.0
"
" Written in 2025 by Lawrence Velázquez <vq@larryv.me>.
"
" To the extent possible under law, the author has dedicated all
" copyright and related and neighboring rights to this software to the
" public domain worldwide.  This software is distributed without any
" warranty.
"
" You should have received a copy of the CC0 Public Domain Dedication
" along with this software.  If not, see
" <https://creativecommons.org/publicdomain/zero/1.0/>.


" Modify listchars and showbreak to use these UTF-8 characters:
"
" 	¶ U+00B6 PILCROW SIGN (0xC2 0xB6)
" 	· U+00B7 MIDDLE DOT (0xC2 0xB7)
" 	← U+2190 LEFTWARDS ARROW (0xE2 0x86 0x90)
" 	→ U+2192 RIGHTWARDS ARROW (0xE2 0x86 0x92)
" 	⎯ U+23AF HORIZONTAL LINE EXTENSION (0xE2 0x8E 0xAF)
"
" Sync with vimrc and gvimrc as necessary.


" Enhance list mode.  Appending a duplicate 'tab:' is okay; it just
" supersedes the first one.
set listchars=eol:¶,tab:→⎯,trail:·,extends:→,precedes:←,nbsp:·
silent! set listchars+=tab:⎯⎯→  " Needs patch 8.1.0759.

" Prefix soft-wrapped lines.
set showbreak=→\    " Sentinel comment to protect the trailing space.
