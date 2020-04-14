let s:save_cpo = &cpo
set cpo&vim

function! s:input(text)
  let l:c = nr2char(getchar())
  if l:c !~ '[[:print:]]'
    return ''
  endif
  echon printf(a:text, l:c)
  let l:expr = l:c == '\' ? '\\' : ('\V' . l:c)
  return l:expr
endfunction

function! s:msg(text)
  redraw | echo a:text
  return 0
endfunction

function! s:is_reversed(head, tail)
  return a:tail[1] < a:head[1] || a:tail[1] == a:head[1] && a:tail[2] < a:head[2]
endfunction

function! s:select(is_inner, cursorline)
  echoh Question | echo 'Input 2 chars: ' | echoh None
  let l:org = getpos('.')
  let l:stopline = a:cursorline ? l:org[1] : 0

  " input the head
  let l:head_expr = s:input('Between "%s" and ')
  if l:head_expr ==? ''
    return s:msg('Canceled.')
  endif
  " search the head
  if !search(l:head_expr, 'bcW', l:stopline) &&
   \ (!l:stopline || !search(l:head_expr, 'c', l:stopline))
    return s:msg('Not found.')
  endif
  let l:head = getpos('.')

  " input the tail
  let l:expr = s:input('"%s"')
  if l:expr ==? ''
    return s:msg('Canceled.')
  endif
  " search the tail
  call setpos('.', l:org)
  if l:head_expr ==? l:expr && l:head == l:org
    if !search(l:expr, 'W',  l:org[1]) &&
     \ !search(l:expr, 'bW', l:stopline) &&
     \ (l:stopline || !search(l:expr, 'W')) &&
     \ (l:stopline || !search(l:expr, 'bW'))
        return s:msg('Not found.')
    endif
    let l:tail = getpos('.')
  elseif l:stopline
    if !search(l:expr, 'c', l:stopline) && !search(l:expr, 'bc', l:stopline)
      return s:msg('Not found.')
    endif
    let l:tail = getpos('.')
    if l:tail[2] == l:head[2]
      if !search(l:head_expr, l:head[2] < l:org[2] ? 'b' : '', l:stopline)
        return s:msg('Not found.')
      endif
      let l:head = getpos('.')
    endif
  else
    if !search(l:expr, 'c')
      return s:msg('Not found.')
    endif
    let l:tail = getpos('.')
  endif

  if a:is_inner
    if s:is_reversed(l:head, l:tail)
      let [l:head, l:tail] = [l:tail, l:head]
    endif
    call setpos('.', l:head)
    normal! l
    if getpos('.')[2] == l:head[2]
      normal! j0
    endif
    let l:head = getpos('.')
    call setpos('.', l:tail)
    normal! h
    if getpos('.')[2] == l:tail[2]
      normal! k$
    endif
    let l:tail = getpos('.')
    if s:is_reversed(l:head, l:tail)
      " it's empty.
      return 0
    endif
  endif

  return ['v', l:head, l:tail]
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

