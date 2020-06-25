" vimfiles - My Vim configuration
"
" Written in 2012-2016, 2019-2020 by Lawrence Velázquez <vq@larryv.me>
"
" To the extent possible under law, the author(s) have dedicated all
" copyright and related and neighboring rights to this software to the
" public domain worldwide. This software is distributed without any
" warranty.
"
" You should have received a copy of the CC0 Public Domain Dedication
" along with this software. If not, see
" <https://creativecommons.org/publicdomain/zero/1.0/>.


" Avoid duplicate autocommands if this file is sourced more than once.
if has("autocmd")
    augroup vimrc
        autocmd!
    augroup END
endif


" ---------- PATHOGEN ----------

if !has("packages")
    runtime pack/vim-pathogen/opt/vim-pathogen/autoload/pathogen.vim
    if exists("*pathogen#infect")
        execute pathogen#infect()
    endif
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
    " Introduced in 7.3.693.
    set softtabstop=-1
catch /^Vim(set):E487/
    let &softtabstop = &shiftwidth
endtry

" Insert comment leaders (e.g., '#' or '//') automatically.
set formatoptions+=or

" Break long lines, but with restrictions.
set textwidth=78
set formatoptions+=l1

" Join lines with one space between sentences, removing comment leaders.
set nojoinspaces
try
    " Introduced in 7.3.541.
    set formatoptions+=j
catch /^Vim(set):E539/
endtry


" ---------- VIEWING ----------

if has("syntax")
    syntax enable
endif

" Soft-wrap only at certain characters, and prefix wrapped lines.
set linebreak
function s:set_showbreak()
    " U+21AA RIGHTWARDS ARROW WITH HOOK
    let &showbreak = &encoding == "utf-8" ? "\u21AA " : "+> "
endfunction
call s:set_showbreak()
if has("autocmd") && has("multi_byte")
    autocmd vimrc EncodingChanged * call s:set_showbreak()
endif

" Enable ruler and show in-progress Normal-mode commands.
set ruler
set showcmd

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

" Display more than just EOL in list mode.
function s:set_listchars()
    try
        " Three-character 'tab' introduced in 8.1.0759.
        set listchars=tab:xyz
        " U+00B6 PILCROW
        " U+00B7 MIDDLE DOT
        " U+2190 LEFTWARDS ARROW
        " U+2192 RIGHTWARDS ARROW
        " U+23AF HORIZONTAL LINE EXTENSION
        let &listchars = &encoding == "utf-8"
                    \ ? "eol:\u00B6,tab:\u23AF\u23AF\u2192,trail:\u00B7,"
                    \   . "extends:\u2192,precedes:\u2190,nbsp:\u00B7"
                    \ : "eol:$,tab:-->,trail:~,extends:>,precedes:<,nbsp:~"
    catch /^Vim(set):E474/
        let &listchars = &encoding == "utf-8"
                    \ ? "eol:\u00B6,tab:\u2192\u23AF,trail:\u00B7,"
                    \   . "extends:\u2192,precedes:\u2190,nbsp:\u00B7"
                    \ : "eol:$,tab:>-,trail:~,extends:>,precedes:<,nbsp:~"
    endtry
endfunction
call s:set_listchars()
if has("autocmd") && has("multi_byte")
    autocmd vimrc EncodingChanged * call s:set_listchars()
endif


" ---------- MISCELLANEOUS ----------

" OS X's system vimrc disables modelines.
set modelines&

try
    source ~/.vimrc.local
catch /^Vim(source):E484/
endtry
