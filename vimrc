" ========== GENERAL ==========

set nocompatible        " Does anyone really want vi compatibility?
set modelines&          " Override /usr/share/vim/vimrc on OS X
if has("multi_byte")
    set encoding=utf-8
endif
if has("autocmd")
    " Remove autocommands to prevent duplicates
    autocmd!
endif

" ========== EDITING ==========

set backspace=indent    " Allow backspacing over autoindent
set backspace+=eol      " Allow backspacing over line breaks
set backspace+=start    " Allow backspacing over start of insert

" ========== FORMATTING AND INDENTING ==========

set textwidth=72
set nojoinspaces        " One-space sentence spacing when joining
set formatoptions+=t    " Auto-wrap text
set formatoptions+=c    " Auto-wrap comments
set formatoptions+=r    " Insert comment leaders on <Enter> in Insert mode
set formatoptions+=q    " Allow formatting with 'gq'
set formatoptions+=n    " Recognize numbered lists
set formatoptions+=l    " Don't break already-long lines in Insert mode
set formatoptions+=1    " Don't break after 1-letter words
set formatoptions+=j    " Remove comment leaders when joining

set expandtab           " Use spaces for indents
set shiftwidth=4        " 4 spaces per 'tab' for indenting
set softtabstop=4       " 4 spaces per 'tab' while editing
set listchars+=tab:>-   " Make tab chars extra-obvious in list mode

if has("autocmd")
    " Enable indenting, plugins, and filetype detection
    filetype plugin indent on

    " Prefer smaller indenting in Markdown
    autocmd FileType markdown set shiftwidth=2 softtabstop=2
endif

" ========== DISPLAY ==========

set number              " Show line numbers
if has("cmdline_info")
    set ruler           " Show ruler
    set showcmd         " Show partial commands in ruler
endif
if has("linebreak")
    set linebreak       " Wrap lines at word boundaries only
endif
if has("syntax")
    syntax enable       " Enable syntax highlighting
endif
if !has("gui_running")
    colorscheme desert  " Better scheme for dark bg
endif

" ========== SEARCHING ==========

if has("extra_search")
    set hlsearch        " Highlight matches
    set incsearch       " Incremental search
endif

" ========== PRINTING ==========

if has("iconv")
    set printencoding=utf-8
endif
if has("statusline")
    " File name, help flag, modified flag, and page number
    set printheader="%t%h%m%=Page %N"
endif
set printoptions+=right:10pc    " Match default left margin
set printoptions+=number:y      " Print line numbers
set printoptions+=paper:letter

" ========== MISC ==========

let g:netrw_sort_sequence = ''  " disable weird netrw sorting
let g:loaded_netrw = 1          " disable netrw entirely until I can
let g:loaded_netrwPlugin = 1    "       fix the broken mappings
if filereadable(glob("~/.vimrc.local"))
    source ~/.vimrc.local
endif
