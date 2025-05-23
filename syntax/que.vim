if exists("b:current_syntax")
  finish
endif

syntax keyword zrKeyword equ pad getseptr xor not or and shr shl cast struct if icmp fcmp cmp le goto leoe gt gtoe eq ne getfptr dec private castptr loadptr getptr getadr localconst include any_ret alloc anyadr const start store struct end fti itf ftrunc fext to call ext iext load ret add sub mul div idiv imul mod imod trunc fadd fmul fdiv fsub extern def geteptr adr global
syntax keyword zrType ptr void f32 f64 i32 i16 i64 i8 string i1 
syntax match zrComment "#.*$"
syntax match zrNumber "\<\d\+\>"
syntax match zrString /".\{-}"/
syntax match zrString /'.\{-}'/
syntax match zrDollarVar /[%!$@?][0-9A-Za-z_.+:><-]*/
syntax match zrComment "!ac.*$"

highlight zrDollarVar ctermfg=Blue guifg=#569CD6
highlight link zrKeyword Keyword
highlight zrString ctermfg=Green guifg=#98C379
highlight link zrType Type
highlight link zrNumber Number
highlight link zrComment Comment

let b:current_syntax = "que"

