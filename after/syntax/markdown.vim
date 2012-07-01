" Add fenced code blocks for GitHub Flavored Markdown
syn cluster markdownBlock add=markdownFencedCodeBlock
syn region markdownFencedCodeBlock matchgroup=markdownCodeDelimiter start="^```\w*$" end="^```$" keepend contains=markdownLineStart
