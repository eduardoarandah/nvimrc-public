" Download vim-plug if not exists
command! DownloadVimPlug !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

" Create plugged dir if not exists
call mkdir($HOME."/.vim/plugged","p")
call plug#begin('$HOME/.vim/plugged')

" Syntax
Plug 'sheerun/vim-polyglot'

" Theme
Plug 'tomasr/molokai' 

" Color
set background=dark
set termguicolors

" if terminal has 256 colors
if !has("gui_running")
  let g:rehash256 = 1
endif

" Comments
Plug 'tpope/vim-commentary'

" Better repeating
Plug 'tpope/vim-repeat'

" surround with ys
Plug 'tpope/vim-surround'

" Create html tag
nmap <localleader>t yslt
imap <localleader>t <C-o>yslt

" Git fugitive 
Plug 'tpope/vim-fugitive'
nnoremap <leader>gs :Git<cr>
nnoremap <leader>ga :Git add %<cr>
nnoremap <leader>gA :Git add -A<cr>
nnoremap <leader>gl :Git log<cr>
nnoremap <leader>gp :Git push<cr> 
command! Gammend :Git commit --amend

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
vnoremap <leader>z :MaximizerToggle<CR>gv

" NerdTree
Plug 'scrooloose/nerdtree', { 'on': [ 'NERDTreeToggle', 'NERDTreeFind', 'NERDTreeCWD', 'NERDTree' ] }
let NERDTreeShowHidden=1 
nnoremap <F7> :NERDTreeToggle<CR>
nnoremap <F8> :NERDTreeFind<CR>

" Change current dir to current file
nnoremap <leader>cd :cd %:p:h<CR>:NERDTreeCWD<CR>

" Auto close brackets
Plug 'jiangmiao/auto-pairs' 
let g:AutoPairsShortcutToggle=''
let g:AutoPairsMapCh=0 " don't map this one

" RipGrep :Rg
Plug 'jremmen/vim-ripgrep'
let g:rg_command='rg --vimgrep --pcre2'

" Sessions
Plug 'xolox/vim-misc' "requirement
Plug 'romgrk/vim-session' 
let g:session_autoload = 'no'
let g:session_autosave = 'yes'
let g:session_directory = $HOME."/.vim/sessions"
let g:session_extension = ''

" Create dir if not exists
call mkdir($HOME."/.vim/sessions","p")

" Open session (project)
nnoremap <leader>s :OpenSession 

" Highlight yank 
Plug 'machakann/vim-highlightedyank'

" Status/tabline
Plug 'vim-airline/vim-airline'

let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" Show terminal buffers
let g:airline#extensions#tabline#ignore_bufadd_pat = 'defx|gundo|nerd_tree|startify|tagbar|undotree|vimfiler'

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

" History files
noremap <leader>hi :History<CR>

" Commands History
nnoremap <leader>: :History:<CR>

" All lines in all buffers
nnoremap <leader>j :Lines<CR>

" Find buffer
nnoremap <C-f> :Buffers<CR>

" Z plugin integration
" jump around recent directories
" https://github.com/rupa/z
nnoremap <localleader>z :call fzf#run({'source': 'cat ~/.z \| cut -d"\|" -f1', 'sink':'e'})<cr>

" Align in | with :Tabularize /|
Plug 'godlygeek/tabular'

" Display markers "
Plug 'kshenoy/vim-signature'

" Css Color
Plug 'ap/vim-css-color', { 'for': [ 'css', 'scss' ] }

" Change case (casing)
Plug 'arthurxavierx/vim-caser' 
" gsp PascalCase
" gsc camelCase
" gs_ snake_case
" gsU UPPER_CASE
" gst Title Case
" gss Sentence case
" gs<space> space case
" gs- dash-case
" gsK Title-Dash-Case
" gs. dot.case

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

" lua format
Plug 'andrejlevkovitch/vim-lua-format'

""""""""""""""""""""""""""""""""""""""""""" 
" CoC Code Completion
" https://github.com/neoclide/coc.nvim 
"""""""""""""""""""""""""""""""""""""""""" 

Plug 'neoclide/coc.nvim', {'branch': 'release'}

let g:coc_filetype_map = { 'blade.php': 'blade', }

" Install if not installed
let g:coc_global_extensions = [
      \ 'coc-css',
      \ 'coc-dictionary',
      \ 'coc-eslint',
      \ 'coc-html',
      \ 'coc-json',
      \ 'coc-phpls',
      \ 'coc-python',
      \ 'coc-snippets',
      \ 'coc-sql',
      \ 'coc-stylelint',
      \ 'coc-sumneko-lua',
      \ 'coc-tag',
      \ 'coc-tsserver',
      \ 'coc-vetur',
      \ 'coc-yaml',
      \ ]

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time diagnostics appear/become resolved.
set signcolumn=yes

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction

