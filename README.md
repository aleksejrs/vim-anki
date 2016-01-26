Vim 7.4 syntax highlighting file for Anki 2.0.33 search queries (browser or filtered decks).  Added to the queries are comments with goal and importance/urgency notes (they are not supported by Anki itself, but removed by shell scripts which include “`|egrep -v "^\s*(;|--)"`”).


## Based on:

`/usr/share/vim/vim74/syntax/scheme.vim` from the Debian package
`vim-runtime` 2:7.4.963-1.

# BUGS:

Keywords inside strings are highlighted.  We can't just color the strings
though.

