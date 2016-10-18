" ---------- PATHOGEN ----------

runtime bundle/vim-pathogen/autoload/pathogen.vim
if exists("*pathogen#infect")
    execute pathogen#infect()
endif


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

" http://ethanschoonover.com/solarized
try
    colorscheme solarized
catch /^Vim(colorscheme):E185/
    " TODO: Pick an alternate scheme that works for light backgrounds.
    " The ones included with Vim are all pretty ugly.
endtry

set linebreak       " Wrap lines at word boundaries only.
set number          " Absolute line numbers on the left.
set ruler
set showcmd         " Show in-progress Normal mode commands.

" Incremental searching with highlighting.
set hlsearch
set incsearch

" Spell checking. (I don't enable checking globally because many
" filetypes become riddled with false positives. The guilty syntax files
" don't properly delineate where checking is and isn't appropriate.)
if has("syntax")
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

set printoptions+=paper:letter

let g:netrw_sort_sequence = ''  " Disable weird netrw sorting.
let g:loaded_netrw = 1          " Disable netrw entirely until I can
let g:loaded_netrwPlugin = 1    "       fix the broken mappings.

try
    source <sfile>.local
catch /^Vim(source):E484/
endtry
