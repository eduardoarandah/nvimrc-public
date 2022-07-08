" Edit Vimrc
:command! V edit $HOME/.config/nvim/init.lua
:command! Vreload source $HOME/.config/nvim/init.lua

"  Delete all registers
command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor

" Change dir to current path
command! ChangeDir :cd %:p:h<CR>

" Insert filename
command! Fname normal i <c-r>=expand('%:t:r')<cr>
command! Fnameext normal i <c-r>=expand('%:t')<cr>

"""""""""""""""""""""""""""""""""""
" Spaces
"""""""""""""""""""""""""""""""""""

" Delete blank lines
command! DeleteBlankLines g/^\s*$/d

" Replace multiple blank lines for single line
function! DoubleBlankLinesRemove(...)
  let save_pos = getpos(".")
  silent! %s/\(\n\n\)\n\+/\1/e
  nohlsearch
  call setpos('.', save_pos)
endfunction
command! DoubleBlankLinesRemove :call DoubleBlankLinesRemove()

" Replace multiple horizontal spacing to single space
function! DoubleSpacesRemove(...)
  let save_pos = getpos(".")
  silent! %s/\S\zs \+/ /e
  nohlsearch
  call setpos('.', save_pos)
endfunction
command! DoubleSpacesRemove :call DoubleSpacesRemove()

" Delete trailing white space
function! DeleteTrailingWhiteSpace(...)
    let save_pos = getpos(".")
    silent! %s/\s\+$//e
    call setpos('.', save_pos)
endfunction
command! DeleteTrailingWhiteSpace :call DeleteTrailingWhiteSpace()

" Clean bad spaces
command! SpacesClean :call DeleteTrailingWhiteSpace() | call DoubleSpacesRemove() | call DoubleBlankLinesRemove()

"""""""""""""""""""""""""""""""""""
" Utils
"""""""""""""""""""""""""""""""""""

" Insert date
command! Today normal i<c-r>=strftime("%Y-%m-%d")<CR><esc>
nnoremap gt :Today<CR>

" Underline
nnoremap <leader>- "zyy"zpVr-o<esc>
nnoremap <leader>= "zyy"zpVr=o<esc>

" Append colon and semicolon
nnoremap <leader>, A,<ESC>
nnoremap <leader>; A;<ESC>

" Open url under cursor
function! OpenURLUnderCursor()
  let s:uri = expand('<cWORD>')
  let s:uri = substitute(s:uri, '?', '\\?', '')
  let s:uri = shellescape(s:uri, 1)
  if s:uri != ''
    silent exec "!open '".s:uri."'"
    :redraw!
  endif
endfunction
nnoremap gx :call OpenURLUnderCursor()<CR>

"""""""""""""""""""""""""
" Searching
"""""""""""""""""""""""""

" Copy  all matches in document
" Strategy: execute add command on each match on each line into an array
" then join with new line \n
" g flag: repeat on each match in the line
" n report matches only, don't make any substitutions
" e no errors please
" The |submatch()| function can be used to obtain matched text.  The whole matched text can be accessed with submatch(0)
" read more
" :h substitute
" :h s_flags
" :h submatch()
command! CopyMatches let hits = [] | %substitute//\=add(hits, submatch(0))/gne | let @+ = join(hits, "\n")

"""""""""""""""""""""""""
" Format
"""""""""""""""""""""""""

function! FormatDocument()
  if(&ft == 'blade')
    SpacesClean
    % !npx blade-formatter --stdin --indent-size=2 --wrap=999
  elseif(&ft == 'sql')
    % !sqlformat --reindent --keywords upper --identifiers lower %
  elseif( &ft == 'css' || &ft == 'scss')
    " % !npx stylelint --fix --stdin-filename %
    DeleteBlankLines
    PrettierAsync
  elseif( &ft == 'markdown' || &ft  == 'vue')
    PrettierAsync
  elseif(&ft == 'lua')
    write
    " download https://github.com/JohnnyMorganz/StyLua/releases
    silent !stylua %
    edit
  else
    lua vim.lsp.buf.formatting()
  endif
endfunction

