let s:save_cpo = &cpo
set cpo&vim

function! s:select(is_inner)
  echoh Question | echo 'Input 2 chars: ' | echoh None
  let l:org = getpos('.')
  let l:pos = [0, 0]
  for l:i in [0, 1]
    let l:c = nr2char(getchar())
    if l:c !~ '[[:print:]]'
      redraw | echo "Canceled."
      return 0
    endif
    if !search(l:c == '\' ? '\\' : ('\V' . l:c), l:i ? 'W' : 'bW')
      redraw | echo "Not found."
      return 0
    endif
    if l:i
      echon '"' . l:c .'"'
      if a:is_inner
        normal! h
      endif
    else
      redraw | echo 'Between "' . l:c . '" and '
      if a:is_inner
        normal! l
      endif
    endif
    let l:pos[l:i] = getpos('.')
    call setpos('.', l:org)
  endfor
  return ['v', l:pos[0], l:pos[1]]
endfunction

function! textobj#twochars#select_a()
  return s:select(0)
endfunction

function! textobj#twochars#select_i()
  return s:select(1)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

