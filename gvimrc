" gvimrc
" ------
"
" SPDX-License-Identifier: CC0-1.0
"
" Written in 2012, 2016, 2019-2021, 2023, 2025 by Lawrence Velazquez
" <vq@larryv.me>.
"
" To the extent possible under law, the author has dedicated all
" copyright and related and neighboring rights to this software to the
" public domain worldwide.  This software is distributed without any
" warranty.
"
" You should have received a copy of the CC0 Public Domain Dedication
" along with this software.  If not, see
" <https://creativecommons.org/publicdomain/zero/1.0/>.


" Disable toolbar.
set guioptions-=T

" Show inactive menu items to aid discoverability.
set guioptions+=g

" Apply local settings, if any.
runtime gvimrc.local

" Enable syntax highlighting.  Do this down here to let gvimrc.local
" make tweaks first, if necessary.
if has('syntax')
	syntax enable
endif

" Add non-ASCII characters to listchars and (if using UTF-8) showbreak,
" based on `encoding` or the runtime locale.  May require +iconv [1] or
" +iconv/dyn [2] for conversion.  Do this down here so that vimrc.local
" or gvimrc.local can disable it, if desired.  (If Vim does not have
" +eval, source an appropriate file from mbyte_opts/mb or mbyte_opts/sb
" in gvimrc.local.  See gvimrc.local.sample.)
if !exists('g:mbyte_opts') || g:mbyte_opts
	runtime mbyte_opts/auto.vim
endif

" Show absolute line numbers in the left gutter instead of prefixing
" soft-wrapped lines.  Do this down here so that this file can share
" mbyte_opts with vimrc instead of doing its own thing just to avoid
" setting showbreak again.
set number
set showbreak=


" ---------- REFERENCES ----------
"
"  [1] https://vimhelp.org/mbyte.txt.html#mbyte-conversion
"  [2] https://vimhelp.org/mbyte.txt.html#iconv-dynamic
