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

" Show absolute line numbers in the left gutter instead of prefixing
" soft-wrapped lines.  Do this down here so gvimrc.local can share
" set_opts.utf-8.vim with vimrc.local instead of doing its own thing
" just to avoid setting 'showbreak' again.
set number
set showbreak&

" Do this down here to let gvimrc.local make tweaks first, if necessary
" (<https://vimhelp.org/syntax.txt.html#xterm-color>).  The GUI always
" has colors.
silent! syntax enable
