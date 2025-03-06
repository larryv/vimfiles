" mbyte_opts/0xF4_pilcrow_sign.vim
" --------------------------------
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
" 	ô 0xF4 PILCROW SIGN
"
" which is part of these encodings:
"
" 	HP Roman-8
" 	IBM/OEM code page 775 (Baltic Rim)
" 	IBM/OEM code page 850 (Western European)
" 	IBM code page 856 (Hebrew)
" 	IBM/OEM code page 857 (Turkish)
" 	IBM/OEM code page 858 (Western European with euro sign)
"
" To maximize cross-encoding compatibility, do not add other non-ASCII
" characters to this file.
"
" Sync with vimrc and gvimrc as necessary.


set listchars+=eol:ô listchars-=eol:$


" Affects writes only.  Read with ':edit ++enc=cp850' if necessary.
" vim: set fileencoding=cp850:
