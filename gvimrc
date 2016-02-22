" I don't want a toolbar; this isn't Office.
set guioptions-=T

" Showing inactive menu items aids discoverability.
set guioptions+=g

if filereadable(glob("~/.gvimrc.local"))
    source ~/.gvimrc.local
endif
