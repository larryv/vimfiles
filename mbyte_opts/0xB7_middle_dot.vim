" mbyte_opts/0xB7_middle_dot.vim
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
" 	· 0xB7 MIDDLE DOT
"
" which is part of these encodings:
"
" 	IBM code page 922 (Estonian)
" 	IBM code page 1129 (Vietnamese)
" 	IBM code page 1163 (Vietnamese with euro sign)
" 	ISO/IEC 8859-1 (Latin 1, Western European)
" 	ISO/IEC 8859-3 (Latin 3, Southern European)
" 	ISO/IEC 8859-7 (Greek)
" 	ISO/IEC 8859-8 (Hebrew)
" 	ISO/IEC 8859-9 (Latin 5, Turkish)
" 	ISO/IEC 8859-10 (Latin 6, Nordic)
" 	ISO/IEC 8859-13 (Latin 7, Baltic Rim)
" 	ISO/IEC 8859-15 (Latin 9, Western European)
" 	ISO/IEC 8859-16 (Latin 10, Southeastern European)
" 	KOI8-T (Tajik Cyrillic)
" 	RISC OS character set
" 	Windows/IBM code page 1250 (Central European)
" 	Windows/IBM code page 1251 (Cyrillic)
" 	Windows/IBM code page 1252 (Western European)
" 	Windows/IBM code page 1253 (Greek)
" 	Windows/IBM code page 1254 (Turkish)
" 	Windows/IBM code page 1255 (Hebrew)
" 	Windows/IBM code page 1256 (Arabic)
" 	Windows/IBM code page 1257 (Baltic)
" 	Windows/IBM code page 1258 (Vietnamese)
"
" To maximize cross-encoding compatibility, do not add other non-ASCII
" characters to this file.
"
" Sync with vimrc and gvimrc as necessary.


set listchars+=trail:· listchars-=trail:~
set listchars+=nbsp:· listchars-=nbsp:~


" Affects writes only.  Read with ':edit ++enc=latin1' if necessary.
" vim: set fileencoding=latin1:
