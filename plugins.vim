" Download vim-plug if not exists
command! DownloadVimPlug !curl -fLo ~/.nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

" Create plugged dir if not exists
call mkdir($HOME."/.nvim/plugged","p")
call plug#begin('$HOME/.nvim/plugged')

" Syntax
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'sheerun/vim-polyglot'

if(!has('nvim'))
" Highlight yank 
Plug 'machakann/vim-highlightedyank'
endif

" Theme
set background=dark
Plug 'Mofiqul/dracula.nvim'

" if terminal has 256 colors
if !has("gui_running")
  let g:rehash256 = 1
endif

" search with * escaping special chars
Plug 'nelstrom/vim-visual-star-search'

" Status/tabline
Plug 'vim-airline/vim-airline'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t' " Show just the filename
let g:airline#extensions#tabline#ignore_bufadd_pat = 'defx|gundo|nerd_tree|startify|tagbar|undotree|vimfiler' " Show terminal buffers

" File explorer
Plug 'scrooloose/nerdtree', { 'on': [ 'NERDTreeToggle', 'NERDTreeFind', 'NERDTreeCWD', 'NERDTree' ] }
let NERDTreeShowHidden=1 
nnoremap <F7> :NERDTreeToggle<CR>
nnoremap <F8> :NERDTreeFind<CR>

" Change current dir to current file
nnoremap <leader>cd :cd %:p:h<CR>:NERDTreeCWD<CR>

" Comment lines
" https://github.com/numToStr/Comment.nvim
Plug 'numToStr/Comment.nvim'

" FZF Fuzzy Finder 
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

if executable('rg')
  " Use RipGrep to list files for fzf, include dotfiles in current directory
  let $FZF_DEFAULT_COMMAND='{ rg --files; find . -type f -name ".*" -depth 1 }'
else
  " Open GIT files if is a git repo, otherwise, just list files
  nnoremap <expr> <C-p> (len(system('git rev-parse')) ? ':Files' : ':GFiles --exclude-standard --others --cached')."\<cr>"
endif

" Files
nnoremap <C-p> :Files<CR>

function! ChangeFZFDir()
  let g:dir=expand('%:h')
  nnoremap <C-p> :Files <c-r>=g:dir<CR><CR>
  echo 'FZF files dir changed to: '. g:dir 
endfunction

nnoremap <leader>cz :call ChangeFZFDir()<CR>

" Change working directory to frequently used ones registered in z command 
" requires: https://github.com/rupa/z
let jumpPath = '{ cat ~/.z \| cut -d"\|" -f1; find ~/proyectos/ -type d -maxdepth 1 ; find ~/clientes/ -type d -maxdepth 1 }'
nnoremap <F6> :call fzf#run({'source': jumpPath, 'sink': 'JumpDir'})<cr>

" History files
noremap <leader>hi :History<CR>

" Commands History
nnoremap <leader>: :History:<CR>

" All lines in all buffers
nnoremap <leader>j :Lines<CR>

" Find buffer
nnoremap <C-f> :Buffers<CR>

" Allow repeating for plugin mappings like surround
Plug 'tpope/vim-repeat'

" Surround with ys
Plug 'tpope/vim-surround'

" Git
Plug 'tpope/vim-fugitive'
nnoremap <leader>gs :Git<cr>
nnoremap <leader>ga :Git add %<cr>
nnoremap <leader>gr :Gread<cr>
nnoremap <leader>gl :Git log --name-only<cr>
nnoremap <leader>gA :Git add -A<cr>
nnoremap <leader>gco :Git checkout<space>
nnoremap <leader>gcb :Git checkout -b<space>
nnoremap <leader>gp :Git push<cr>

" git diff (:Gdiffsplit! for merge conflicts)
nnoremap <leader>gd :Gdiffsplit<cr>

" git merge left-right
nnoremap <leader>mh :diffget //2<cr>
nnoremap <leader>ml :diffget //3<cr>

" All commits
command! Ghistory :Gclog

" Commits for current file
command! Ghistoryfile :0Gclog!

" Shows a git diff in the sign column. 
Plug 'mhinz/vim-signify'

" Maximizes and restores the current window in Vim. 
Plug 'szw/vim-maximizer'
nnoremap <leader>z :MaximizerToggle<CR>
xnoremap <leader>z :MaximizerToggle<CR>gv

" Auto close brackets
Plug 'jiangmiao/auto-pairs' 
let g:AutoPairsShortcutToggle=''
let g:AutoPairsMapCh=0 " don't map this one

" Search with ripgrep :Rg
Plug 'jremmen/vim-ripgrep'
let g:rg_command='rg --vimgrep --pcre2 --type-add="scss:*.scss"'

" Sessions
Plug 'xolox/vim-misc' "requirement
Plug 'romgrk/vim-session' 
let g:session_autoload = 'no'
let g:session_autosave = 'yes'
let g:session_directory = $HOME."/.nvim/sessions"
let g:session_extension = ''

" Create dir if not exists
call mkdir($HOME."/.nvim/sessions","p")

" Open session (project)
nnoremap <leader>s :OpenSession<space>

