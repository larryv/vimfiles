" HTML 5 tags

let s:html5_tags = '\|section\|nav\|article\|aside'
               \ . '\|hgroup\|header\|footer'
               \ . '\|figure\|figcaption\|details'
               \ . '\|time\|mark'

if exists('g:html_indent_tags')
    let g:html_indent_tags = g:html_indent_tags . s:html5_tags
else
    let g:html_indent_tags = s:html5_tags
endif
