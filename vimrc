" vimrc
" -----
"
" Written in 2012-2016, 2019-2021 by Lawrence Velázquez <vq@larryv.me>.
"
" To the extent possible under law, the author(s) have dedicated all
" copyright and related and neighboring rights to this software to the
" public domain worldwide. This software is distributed without any
" warranty.
"
" You should have received a copy of the CC0 Public Domain Dedication
" along with this software. If not, see
" <https://creativecommons.org/publicdomain/zero/1.0/>.
"
" SPDX-License-Identifier: CC0-1.0


" Avoid duplicate autocommands if this file is sourced more than once.
silent! augroup vimrc
silent! autocmd!
silent! augroup END


" ---------- PATHOGEN ----------

if !has("packages")
    runtime pack/vim-pathogen/opt/vim-pathogen/autoload/pathogen.vim
    if exists("*pathogen#infect")
        execute pathogen#infect()
    endif
endif


" ---------- EDITING ----------

silent! filetype plugin indent on

" The most permissive backspacing possible.
set backspace=indent,eol,start

" Use four spaces for indenting and <Tab>bing.
set expandtab
set shiftwidth=4
set softtabstop=4
" Can't use 'set softtabstop=-1' without patch 7.3.693, even silently,
" because it leaves a value of 0.  (If Vim has that patch but lacks
" +eval, set 'softtabstop' in ~/.vimrc.local.)
if v:version > 703 || (v:version == 703 && has('patch693'))
    set softtabstop=-1
endif

" Insert comment leaders (e.g., '#' or '//') automatically.
set formatoptions+=or

" Break long lines, but with restrictions.
set textwidth=72
set formatoptions+=l1

" Join lines with one space between sentences, removing comment leaders.
set nojoinspaces
silent! set formatoptions+=j    " Needs patch 7.3.541.


" ---------- VIEWING ----------

" Soft-wrap only at certain characters, and prefix wrapped lines.
set linebreak
set showbreak=+>\   " Sentinel comment to protect the trailing space.
if has("linebreak")
    " U+21AA RIGHTWARDS ARROW WITH HOOK
    " Technically, I shouldn't be using this because it's not a single-
    " cell character, but it works well enough in Apple Terminal when
    " followed by a space. Unfortunately, MacVim sometimes renders the
    " space *over* the head of the arrow, cutting it off. Fortunately,
    " I show line numbers in MacVim, making this much less necessary.
    if has("multi_byte") && !has("gui_running")
        function s:set_showbreak()
            let &showbreak = &encoding == "utf-8" ? "\u21AA " : "+> "
        endfunction
        call s:set_showbreak()
        if has("autocmd")
            autocmd vimrc EncodingChanged * call s:set_showbreak()
        endif
    endif
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
set spell
set spelllang=en_us

" Display more than just EOL in list mode.  Appending a duplicate 'tab:'
" is okay; it just supersedes the first one.
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<,nbsp:~
silent! set listchars+=tab:-->  " Needs patch 8.1.0759.
if has("multi_byte")
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
if has("autocmd")
    autocmd vimrc EncodingChanged * call s:set_listchars()
endif
endif


" ---------- MISCELLANEOUS ----------

" OS X's system vimrc disables modelines.
set modelines&

" Avoid 'silent! source ~/.vimrc.local' because that masks errors from
" within ~/.vimrc.local itself.  Can't use 'silent! try' because without
" +eval that *still* produces an error.  (To avoid E484 when +eval is
" absent, create an empty, readable ~/.vimrc.local file.)
silent! execute 'try'
    source ~/.vimrc.local
silent! catch /^Vim(source):E484/
silent! endtry

" Enable syntax highlighting if colors are available.  Skip the GUI
" because gvimrc handles that.  Do this down here to let ~/.vimrc.local
" make terminal-specific tweaks first, if necessary [3].  (If colors are
" available but Vim lacks +eval, enable highlighting in ~/.vimrc.local.)
if has('syntax') && !has('gui_running') && &t_Co > 2
    syntax enable
endif


" ---------- REFERENCES ----------
"
"  3. https://vimhelp.org/syntax.txt.html#xterm-color