" Useful commands
Plug 'tpope/vim-eunuch' 
" :Delete: Delete a buffer and the file on disk simultaneously.
" :Unlink: Like :Delete, but keeps the now empty buffer.
" :Move: Rename a buffer and the file on disk simultaneously.
" :Rename: Like :Move, but relative to the current file's containing directory.
" :Chmod: Change the permissions of the current file.
" :Mkdir: Create a directory, defaulting to the parent of the current file.
" :Cfind: Run find and load the results into the quickfix list.
" :Clocate: Run locate and load the results into the quickfix list.
" :Lfind/:Llocate: Like above, but use the location list.
" :Wall: Write every open window. Handy for kicking off tools like guard.
" :SudoWrite: Write a privileged file with sudo.
" :SudoEdit: Edit a privileged file with sudo.
" File type detection for sudo -e is based on original file name.
" New files created with a shebang line are automatically made executable.
" New init scripts are automatically prepopulated with /etc/init.d/skeleton.

" Calculate simple formulas
Plug 'sk1418/HowMuch' 
let g:HowMuch_scale = 8 
nmap <leader>hm V<Plug>AutoCalcAppendWithEq
vmap <leader>hm <Plug>AutoCalcAppendWithEq
vmap <leader>hms <Plug>AutoCalcAppendWithEqAndSum
vmap <leader>hmr <Plug>AutoCalcReplace

" Align in | with :Tabularize /|
Plug 'godlygeek/tabular'

" Display markers
Plug 'kshenoy/vim-signature'

" Css Color
Plug 'ap/vim-css-color', { 'for': [ 'css', 'scss' ] }

" Change case (casing)
Plug 'arthurxavierx/vim-caser' 
" let g:caser_no_mappings = 1
" let g:caser_prefix = 'gs'
" p PascalCase
" c camelCase
" _ snake_case
" U UPPER_CASE
" t Title Case
" s Sentence case
" <space> space case
" - dash-case
" K Title-Dash-Case
" . dot.case

" Visual select and change case
function! Case()
   let l:myMakeTargets = ["", "gsc", "gs-", "gsp", "gs_", "gsU", "gst", "gss", "gs\<space>", "gsKse", "gs."]
   let l:c=0
   let l:c = confirm("Change case","&c camelCase\n&d dash-case\n&p PascalCase\n&_ snake_case\n&u UPPER_CASE\n&t Title Case\n&s Sentence case\n&a space case\n&k Title-Dash-Case\n&. dot.case")
   if l:c != 0
         exec "norm gv" . l:myMakeTargets[l:c]
   endif
endfunction
command! -range Case :call Case()
xnoremap <leader>c :call Case()<cr>

" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  } 

" Prettier
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html', 'php'] } 
let g:prettier#exec_cmd_path = "/usr/local/bin/prettier"

" REPL, send commands to another window
Plug 'jpalardy/vim-slime'
let g:slime_target = "tmux"

" target_pane  
" {last} current window, last pane, 
" :.2 current window, second pane
" %pane_id get it with echo $TMUX_PANE
let g:slime_default_config = {"socket_name": get(split($TMUX, ","), 0), "target_pane": "{last}"}
let g:slime_no_mappings = 1
xmap <F9> <Plug>SlimeRegionSend
nmap <F9> <Plug>SlimeParagraphSend

" editorconfig respect .editorconfig settings like indenting
Plug 'editorconfig/editorconfig-vim'

" lua format
Plug 'andrejlevkovitch/vim-lua-format'

" typescript
Plug 'jose-elias-alvarez/typescript.nvim'

" Completion
Plug 'hrsh7th/nvim-cmp' " A completion engine plugin for neovim written in Lua.
Plug 'neovim/nvim-lspconfig' " A collection of common configurations for Neovim's built-in language server client.
Plug 'williamboman/nvim-lsp-installer' " Allows you to seamlessly install LSP servers locally

" Completion sources
Plug 'hrsh7th/cmp-nvim-lsp' " nvim-cmp source for neovim's built-in language server client.
Plug 'hrsh7th/cmp-buffer' " nvim-cmp source for buffer words.
Plug 'hrsh7th/cmp-path' " nvim-cmp source for filesystem paths.
Plug 'hrsh7th/cmp-cmdline' " nvim-cmp source for vim's cmdline.
Plug 'hrsh7th/cmp-nvim-lua' " nvim-cmp source for neovim Lua API.
Plug 'uga-rosa/cmp-dictionary' " https://github.com/uga-rosa/cmp-dictionary

" Snippets ultisnips users.
Plug 'SirVer/ultisnips' " UltiSnips is the ultimate solution for snippets in Vim
Plug 'quangnguyen30192/cmp-nvim-ultisnips' " UltiSnips completion source for nvim-cmp
nnoremap <leader>u :UltiSnipsEdit<cr>

" fix things in quickfix list
Plug 'stefandtw/quickfix-reflector.vim'

call plug#end()

" Completion
set completeopt=menu,menuone,noselect

" After loading plugins
colorscheme dracula

" Lua plugins
lua require('Comment').setup()

