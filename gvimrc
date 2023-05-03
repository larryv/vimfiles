" gvimrc
" ------
"
" SPDX-License-Identifier: CC0-1.0
"
" Written in 2012, 2016, 2019-2021 by Lawrence Velazquez <vq@larryv.me>.
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

" Show absolute line numbers in the left gutter.  This makes prefixing
" soft-wrapped lines largely pointless, so stop doing that.
set number
set showbreak&

" Avoid 'silent! source ~/.gvimrc.local' because that masks errors from
" within ~/.gvimrc.local itself.  Can't use 'silent! try' because
" without +eval that *still* produces an error.  (To avoid E484 when
" +eval is absent, create an empty, readable ~/.gvimrc.local file.)
silent! execute 'try'
    source ~/.gvimrc.local
silent! catch /\m\C^Vim(source):E484:/
silent! endtry

" Do this down here to let ~/.gvimrc.local make tweaks first, if
" necessary (<https://vimhelp.org/syntax.txt.html#xterm-color>).
" The GUI always has colors.
silent! syntax enable
