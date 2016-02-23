" ---------- PATHOGEN ----------

runtime bundle/vim-pathogen/autoload/pathogen.vim
if exists("*pathogen#infect")
    execute pathogen#infect()
endif

" ---------- GENERAL ----------

" OS X's system vimrc disables modelines.
set modelines&

" ---------- EDITING ----------

" The most permissive backspacing possible.
set backspace=indent
set backspace+=eol
set backspace+=start

" ---------- FORMATTING AND INDENTING ----------

" Insert comment leaders (e.g., '#' or '//') automatically.
set formatoptions+=o
set formatoptions+=r

" Break long lines, but with restrictions.
set textwidth=72
set formatoptions+=l
set formatoptions+=1

" Join lines with one space between sentences, removing comment leaders.
set nojoinspaces
if v:version > 703 || v:version == 703 && has("patch541")
    set formatoptions+=j
endif

" Use four spaces for indenting and <Tab>bing.
set expandtab
set shiftwidth=4
if v:version > 703 || v:version == 703 && has("patch693")
    set softtabstop=-1
else
    set softtabstop=4
endif
set listchars+=tab:>-   " Show tabs as '>-------' in list mode
set listchars+=trail:~  " Show trailing spaces as '~' in list mode

if has("autocmd")
    filetype plugin indent on
endif

" ---------- VIEWING ----------

set number          " Absolute line numbers on the left.
set ruler
set showcmd         " Show in-progress Normal mode commands.
set linebreak       " Wrap lines at word boundaries only.
if has("syntax")
    syntax enable
endif
" http://ethanschoonover.com/solarized
if !empty(split(globpath(&runtimepath, "colors/solarized.vim"), "\n"))
    colorscheme solarized
else
    " TODO: Pick an alternate scheme that works for light backgrounds.
    " The ones included with Vim are all pretty ugly.
endif

" ---------- SEARCHING ----------

" Incremental searching with highlighting.
set hlsearch
set incsearch

" ---------- PRINTING ----------

set printoptions+=paper:letter

" ---------- MISCELLANEOUS ----------

let g:netrw_sort_sequence = ''  " Disable weird netrw sorting.
let g:loaded_netrw = 1          " Disable netrw entirely until I can
let g:loaded_netrwPlugin = 1    "       fix the broken mappings.
if filereadable(glob("~/.vimrc.local"))
    source ~/.vimrc.local
endif
