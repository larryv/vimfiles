" mbyte_opts/auto.vim
" -------------------
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


" Add non-ASCII characters to listchars and (if using UTF-8) showbreak.
"
" If Vim has +multi_byte, choose characters based on `encoding`.  If
" `encoding` is 'latin1', require that v:ctype agree because Vim also
" uses 'latin1' for unrecognized encodings.
"
" If Vim does not have +multi_byte, and v:ctype specifies a single-byte
" encoding, choose characters from that encoding.  The encoding must be
" single-byte because Vim does not handle multibyte characters properly
" without +multi_byte.
"
" May require +iconv [1] or +iconv/dyn [2] for conversion.


" Try to extract an encoding from the locale; the assumed locale format
" is from the Vim source code [3].  Normalize the extracted encoding to
" reduce the number of sourced files required for the fallback behavior.
let s:ctype_enc = get(matchlist(v:ctype, '\v\.(.{-})%($|[@+,])'), 1, "")
let s:ctype_enc = tolower(substitute(s:ctype_enc, '-', "", 'g'))

let s:cmd_fmt = 'runtime mbyte_opts/%s/%s.vim'

if &encoding == "" && s:ctype_enc != ""
	execute printf(s:cmd_fmt, 'sb', fnameescape(s:ctype_enc))
elseif &encoding ==? 'latin1' && s:ctype_enc !=# 'iso88591'
	" Do nothing.
	" TODO: Figure out how to deal with Windows-1252.
elseif &encoding != ""
	execute printf(s:cmd_fmt, '[ms]b', fnameescape(&encoding))
endif

unlet s:ctype_enc
unlet s:cmd_fmt


" ---------- REFERENCES ----------
"
"  [1] https://vimhelp.org/mbyte.txt.html#mbyte-conversion
"  [2] https://vimhelp.org/mbyte.txt.html#iconv-dynamic
"  [3] https://github.com/vim/vim/blob/v9.1.0/src/mbyte.c#L4699
