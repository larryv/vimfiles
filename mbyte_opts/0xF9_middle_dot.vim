" mbyte_opts/0xF9_middle_dot.vim
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


" Modify listchars to use byte 0xF9/0371/249, which some encodings map
" to Unicode code point U+00B7 MIDDLE DOT [1].
"
" To maximize cross-encoding compatibility, do not add other non-ASCII
" characters to this file.
"
" Sync with vimrc and gvimrc as necessary.


set listchars+=trail:ù listchars-=trail:~
set listchars+=nbsp:ù listchars-=nbsp:~


" ---------- NOTES AND REFERENCES ----------
"
"  [1] English Wikipedia [2] claims (without citations) that CWI-2 maps
"      0xF9 to U+2219 BULLET OPERATOR and 0xFA to U+00B7, but glibc [3]
"      and libintl-perl [4] map 0xF9 to U+00B7 and 0xFA to U+2022 BULLET.
"  [2] https://en.wikipedia.org/wiki/CWI-2
"  [3] https://haible.de/bruno/charsets/conversion-tables/RFC1345-other.html
"  [4] https://metacpan.org/release/GUIDO/libintl-perl-1.35/view/lib/Locale/RecodeData/CWI.pm#CHARACTER-TABLE


" Affects writes only.  Read with ':edit ++enc=8bit-cwi' if necessary.
" (If iconv doesn't support this, use latin1 and remember that 0xF9
" appears as U+00F9 LATIN SMALL LETTER U WITH GRAVE.)
" vim: set fileencoding=8bit-cwi:
