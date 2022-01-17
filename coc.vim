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

