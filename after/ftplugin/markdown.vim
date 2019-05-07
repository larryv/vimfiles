" Some Markdown implementations are aggressive about turning (non-list)
" text into code blocks if it is indented four spaces. I like to indent
" link references and certain other text by two spaces to set it apart.

setlocal expandtab
setlocal shiftwidth=2
try
    " Introduced in 7.3.693
    setlocal softtabstop=-1
catch /^Vim(set):E487/
    let &l:softtabstop = &shiftwidth
endtry