nnoremap <leader>f :call FormatDocument()<Cr>

"""""""""""""""""""""""""
" Fix
"""""""""""""""""""""""""

function! Fix()
  if(&ft == 'javascript')
    silent !npx eslint --fix %
  endif
endfunction

command! Fix :call Fix()

"""""""""""""""""""
" CSS
"""""""""""""""""""

" tc To BEM Class
nnoremap <leader>tb I&__<ESC>A{}<ESC>

fun! s:extractBem()
  " clean
  let @z=''
  " copy-append to z register
  g/__[a-z-]*/y Z
  " new file
  tabnew temp
  " paste
  normal "zP
  " substitute everthing outside capture group and add $ and {}
  %s/.*\(__[a-z-]*\).*/\&\1{}/g
  " yank all
  normal ggyG
  " no highlight
  :nohlsearch
  " exit
  bd!
  " echo
  echo 'copied to clipboard'
endfun

:command! ExtractBem :call s:extractBem()

""""""""""""""""""""""
" Extract images
""""""""""""""""""""""
command! -nargs=1 ExtractImagesFromUrl :r!curl -s <args> | grep -shoP 'http[^" ]+(jpg|png)'

""""""""""""""""""""""""""""""""""
" Markdown
""""""""""""""""""""""""""""""""""

" Search for hours
" set hlsearch
" command! SearchHours1 /\d\+\.\d\+h
:command! HoursSearch /\d*\.*\d\+h

""""""""""""""""""""""""""""""""
" Css convert to rem:
""""""""""""""""""""""""""""""""
command! Pxtorem s#\v(\d+)px#\=string(submatch(1)/16.0)."rem"
command! Pxtoremglobal %s#\v(\d+)px#\=string(submatch(1)/16.0)."rem"

""""""""""""""""""""
" CSS Dictionaries
""""""""""""""""""""

fun! DictionaryDistStylesApp()
  !grep '{' dist/styles/app.css | sed 's/\.//g; s/{//g; s/}//g; s/\\//g' | sort -u > .cssdict
  set dictionary+=.cssdict
endfun
command! DictionaryDistStylesApp :call DictionaryDistStylesApp()

"""""""""""""""
" PHP
"""""""""""""""

:command! Lararoutes 0,$d | read !php artisan route:list
:command! -nargs=1 Lararoutegrep read !php artisan route:list | grep <args>
:command! LaravelRouteResourceExplicit :normal 0iroute::WWyiwg;a"viwguea('WWWWyiWg;Pla,'WWWWWWWWyiWg;Pf)a->name('WWWWWWyiWg;Pf)a;lD
:command! CommentsHtmlToLaravel :%s/<!--\(.*\)-->/{{-- \1 --}}

function! PhpToBlade()
  s/<?php/{{/e
  s/?>/}}/e
  s/echo//e
  s/;}/}/e
  s/; }/ }/e
  s/esc_attr_e/_e/e
  s/esc_html_e/_e/e
endfunction
command! PhpToBlade :call PhpToBlade()

command! PhpVarToItemVar :norm viwoaitem['ea']

command PhpIfToBlade :norm 0f{%S@endifD0:s/<?php if/@if

"""""""""""""""
" html
"""""""""""""""

" go to class
nnoremap \c ?class<CR>2f":noh<CR>

" Lorem ipsum
command! LoremHtml :r!curl -Ns https://loripsum.net/api/10/medium/headers/decorate/link/ul/ol/bq/

" add empty tag with surround
nmap <localleader>t yslt
imap <localleader>t <esc>yslt

"""""""""""""""""""""""""
" Search on relevant directories
"""""""""""""""""""""""""

command! Clientes :Files ~/clientes
command! Colegas :Files ~/colegas
command! Conocimiento :Files ~/conocimiento
command! Proyectos :Files ~/proyectos
command! Repos :Files ~/repos
command! Scripts :Files ~/scripts


"""""""""""""""""""""""""
" Ultisnips
"""""""""""""""""""""""""

xnoremap <leader>u y:UltiSnipsEdit<cr>Go<cr>snippet key "description"<cr><esc>poendsnippet<esc>
