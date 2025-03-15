" mbyte_opts/0xE1_middle_dot.vim
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


" Modify listchars to use octet 0xE1/0341/225, which some encodings map
" to Unicode code point U+00B7 MIDDLE DOT.
"
" To maximize cross-encoding compatibility, do not add other non-ASCII
" characters to this file.
"
" Sync with vimrc and gvimrc as necessary.


set listchars+=trail:á listchars-=trail:~
set listchars+=nbsp:á listchars-=nbsp:~


" Affects writes only.  Read with ':edit ++enc=macroman' if necessary.
" vim: set fileencoding=macroman:
