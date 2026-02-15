if exists("b:current_syntax")
  finish
endif

" =====================
" COMMENTS (Top Priority)
" =====================
syn match luxComment "//.*$" contains=NONE containedin=ALL
syn region luxComment start="/\*" end="\*/" contains=NONE containedin=ALL
highlight link luxComment Comment

" =====================
" PREPROCESSORS
" =====================
syn match luxPreprocessor /@\w\+/
highlight link luxPreprocessor Keyword

" =====================
" KEYWORDS & TYPES
" =====================
syn keyword luxKeyword const fn if elif else return loop let pub priv struct enum
syn keyword luxType int float bool str char nil void short long
syn keyword luxConditional if elif else
syn keyword luxLoop loop
syn keyword luxStatement return let
syn keyword luxModifier const pub priv
syn keyword luxBoolean true false

" =====================
" LITERALS
" =====================
syn match luxNumber /\<\d\+\(\.\d\+\)\?\([eE][+-]\d\+\)\?/
syn region luxString start=+"+ skip=+\\"+ end=+"+ contains=luxEscape
syn region luxString start=+'+ skip=+\\'+ end=+'+ contains=luxEscape
syn match luxEscape contained /\\[nrt\\'"]/

" =====================
" STRUCTS, ENUMS, FUNCTIONS
" =====================
syn match luxStruct /\<\(struct\|enum\)\>/
syn match luxFunction /\<fn\>\s\+\w\+\ze\s*[(]/ contains=luxFunctionName
syn match luxFunctionName /\w\+\ze\s*[(]/ contained

" =====================
" BUILT-IN FUNCTIONS
" =====================
syn keyword luxBuiltinFunction output outputln alloc free sizeof cast memcpy

" =====================
" OPERATORS
" =====================
syn match luxOperator /[+\-*/%=!<>&|]/
syn match luxOperator /[(){}\[\],;:.]/
syn match luxOperator /==/
syn match luxOperator /!=/
syn match luxOperator /<=/
syn match luxOperator />=/
syn match luxOperator /&&/
syn match luxOperator /||/
syn match luxOperator /++/
syn match luxOperator /--/

" =====================
" TYPE ANNOTATIONS
" =====================
syn match luxTypeAnnotation /:\s*\w\+/ contains=luxType

" =====================
" VARIABLES
" =====================
syn match luxVariable /\<[a-zA-Z_]\w*\>/ contains=NONE

" =====================
" COLORS (Gruvbox Palette)
" =====================
highlight link luxKeyword Keyword 
highlight link luxType Type 
highlight link luxConditional Keyword 
highlight link luxLoop Keyword 
highlight link luxStatement Keyword 
highlight link luxModifier Keyword 
highlight link luxBoolean Variable 
highlight link luxNumber Number 
highlight link luxString String 
highlight link luxEscape string.escape 
highlight link luxOperator Operator 
highlight link luxStruct Keyword 
highlight link luxFunction Keyword 
highlight link luxFunctionName function 
highlight link luxBuiltinFunction Constant
highlight link luxTypeAnnotation Type 
highlight link luxVariable Variable 
let b:current_syntax = "lux"


