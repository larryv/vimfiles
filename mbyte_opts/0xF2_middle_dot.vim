" mbyte_opts/0xF2_middle_dot.vim
" ------------------------------
"
" SPDX-License-Identifier: CC0-1.0
"
" Written in 2025 by Lawrence Velazquez <vq@larryv.me>.
"
" To the extent possible under law, the author has dedicated all
" copyright and related and neighboring rights to this software to the
" public domain worldwide.  This software is distributed without any
" warranty.
"
" You should have received a copy of the CC0 Public Domain Dedication
" along with this software.  If not, see
" <https://creativecommons.org/publicdomain/zero/1.0/>.


" Modify listchars to use this 8-bit character:
"
" 	ò 0xF2 MIDDLE DOT
"
" which is part of this encoding:
"
" 	HP Roman-8
"
" To maximize cross-encoding compatibility, do not add other non-ASCII
" characters to this file.
"
" Sync with vimrc and gvimrc as necessary.


set listchars+=trail:ò listchars-=trail:~
set listchars+=nbsp:ò listchars-=nbsp:~


" Affects writes only.  Read with ':edit ++enc=hp-roman8' if necessary.
" vim: set fileencoding=hp-roman8:
