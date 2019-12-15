" vimfiles - My Vim configuration
"
" Written in 2012-2016, 2019 by Lawrence Velázquez <vq@larryv.me>
"
" To the extent possible under law, the author(s) have dedicated all
" copyright and related and neighboring rights to this software to the
" public domain worldwide. This software is distributed without any
" warranty.
"
" You should have received a copy of the CC0 Public Domain Dedication
" along with this software. If not, see
" <https://creativecommons.org/publicdomain/zero/1.0/>.


" ---------- EDITING ----------

if has("autocmd")
    filetype plugin indent on
endif

" The most permissive backspacing possible.
set backspace=indent,eol,start

" Use four spaces for indenting and <Tab>bing.
set expandtab
set shiftwidth=4
try
    set softtabstop=-1      " Introduced in 7.3.693.
catch /^Vim(set):E487/
    let &softtabstop = &shiftwidth
endtry

" Insert comment leaders (e.g., '#' or '//') automatically.
set formatoptions+=or

" Break long lines, but with restrictions.
set textwidth=72
set formatoptions+=l1

" Join lines with one space between sentences, removing comment leaders.
set nojoinspaces
try
    set formatoptions+=j    " Introduced in 7.3.541.
catch /^Vim(set):E539/
endtry


" ---------- VIEWING ----------

if has("syntax")
    syntax enable
endif

set linebreak       " Wrap lines at word boundaries only.
set number          " Absolute line numbers on the left.
set ruler
set showcmd         " Show in-progress Normal mode commands.

" Incremental searching with highlighting.
set hlsearch
set incsearch

" Spell checking. (This can be disabled in after/ftplugin for filetypes
" that are riddled with false positives because their syntax files don't
" properly delineate where checking is and isn't appropriate.)
if has("syntax")
    set spell
    set spelllang=en_us
endif

" Use these Unicode characters in list mode if possible:
" - U+00B6 PILCROW
" - U+00BB RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
" - U+00B7 MIDDLE DOT
" - U+2190 LEFTWARDS ARROW
" - U+2192 RIGHTWARDS ARROW
function! s:set_custom_listchars()
    let &listchars =
        \ &encoding =~ '^\%(utf\|ucs\)-'
            \ ? "trail:~,eol:\u00B6,tab:\u00BB-,extends:\u2192,"
            \   . "precedes:\u2190,nbsp:\u00B7"
            \ : "trail:~,eol:$,tab:>-,extends:>,precedes:<,nbsp:."
endfunction
call s:set_custom_listchars()

" Update 'listchars' automatically if 'encoding' changes.
if has("autocmd") && has("multi_byte") && !exists("s:autocommands_loaded")
    let s:autocommands_loaded = 1
    autocmd EncodingChanged * call s:set_custom_listchars()
endif


" ---------- MISCELLANEOUS ----------

" OS X's system vimrc disables modelines.
set modelines&

let g:netrw_sort_sequence = ''  " Disable weird netrw sorting.

try
    source ~/.vimrc.local
catch /^Vim(source):E484/
endtry
