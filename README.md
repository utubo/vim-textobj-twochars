# vim-textobj-twochars

The textobj for between 2 charcters.

## Example
(`|` is cursor.)
```
abXcd|efYgh
```
You can type `v`(to visual mode) and `a2XY` to select ```XcdefY```.

## Install
(vim-textobj-twochars depends on [vim-textobj-user](https://github.com/kana/vim-textobj-user).)

dein
```vimscript
call dein#add('utubo/vim-textobj-twochars')
```


## Mapping
```vimscript
call textobj#user#map('twochars', {'-': {'select-a': 'a2', 'select-i': 'i2'}})
```

## License
Released under the [MIT license](https://opensource.org/licenses/mit-license.php).  
Copyright 2020 utubo  
