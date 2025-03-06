" mbyte_opts/0xFA_middle_dot.vim
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
" 	ú 0xFA MIDDLE DOT
"
" which is part of these encodings:
"
" 	Atari ST character set
" 	IBM/OEM code page 437 (United States)
" 	IBM/OEM code page 737 (Greek)
" 	IBM/OEM code page 775 (Baltic Rim)
" 	IBM/OEM code page 850 (Western European)
" 	IBM code page 856 (Hebrew)
" 	IBM/OEM code page 857 (Turkish)
" 	IBM/OEM code page 858 (Western European with euro sign)
" 	IBM/OEM code page 860 (Portuguese)
" 	IBM/OEM code page 861 (Icelandic)
" 	IBM/OEM code page 862 (Hebrew)
" 	IBM/OEM code page 863 (Canadian French)
" 	IBM/OEM code page 865 (Nordic)
" 	IBM/OEM code page 866 (Russian Cyrillic)
" 	IBM code page 1131 (Belarusian Cyrillic)
"
" To maximize cross-encoding compatibility, do not add other non-ASCII
" characters to this file.
"
" Sync with vimrc and gvimrc as necessary.


set listchars+=trail:ú listchars-=trail:~
set listchars+=nbsp:ú listchars-=nbsp:~


" Affects writes only.  Read with ':edit ++enc=cp850' if necessary.
" vim: set fileencoding=cp850:
