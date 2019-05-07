" Recognize bulleted lists instead of numbered lists. I never use
" numbered lists in Git commit messages.
setlocal autoindent
let &l:formatlistpat = '^\s*[-*]\s*'
setlocal formatoptions+=n
