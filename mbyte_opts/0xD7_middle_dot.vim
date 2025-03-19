" mbyte_opts/0xD7_middle_dot.vim
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


" Modify listchars to use byte 0xD7/0327/215, which some encodings map
" to Unicode code point U+00B7 MIDDLE DOT.
"
" To maximize cross-encoding compatibility, do not add other non-ASCII
" characters to this file.
"
" Sync with vimrc and gvimrc as necessary.


set listchars+=trail:× listchars-=trail:~
set listchars+=nbsp:× listchars-=nbsp:~


" Affects writes only.  Read with ':edit ++enc=8bit-iso-ir-143' if
" necessary.  (If iconv doesn't support this, use latin1 and remember
" that 0xD7 appears as U+00D7 MULTIPLICATION SIGN.)
" vim: set fileencoding=8bit-iso-ir-143:
