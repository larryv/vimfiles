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
let &softtabstop = v:version > 703 || v:version == 703 && has("patch693")
                 \ ? -1
                 \ : &shiftwidth

" Insert comment leaders (e.g., '#' or '//') automatically.
set formatoptions+=or

" Break long lines, but with restrictions.
set textwidth=72
set formatoptions+=l1

" Join lines with one space between sentences, removing comment leaders.
set nojoinspaces
if v:version > 703 || v:version == 703 && has("patch541")
    set formatoptions+=j
endif


" ---------- VIEWING ----------

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

set linebreak       " Wrap lines at word boundaries only.
set number          " Absolute line numbers on the left.
set ruler
set showcmd         " Show in-progress Normal mode commands.

" Incremental searching with highlighting.
set hlsearch
set incsearch

set listchars+=tab:>-   " Show tabs as '>-------' in list mode
set listchars+=trail:~  " Show trailing spaces as '~' in list mode


" ---------- MISCELLANEOUS ----------

" OS X's system vimrc disables modelines.
set modelines&

set printoptions+=paper:letter

let g:netrw_sort_sequence = ''  " Disable weird netrw sorting.
let g:loaded_netrw = 1          " Disable netrw entirely until I can
let g:loaded_netrwPlugin = 1    "       fix the broken mappings.

if filereadable(glob("~/.vimrc.local"))
    source ~/.vimrc.local
endif
