" Syntax highlighting for Edge templates (AdonisJS)
" HTML base + Edge directives, mustaches, comments, JS expressions

if exists("b:current_syntax")
  finish
endif

" Load HTML syntax as base
runtime! syntax/html.vim
unlet! b:current_syntax

" Dracula colors for Edge syntax
hi EdgePurple guifg=#BD93F9
hi EdgePink guifg=#FF79C6
hi EdgeGreen guifg=#50FA7B
hi EdgeYellow guifg=#F1FA8C
hi EdgeOrange guifg=#FFB86C
hi EdgeCyan guifg=#8BE9FD

" === Edge comments: {{-- comment --}} (multiline) ===
syn region edgeComment start="{{--" end="--}}" containedin=ALL
hi def link edgeComment Comment

" === Edge safe output: {{ expression }} ===
syn region edgeOutput start="{{" end="}}" containedin=ALLBUT,edgeComment,edgeRawOutput contains=@edgeJsExpr
hi def link edgeOutput EdgePurple

" === Edge raw output: {{{ expression }}} ===
syn region edgeRawOutput start="{{{" end="}}}" containedin=ALLBUT,edgeComment contains=@edgeJsExpr
hi def link edgeRawOutput EdgePurple

" === JS expression cluster (reusable) ===
syn cluster edgeJsExpr contains=edgeJsStringSingle,edgeJsStringDouble,edgeJsTemplateLit,edgeJsNumber,edgeJsBoolean,edgeJsKey,edgeJsOperator

" === Edge tag: @directive alone (without parentheses) ===
" Match @end, @else, @super, @!component, etc.
syn match edgeTag "@!\?\w\+" containedin=ALL
hi def link edgeTag EdgePurple

" === Edge tag arguments: @tag(...) - multiline, with JS sub-highlighting ===
" Support @tag() and @!tag() (self-closing components)
syn region edgeTagArgs matchgroup=EdgePurple start="@!\?\w\+\s*(" end=")" containedin=ALL contains=@edgeJsExpr,edgeNestedParen,edgeNestedBrace
hi def link edgeTagArgs EdgePink

" === Nested parentheses ===
syn region edgeNestedParen start="(" end=")" contained contains=@edgeJsExpr,edgeNestedParen,edgeNestedBrace transparent
" === Nested braces (JS objects) ===
syn region edgeNestedBrace start="{" end="}" contained contains=@edgeJsExpr,edgeNestedParen,edgeNestedBrace transparent

" === JS strings with escape support ===
" Single-quoted strings (supports \')
syn region edgeJsStringSingle start="'" skip="\\'" end="'" contained
hi def link edgeJsStringSingle EdgeGreen

" Double-quoted strings (supports \")
syn region edgeJsStringDouble start='"' skip='\\"' end='"' contained
hi def link edgeJsStringDouble EdgeGreen

" Template literals (backticks with ${...})
syn region edgeJsTemplateLit start="`" skip="\\`" end="`" contained contains=edgeJsTemplateExpr
hi def link edgeJsTemplateLit EdgeGreen

" Template expressions ${...} inside backticks
syn region edgeJsTemplateExpr start="\${" end="}" contained containedin=edgeJsTemplateLit
hi def link edgeJsTemplateExpr EdgePurple

" Numbers
syn match edgeJsNumber "\<\d\+\(\.\d\+\)\?\>" contained
hi def link edgeJsNumber EdgeOrange

" Booleans and null/undefined
syn keyword edgeJsBoolean true false null undefined contained
hi def link edgeJsBoolean EdgeOrange

" Object keys (word followed by :)
syn match edgeJsKey "\<\w\+\>\s*:" contained
hi def link edgeJsKey EdgeCyan

" Operators
syn match edgeJsOperator "[=!<>]=\?\|&&\||||\|??\|=>\|+\|-\|\*\|/" contained
hi def link edgeJsOperator EdgePink

let b:current_syntax = "edge"
