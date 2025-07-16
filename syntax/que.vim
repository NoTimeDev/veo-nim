if exists("b:current_syntax")
  finish
endif

syntax keyword zrKeyword personality comdat any register catch copyto unwind callx callereg ashr extract insert match switch align cap equ pad getseptr xor not or and shr shl cast struct if icmp fcmp cmp le goto leoe gt gtoe eq ne getfptr dec private castptr loadptr getptr getadr lt localconst include any_ret alloc anyadr const start store struct end fti itf ftrunc fext to call ext iext load ret add sub mul div idiv imul mod imod trunc fadd fmul fdiv fsub extern def geteptr adr global
syntax keyword zrType ptr vardic void f32 f64 i32 i16 i64 i8 f80 string i1 
syntax match zrNumber "\<\d\+\>"
syntax match zrString /".\{-}"/
syntax match zrString /'.\{-}'/
syntax match zrDollarVar /[$@][0-9A-Za-z_@:.-]*/ 
syntax match zrType /[%][0-9A-Za-z_.:@!$-]*/ 
syntax match zrDBG /[!][0-9A-Za-z_.:@!$-]*/
syntax match zrComment "!ac.*$" 
syntax match zrDollarVar "^\s*[a-zA-Z_][a-zA-Z0-9_]*:"
syntax match zrComment "#.*$"

highlight zrDollarVar ctermfg=Blue guifg=#569CD6
highlight link zrKeyword Keyword
highlight zrString ctermfg=Green guifg=#98C379
highlight link zrType Type
highlight link zrNumber Number
highlight link zrComment Comment
highlight link zrDBG function 

let b:current_syntax = "que"

