""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Progressive strategy:
"
" Start backwards compatible. Something to copy/paste in old vim
" Then add layers of modern stuff on top
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" settings + mappings. vim-compatible
source basic.vim

" custom commands
source commands.vim

" custom commands in lua
lua require("commands")

""""""""""""""""""""""""""""""""""""""""""
" Plugin manager
" https://github.com/folke/lazy.nvim
""""""""""""""""""""""""""""""""""""""""""

" download if not exists
let lazypath=stdpath('data')."/lazy/lazy.nvim"
if !isdirectory(lazypath)
  echo "Installing plugin manager lazy.nvim..."
  call system(['git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', '--branch=stable', lazypath])
  echo "Done! add some plugins to lua/plugins/ read more: https://github.com/folke/lazy.nvim#-structuring-your-plugins"
endif

" add lazy to runtimepath
let &rtp = lazypath . ',' . &rtp

" load plugins in plugins folder
lua require("lazy").setup("plugins")

" temporary commands
lua require("per_project")

