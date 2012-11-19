set guioptions-=T   " Disable toolbar
set guioptions+=g   " Don't hide unavailable menu items, show in gray
if filereadable(glob("~/.gvimrc.local"))
    source ~/.gvimrc.local
endif
