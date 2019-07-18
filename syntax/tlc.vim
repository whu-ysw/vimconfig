" Vim syntax file
" Language:		tlc (for simulink coder)
" Maintainer:	Ysw
"

if exists("b:current_syntax")
		finish
end
" Keywords
syn match tlcVariable '[a-zA-Z\_][a-zA-Z]*'
syn keyword tlcKeyword assign realformat selectfile include nextgroup=tlcVariable skipwhite

" Matches
syn match tlcNumber '\s\d\+'

syn region tlcKeywords start=/%/ end=/ / contains=tlcKeyword

"syn region tlcComment start=/%%/ end=// oneline 
" Regions
syn region tlcString start=/"/ end=/"/ oneline
syn region tlcStringSingleQuote start=/'/ end=/'/ oneline
syn region tlcStringDoubleQuote start=/''/ end=/''/ 
syn region tlcCommentOut start=/\/\*/ end=/\*\//
syn region tlcConfig start=/\/%/ end=/%\//
syn match tlcComment /%%.*/

" Define the default highlighting
"
hi def link tlcKeyword Statement
hi def link tlcNumber Constant
hi def link tlcVariable Identifier
hi def link tlcComment Comment

let b:current_syntax = "tlc"
