" ========== PATHOGEN.VIM ==========

runtime bundle/vim-pathogen/autoload/pathogen.vim
if exists("*pathogen#infect")
    execute pathogen#infect()
endif

" ========== GENERAL ==========

set modelines&          " Override /usr/share/vim/vimrc on OS X

" ========== EDITING ==========

set backspace=indent    " Allow backspacing over autoindent
set backspace+=eol      " Allow backspacing over line breaks
set backspace+=start    " Allow backspacing over start of insert

" ========== FORMATTING AND INDENTING ==========

set textwidth=72
set nojoinspaces        " One space between sentences when joining
set formatoptions+=r    " Insert comment leaders on <Enter> in Insert mode
set formatoptions+=o    " Insert comment leaders on 'o'/'O' in Normal mode
set formatoptions+=l    " Don't break long lines in Insert mode
set formatoptions+=1    " Don't break after one-letter words
if v:version > 703 || v:version == 703 && has("patch541")
    set formatoptions+=j    " Remove comment leaders when joining
endif

set expandtab           " Use spaces for indents
set shiftwidth=4        " 4 spaces per (auto)indent
if v:version > 703 || v:version == 703 && has("patch693")
    set softtabstop=-1  " [shiftwidth] spaces per <Tab>
else
    set softtabstop=4   " 4 spaces per <Tab>
endif
set listchars+=tab:>-   " Show tabs as '>-------' in list mode
set listchars+=trail:~  " Show trailing spaces as '~' in list mode

if has("autocmd")
    " Enable indenting, plugins, and filetype detection
    filetype plugin indent on
endif

" ========== DISPLAY ==========

set number                  " Show line numbers
if has("cmdline_info")
    set ruler               " Show ruler
    set showcmd             " Show partial commands in ruler
endif
if has("linebreak")
    set linebreak           " Wrap lines at word boundaries only
endif
if has("syntax")
    syntax enable           " Enable syntax highlighting
endif
if !empty(split(globpath(&runtimepath, "colors/solarized.vim"), "\n"))
    colorscheme solarized   " http://ethanschoonover.com/solarized
else
    " TODO: Pick an alternate scheme that works for light backgrounds.
    " The ones included with Vim are all pretty ugly.
endif

" ========== SEARCHING ==========

if has("extra_search")
    set hlsearch        " Highlight matches
    set incsearch       " Incremental search
endif

" ========== PRINTING ==========

set printoptions+=paper:letter

" ========== MISC ==========

let g:netrw_sort_sequence = ''  " disable weird netrw sorting
let g:loaded_netrw = 1          " disable netrw entirely until I can
let g:loaded_netrwPlugin = 1    "       fix the broken mappings
if filereadable(glob("~/.vimrc.local"))
    source ~/.vimrc.local
endif
