# vim-textobj-twochars

Textobj for between 2 charcters.

## Example
("|" is cursor.)
```
abXcd|efYgh
```
You can type `v`(to visual mode) and `a2XY` to select ```XcdefY```

## Install
```vimscript
call dein#add('utubo/vim-textobj-twochars')
```

## Mapping
```vimscript
call textobj#user#map('twochars', {'-': {'select-a': 'a2', 'select-i': 'i2'}})
```

## Licenses
Released under the [MIT license](https://opensource.org/licenses/mit-license.php).  
Copyright 2020 utubo  
