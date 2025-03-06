" Not sure it's possible to use cp1252 directly.  When Vim initializes
" itself under Windows-1252, it chooses latin1.
" https://github.com/vim/vim/blob/v9.1.0/src/mbyte.c#L4748-L4749
" TODO: Test 'set enc=cp1252' on Windows.
runtime! mbyte_opts/0xB6_pilcrow_sign.vim mbyte_opts/0xB7_middle_dot.vim
