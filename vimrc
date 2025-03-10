" vimrc
" -----
"
" SPDX-License-Identifier: CC0-1.0
"
" Written in 2012-2016, 2019-2021, 2023, 2025 by Lawrence Velazquez
" <vq@larryv.me>.
"
" To the extent possible under law, the author has dedicated all
" copyright and related and neighboring rights to this software to the
" public domain worldwide.  This software is distributed without any
" warranty.
"
" You should have received a copy of the CC0 Public Domain Dedication
" along with this software.  If not, see
" <https://creativecommons.org/publicdomain/zero/1.0/>.


" Avoid duplicate autocommands if this file is sourced more than once.
silent! augroup vimrc
silent! autocmd!
silent! augroup END


" ---------- PATHOGEN ----------

if !has('packages')
	runtime pack/versioned/opt/vim-pathogen/autoload/pathogen.vim
	if exists('*pathogen#infect')
		execute pathogen#infect()
	endif
endif


" ---------- EDITING ----------

" Enhance the '%' Normal-mode command.
if has('packages')
	packadd! matchit
endif

" Enable filetype detection, plugins, and indent files.  All :packadd!
" commands that register plugins with filetype detection scripts must
" precede this command, or the scripts won't be loaded [1].
if has('autocmd')
	filetype plugin indent on
endif

" Use vi-compatible backspacing in defiance of MacVim and macOS's vim.
set backspace=

" Break long lines, but with restrictions.
set textwidth=72
set formatoptions+=l1

" Manage comment leaders (e.g., '#' or '//') automatically.  Patch
" 7.3.541 required for 'j'.
set formatoptions+=or
silent! set formatoptions+=j

" Use two spaces between sentences for compatibility with vi and Emacs.
" Patch 8.1.0728 required for 'p'.
set cpoptions+=J
silent! set formatoptions+=p


" ---------- VIEWING ----------

" Prefix soft-wrapped lines.  (Keep synced with files under mbyte_opts
" that directly modify showbreak.)
set showbreak=->\   " Sentinel comment to protect the trailing space.

" Enable ruler and show in-progress Normal-mode commands.
set ruler
set showcmd

" Search incrementally, with highlighting.
set hlsearch
set incsearch

" Check spelling.  (This can be disabled in after/ftplugin for filetypes
" that are riddled with false positives because their syntax files don't
" properly delineate where checking is and isn't appropriate.)
set spell
set spelllang=en_us

" Enhance list mode.  Patch 8.1.0759 required for 'tab:xyz'.  (Keep
" synced with files under mbyte_opts that directly modify listchars,
" as well as with gvimrc.local.sample.)
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<,nbsp:~
silent! set listchars+=tab:--> listchars-=tab:>-


" ---------- MISCELLANEOUS ----------

" Disable modelines unless CVE-2007-2438 [2] has been patched.
set nomodeline
set modelines=0
if v:version > 700 || (v:version == 700 && has('patch234') && has('patch235'))
	" If Vim doesn't have +eval, reset these in vimrc.local, but if
	" the GUI version is unpatched, re-disable them in gvimrc.local.
	" See vimrc.local.sample and gvimrc.local.sample.
	set modeline&
	set modelines&
endif

" Enable the command-line completion menu.
set wildmenu

" Apply local settings, if any.
runtime vimrc.local


" ---------- EPILOGUE ----------

" Enable syntax highlighting if colors are available.  Do this down here
" to let vimrc.local make tweaks first, if necessary [3].  Let gvimrc
" and gvimrc.local handle the GUI.  (If the aforementioned tweaks become
" necessary, ensure that they aren't inadvertently applied to the GUI.)
if !has('gui_running') && has('syntax') && &t_Co > 2
	syntax enable
endif

" Add non-ASCII characters to listchars and (if using UTF-8) showbreak,
" based on `encoding` or the runtime locale.  May require +iconv [4] or
" +iconv/dyn [5] for conversion.  Do this down here so that vimrc.local
" can disable it, if desired.  Let gvimrc and gvimrc.local handle the
" GUI.  (If Vim does not have +eval, source an appropriate file from
" mbyte_opts/mb or mbyte_opts/sb in vimrc.local.  If the sourced file
" does not suit the GUI's encoding, restore the original listchars in
" gvimrc.local.  See vimrc.local.sample and gvimrc.local.sample.)
if !has('gui_running') && (!exists('g:mbyte_opts') || g:mbyte_opts)
	runtime mbyte_opts/auto.vim
endif


" ---------- REFERENCES ----------
"
"  [1] https://vimhelp.org/repeat.txt.html#%3Apackadd
"  [2] https://nvd.nist.gov/vuln/detail/CVE-2007-2438
"  [3] https://vimhelp.org/syntax.txt.html#xterm-color
"  [4] https://vimhelp.org/mbyte.txt.html#mbyte-conversion
"  [5] https://vimhelp.org/mbyte.txt.html#iconv-dynamic
