if exists('g:loaded_textobj_twochars')
  finish
endif
let g:loaded_textobj_twochars = 1

let s:save_cpo = &cpo
set cpo&vim

call textobj#user#plugin('twochars', {
\   '-': {
\     'select-a': 'a2',
\     'select-a-function': 'textobj#twochars#select_a',
\     'select-i': 'i2',
\     'select-i-function': 'textobj#twochars#select_i',
\   },
\ })

let &cpo = s:save_cpo
unlet s:save_cpo

