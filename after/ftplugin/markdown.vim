" Indenting with four spaces is universally recognized
" (http://brettterpstra.com/2015/08/24/write-better-markdown#indentation).

setlocal expandtab
setlocal shiftwidth=4
if &l:softtabstop != -1
    let &l:softtabstop = &shiftwidth
endif
