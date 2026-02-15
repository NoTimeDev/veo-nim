if exists("b:current_syntax")
  finish
endif

syntax keyword zrKeyword load64 load32 load16 load8 push64 push32 add32 add64 sub32 sub64 mul32 mul64 imul32 imul64 div32 div64 idiv64 idiv32 imod32 imod64 mod32 mod64 
syntax keyword zrKeyword gload64 gload32 gload16 gload8 loc glob gstore8 gstore16 gstore32 gstore64  store8 store16 store32 store64 func end call jmp struct iext itrunc ret
syntax keyword zrKeyword pop_call cmp_eq cmp_ne cmp_slt cmp_ult cmp_smt cmp_umt cmp_slte cmp_ulte jmp_if pop_jmp_if jmp pop_jmp 
syntax keyword zrKeyword gaload aload astore8 astore16 astore32 astore64 aload8 aload16 aload32 aload64 run
syntax keyword zrKeyword arr_store8 arr_store16 arr_store32 arr_store64 arr_load8 arr_load16 arr_load32 arr_load64 run
syntax keyword zrKeyword pushstr dup32 dup64
syntax keyword zrType i64 i32 i16 i8 f32 f64 ptr
syntax match zrNumber "\<\d\+\>"
syntax match zrString /".\{-}"/
syntax match zrString /'.\{-}'/
syntax match zrType "\v[a-zA-Z_.][a-zA-Z0-9_.]*:"
syntax match zrComment "#.*$"


syntax match zrIdentifier "\v[a-zA-Z_.][a-zA-Z0-9_.]*" containedin=ALLBUT,zrKeyword,zrType,zrNumber,zrString,zrComment
highlight link zrIdentifier Special 
highlight link zrKeyword Keyword
highlight link zrString String  
highlight link zrType Type
highlight link zrNumber Number
highlight link zrComment Comment

let b:current_syntax = "vl"

