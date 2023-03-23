# Progressive vim

The strategy is: start with backwards/vim-compatible settings, then progress into neovim modernity

## How it works

Check `init.vim`

```vimscript
" Settings and mappings, this file is compatible with old vim installations
source basic.vim

" Add some custom commands
source commands.vim

" Now move to lua. Add custom commands in lua
lua require("commands")

" Add plugin manager (Lazy), Download if not exists
" https://github.com/folke/lazy.nvim
let lazypath=stdpath('data')."/lazy/lazy.nvim"
if !isdirectory(lazypath)
  echo "Installing plugin manager lazy.nvim..."
  call system(['git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', '--branch=stable', lazypath])
  echo "Done! add some plugins to lua/plugins/ read more: https://github.com/folke/lazy.nvim#-structuring-your-plugins"
endif

" Add lazy to runtimepath
let &rtp = lazypath . ',' . &rtp

" Load plugins in plugins folder
lua require("lazy").setup("plugins")
```
