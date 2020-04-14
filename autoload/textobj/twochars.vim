let s:save_cpo = &cpo
set cpo&vim

function! s:input()
  let l:c = nr2char(getchar())
  if l:c !~ '[[:print:]]'
    return ['', '']
  endif
  let l:expr = l:c == '\' ? '\\' : ('\V' . l:c)
  return [l:c, l:expr]
endfunction

function! s:msg(text)
  redraw | echo a:text
  return 0
endfunction

function! s:select(is_inner, cursorline)
  echoh Question | echo 'Input 2 chars: ' | echoh None
  let l:org = getpos('.')
  let l:stopline = a:cursorline ? l:org[1] : 0

  " input the head
  let [l:head, l:head_expr] = s:input()
  if l:head == ''
    return s:msg('Canceled.')
  endif
  redraw | echo 'Between "' . l:head . '" and '
  " search the head
  if !search(l:head_expr, 'bcW', l:stopline) &&
   \ l:stopline && !search(l:head_expr, 'c', l:stopline)
    return s:msg('Not found.')
  endif
  let l:head_pos = getpos('.')

  " input the tail
  let [l:tail, l:expr] = s:input()
  if l:tail == ''
    return s:msg('Canceled.')
  endif
  echon '"' . l:tail .'"'
  " search the tail
  call setpos('.', l:org)
  if l:head == l:tail && l:head_pos == l:org
    if !search(l:expr, 'W',  l:org[1]) &&
     \ !search(l:expr, 'bW', l:stopline) &&
     \ !l:stopline && !search(l:expr, 'W') &&
     \ !l:stopline && !search(l:expr, 'bW')
        return s:msg('Not found.')
    endif
    let l:tail_pos = getpos('.')
  else
    call setpos('.', l:org)
    if !search(l:expr, 'c', l:stopline) &&
     \ l:stopline && !search(l:expr, 'b', l:stopline)
      return s:msg('Not found.')
    endif
    let l:tail_pos = getpos('.')
    if l:stopline && l:tail_pos[2] < l:head_pos[2]
      if !search(l:head_expr, 'b', l:stopline)
        return s:msg('Not found.')
      endif
      let l:head_pos = getpos('.')
    endif
  endif

  if a:is_inner
    normal! h
    let l:tail_pos = getpos('.')
    call setpos('.', l:head_pos)
    normal! l
    let l:head_pos = getpos('.')
  endif

  return ['v', l:head_pos, l:tail_pos]
endfunction

function! textobj#twochars#select_a()
  return s:select(0, get(g:, 'textobj_twochars_select_on_cursor_line', 0))
endfunction

function! textobj#twochars#select_i()
  return s:select(1, get(g:, 'textobj_twochars_select_on_cursor_line', 0))
endfunction

function! textobj#twochars#select_a_multiline()
  return s:select(0, 0)
endfunction

function! textobj#twochars#select_i_multiline()
  return s:select(1, 0)
endfunction

function! textobj#twochars#select_a_cursorline()
  return s:select(0, 1)
endfunction

function! textobj#twochars#select_i_cursorline()
  return s:select(1, 1)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

