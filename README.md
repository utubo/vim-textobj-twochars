# vim-textobj-twochars

The textobj for between 2 characters.

## Example
(`||` is cursor.)
```
abXc|d|eYgh
```
You can press `v`(to visual mode) and `a2XY` to select `XcdeY`.

## Install
(vim-textobj-twochars depends on [vim-textobj-user](https://github.com/kana/vim-textobj-user).)

dein
```vimscript
call dein#add('utubo/vim-textobj-twochars')
```

## Mapping
Default is `a2` and `i2`.

Example: (Mapping to `aX` and `iX`.)
```vimscript
call textobj#user#map('twochars', {'-': {'select-a': 'aX', 'select-i': 'iX'}})
```

## Options
```
let g:textobj_twochars_select_on_cursor_line=1
```
Select on cursor line.

Example1:
```
hello world
|h|ello world
```
You can press `va2eo` to select `ello`.

Example2:
```
hello world
hello wo|r|ld
```
You can press `va2lo` to select `lo wo`.


## Note
- vim-textobj-twochars does not support a nested pair.
- When press same characters on the cursor, vim-textobj-twochars searches the tail from
  1. In the current line and after the cursor  
  2. In the current line and before the cursor  
  3. After the current line  

Exmaple1:
```
set $a = "abc|"|;
set $b = "xyz";
```
You can press `va2""` to select `"abc"`.

Exmaple2:
```
set $a = "abc"; set $b = @|"|
hello world
";
```
You can press `va2""` to select `"; set $b = @"`.


## Deprecated

Mapping `A2` and `I2` to select on the cursorline,  
and `a2` and `i2` to select on multiline mode.
```vimscript
let g:textobj_twochars_select_on_cursor_line=0
call textobj#user#plugin('twocharscursorline', {
\   '-': {
\     'select-a': 'A2',
\     'select-a-function': 'textobj#twochars#select_a_cursorline',
\     'select-i': 'I2',
\     'select-i-function': 'textobj#twochars#select_i_cursorline',
\   },
\ })
```

Mapping `a2` and `i2` to select on the cursorline,  
and `A2` and `I2` to select on multiline mode.
```vimscript
let g:textobj_twochars_select_on_cursor_line=1
call textobj#user#plugin('twocharsmultiline', {
\   '-': {
\     'select-a': 'A2',
\     'select-a-function': 'textobj#twochars#select_a_multiline',
\     'select-i': 'I2',
\     'select-i-function': 'textobj#twochars#select_i_multiline',
\   },
\ })
```

## License
Released under the [MIT license](https://opensource.org/licenses/mit-license.php).  
Copyright 2020 utubo  
