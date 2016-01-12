" Vim syntax file
" Language:	Anki 2.0 search filters + comments
" Last Change:	2016 Jan 12
" Maintainer:	Aleksej <deletesoftware@yandex.ru>


"" Based on:
"" Language:	Scheme (R5RS + some R6RS extras)
"" Last Change:	2012 May 13
"" Maintainer:	Sergey Khorev <sergey.khorev@gmail.com>
"" Original author:	Dirk van Deun <dirk@igwe.vub.ac.be>


" Initializing:

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

syn case ignore

" Quoted and backquoted stuff

"syn region schemeQuoted matchgroup=Delimiter start="['`]" end=![ \t()\[\]";]!me=e-1 contains=ALLBUT,schemeStruc,schemeSyntax,schemeFunc
"
"syn region schemeQuoted matchgroup=Delimiter start="['`](" matchgroup=Delimiter end=")" contains=ALLBUT,schemeStruc,schemeSyntax,schemeFunc
"syn region schemeQuoted matchgroup=Delimiter start="['`]#(" matchgroup=Delimiter end=")" contains=ALLBUT,schemeStruc,schemeSyntax,schemeFunc

" This line colors parentheses.
syn region schemeStrucRestricted matchgroup=Delimiter start="(" matchgroup=Delimiter end=")" contains=ALLBUT
"syn region schemeStrucRestricted matchgroup=Delimiter start="#(" matchgroup=Delimiter end=")" contains=ALLBUT,schemeStruc,schemeSyntax,schemeFunc

" R5RS Scheme Functions and Syntax:

"if version < 600
  set iskeyword=33,35-39,42-58,60-90,94,95,97-122,126,_
"else
"  setlocal iskeyword=33,35-39,42-58,60-90,94,95,97-122,126,_
"endif

syn keyword ankiSyntax and or
" Minus sign before "tag:", "fieldName:" etc.
syn match ankiSyntax	/\<-\a\+:\&-/
" Minus sign before a parenthesis.
" FIXME: What to do when it's in quotes?  Ignoring for now.
syn match ankiSyntax	/-(\&-/

" FIXME: Keywords are highlighted in the middle of a string, but we need them
" highlighted in the beginning of a string, so we can't just remove that.
"syn keyword ankiField tag note mid nid is prop

" This highlights more realistic keywords and field names, unless you use ":"
" inside quotes:
syn match ankiField	/[^- \t"()]\+:/

" Double-quotes should look like a part of the atom:
syn match ankiField	/"/

" Search wildcards (Anki does not support escaping them yet):
syn match ankiWildcard	/[_*]/

" [$], [$$], [/$], [/$$]
syn match latexBord	/\[\/\?$$\?\]/


" "Simple literals" line from the Scheme file, with "contains" modified.
syn region schemeString start=+\%(\\\)\@<!"+ skip=+\\[\\"]+ end=+"+ contains=ankiWildcard,latexBord,ankiField keepend

hi def link ankiField	Function
hi def link ankiSyntax	Statement
hi def link ankiWildcard SpecialChar
hi def link latexBord	PreProc
"hi def link schemeString Normal


" Comments (non-Anki syntax):

" Goal, desired state, task, subtask:
syn match	commentKw	/\<Цель:/	contained
"syn match	commentKw	/\<состояние:/	contained
"syn match	commentKw	/\<задача:/	contained
"syn match	commentKw	/\<подзадача:/	contained

" Priority:
syn match	importanceurgency		/\(\(не\)\?важное\|???\) \(\(не\)\?срочное\|???\)/	contained
syn match	filtComment	";.*$" contains=commentKw,importanceurgency

hi def link commentKw	Todo
hi def link importanceurgency Boolean
hi def link filtComment	Comment

let b:current_syntax = "anki2search"

let &cpo = s:cpo_save
unlet s:cpo_save