let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Use <c-space> to trigger completion.
inoremap <silent><expr> <localleader><localleader> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" navigate diagnostics `[g` and `]g` 
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> <localleader>d <Plug>(coc-definition)
nmap <silent> <localleader>e <Plug>(coc-references)
nmap <silent> <localleader>y <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

augroup cursor
  autocmd!
  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent call CocActionAsync('highlight')
augroup END

" Symbol rename
nmap <localleader>r <Plug>(coc-rename)

" Global search
noremap <localleader>s yiw:CocSearch <C-r>"<CR>
vnoremap <localleader>s y<esc>:CocSearch <C-r>"<CR>

" Range format like <leader>fip
vmap <localleader>f <Plug>(coc-format-selected)
nmap <localleader>f <Plug>(coc-format-selected)

" augroup mygroup
" autocmd!
  " Setup formatexpr specified filetype(s).
  " autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  " autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
" augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <localleader>a <Plug>(coc-codeaction-selected)<cr>
nmap <localleader>a <Plug>(coc-codeaction-selected)<cr>

" Remap keys for applying codeAction to the current line.
" nmap <leader>ac <Plug>(coc-codeaction)
" " Apply AutoFix to problem on the current line.
nnoremap <localleader>x <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
" xmap if <Plug>(coc-funcobj-i)
" xmap af <Plug>(coc-funcobj-a)
" omap if <Plug>(coc-funcobj-i)
" omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
" nnoremap <silent> <space>a :<C-u>CocList diagnostics<cr>
" Manage extensions.
" nnoremap <silent> <space>e :<C-u>CocList extensions<cr>
" Show commands.
" nnoremap <silent> <space>c :<C-u>CocList commands<cr>
" Find symbol of current document.
" nnoremap <silent> <space>o :<C-u>CocList outline<cr>
" Search workspace symbols.
" nnoremap <silent> <space>s :<C-u>CocList -I symbols<cr>
" Do default action for next item.
" nnoremap <silent> <space>j :<C-u>CocNext<CR>
" Do default action for previous item.
" nnoremap <silent> <space>k :<C-u>CocPrev<CR>
" Resume latest coc list.
" nnoremap <silent> <space>p :<C-u>CocListResume<CR>
"

""""""""""""""""""""""""""""
" Coc snippets
" https://github.com/neoclide/coc-snippets
""""""""""""""""""""""""""""

" Use <C-l> for trigger snippet expand.
" imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
" vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-n>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-p>'

" Use <C-j> for both expand and jump (make expand higher priority.)
" imap <C-j> <Plug>(coc-snippets-expand-jump)

" Edit snippets
nnoremap <leader>u :CocCommand snippets.editSnippets<CR>

" Add to CocConfig
" {
" 'snippets': {
" 'userSnippetsDirectory': '~/scripts/vim/ultisnips'
" },
" 'languageserver': {
" 'intelephense': {
" 'command': 'intelephense',
" 'args': ['--stdio'],
" 'filetypes': ['php'],
" 'initializationOptions': {
" 'storagePath': '/tmp/intelephense'
" }
" }
" },
" 'stylelint.enable': true,
" 'stylelint.config': '~/.stylelint'
" }
" 

call plug#end()

" After loading plugins
colorscheme molokai

" Better cursor highlighting
" hi Search cterm=NONE ctermfg=255 guifg=#eeeeee ctermbg=88 guibg=#870000

" treesitter enable
" if (has("nvim"))
" lua <<EOF
" require'nvim-treesitter.configs'.setup {
"   ensure_installed ={ "javascript", "json", "css", "php", "html", "python", "bash", "regex", "ruby", "yaml", "jsonc", "tsx", "lua", "vue" }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
"   highlight = {
"     enable = true,
"     disable = { "php" },  -- list of language that will be disabled
"   },
"   indent = {
"     enable = false
"   },
"   context_commentstring = {
"     enable = true
"   }
" }
" EOF
" endif

" disable = { "php" },  -- list of language that will be disabled
" context_commentstring = {
    " enable = true,
    " config = {
    " php = {
    "   element = "XXXX %s ",
    "   start_tag = "YYYYYYY %s zzz",
    "   attribute = "ZZZZZZz %s zzz",
    "   html = "111111 %s zzz"
    " }
    " }
  " },
  " playground = {
    " enable = true,
    " disable = {},
    " updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    " persist_queries = false, -- Whether the query persists across vim sessions
    " keybindings = {
    "   toggle_query_editor = 'o',
    "   toggle_hl_groups = 'i',
    "   toggle_injected_languages = 't',
    "   toggle_anonymous_nodes = 'a',
    "   toggle_language_display = 'I',
    "   focus_language = 'f',
    "   unfocus_language = 'F',
    "   update = 'R',
    "   goto_node = '<cr>',
    "   show_help = '?',
    " },
  " }
