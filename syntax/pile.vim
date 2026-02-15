if exists("b:current_syntax")
  finish
endif

syntax keyword pileKeyword func asm include do end struct if while defer mem elif then extern else  
syntax keyword pileType ptr f32 f64 i32 i16 i64 i8 
syntax match pileNumber "\<\d\+\>"
syntax match pileMacro /[@][0-9A-Za-z_.:@!$-]*/
syntax match pileString /".\{-}"/
syntax match pileString /'.\{-}'/
syntax match pileOperator /[+\-*/%&=<>==|<=|>=]/
syntax match pileMacro "!"
syntax match pileComment "#.*$"
syntax match pileSeps /[()<>]/

highlight link pileKeyword Keyword
highlight link pileString String 
highlight link pileType Type
highlight link pileNumber Number
highlight link pileComment Comment
highlight link pileMacro function 
highlight link pileOperator Operator
highlight link pileSeps Delimiter

let b:current_syntax = "pile"

