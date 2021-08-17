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

" If ~/.vimrc.local created the global variable 'multibyte_optvals',
" then use it to automatically set options according to 'encoding'.  For
" an example of the required data structure, see vimrc.local.sample.
" (This is controlled by ~/.vimrc.local because I don't want to use
" non-ASCII characters in contexts where they're rendered poorly.)
if has('multi_byte')
    if exists('g:multibyte_optvals')
        let s:multibyte_optvals = g:multibyte_optvals
        unlet g:multibyte_optvals

        " Weed out unrecognized option names.
        call map(s:multibyte_optvals, 'filter(v:val, "exists(''&'' . v:key)")')

        function! s:EncodingChangedHandler() abort
            let l:optvals = get(s:multibyte_optvals, &encoding,
                        \       get(s:multibyte_optvals, 'latin1',
                        \           {}))
            for [l:opt, l:val] in items(l:optvals)
                if [eval('&l:' . l:opt)] ==# [eval('&g:' . l:opt)]
                    execute 'let &' . l:opt . ' = l:val'
                else
                    " Something else set the local value, so let it be.
                    execute 'let &g:' . l:opt . ' = l:val'
                endif
            endfor
        endfunction

        call s:EncodingChangedHandler()

        if has('autocmd')
            autocmd vimrc EncodingChanged * call s:EncodingChangedHandler()
        endif
    endif
endif


" ---------- REFERENCES ----------
"
"  3. https://vimhelp.org/syntax.txt.html#xterm-color
