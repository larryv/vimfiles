" Rubyists seem to prefer two-space indenting. Weirdos.

setlocal expandtab
setlocal shiftwidth=2
try
    " Introduced in 7.3.693
    setlocal softtabstop=-1
catch /^Vim(set):E487/
    let &l:softtabstop = &shiftwidth
endtry
