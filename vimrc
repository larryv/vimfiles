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

" Enable filetype detection, plugins, and indent files.  All 'packadd!'
" commands that register plugins with filetype detection scripts must
" precede this command, or the scripts won't be loaded [1].
silent! filetype plugin indent on

" Use vi-compatible backspacing in defiance of MacVim and macOS's vim.
set backspace&

" Break long lines, but with restrictions.
set textwidth=72
set formatoptions+=l1

" Manage comment leaders (e.g., '#' or '//') automatically.
set formatoptions+=or
silent! set formatoptions+=j    " Needs patch 7.3.541.

" Use two spaces between sentences for compatibility with vi and Emacs.
set cpoptions+=J
silent! set formatoptions+=p    " Needs patch 8.1.0728.


" ---------- VIEWING ----------

" Soft-wrap only at certain characters, and prefix wrapped lines.
set linebreak
set showbreak=>\    " Sentinel comment to protect the trailing space.

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

" Enhance list mode.  Appending a duplicate 'tab:' is okay; it just
" supersedes the first one.
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<,nbsp:~
silent! set listchars+=tab:-->  " Needs patch 8.1.0759.


" ---------- MISCELLANEOUS ----------

" Disable modelines unless CVE-2007-2438 [2] has been patched.
set nomodeline
set modelines=0
if v:version > 700 || (v:version == 700 && has('patch234') && has('patch235'))
	" If +eval is unavailable, reset these in ~/.vimrc.local.
	set modeline&
	set modelines&
endif

" Enable the command-line completion menu.
set wildmenu

" Avoid 'silent! source ~/.vimrc.local' because that masks errors from
" within ~/.vimrc.local itself.  Can't use 'silent! try' because without
" +eval that *still* produces an error.  (To avoid E484 when +eval is
" absent, create an empty, readable ~/.vimrc.local file.)
silent! execute 'try'
	source ~/.vimrc.local
silent! catch /\m\C^Vim(source):E484:/
silent! endtry


" ---------- EPILOGUE ----------

" Enable syntax highlighting if colors are available.  Do this down here
" to let ~/.vimrc.local make tweaks first, if necessary [3].  (The GUI is
" handled by gvimrc to allow ~/.gvimrc.local to make its own tweaks.)
" (If colors are available but Vim lacks +eval, enable highlighting in
" ~/.vimrc.local.)
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
"  1. https://vimhelp.org/repeat.txt.html#%3Apackadd
"  2. https://nvd.nist.gov/vuln/detail/CVE-2007-2438
"  3. https://vimhelp.org/syntax.txt.html#xterm-color
