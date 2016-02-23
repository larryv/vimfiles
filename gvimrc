" I don't want a toolbar; this isn't Office.
set guioptions-=T

" Showing inactive menu items aids discoverability.
set guioptions+=g

try
    source ~/.gvimrc.local
catch /^Vim(source):E484/
endtry
