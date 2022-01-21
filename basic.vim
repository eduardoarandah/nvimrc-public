" Update:
" PlugUpgrade 
" PlugUpdate
" CocUpdate
" TSUpdate

""""""""""""""""
" Basic settings
""""""""""""""""

scriptencoding utf-8 " basic
set nocompatible " basic
filetype off " basic
filetype plugin on " Enable filetype plugins
filetype indent on " Enable loading the indent file for specific file types
syntax enable " Enable syntax highlighting
set redrawtime=2000 " After this milliseconds, stop processing syntax
set maxmempattern=1000000 " Max memory for syntax in Kb
set encoding=utf-8 " Encoding (needed in youcompleteme)
set fileencoding=utf-8 " The encoding written to file.
set noerrorbells " No annoying sound on errors
set number " Line numbers on
set hidden " Allow buffer switching without saving
set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
set lazyredraw " Don't redraw while executing macros (good performance config)
set magic " For regular expressions turn magic on
set showmatch " Show matching brackets/parenthesis
set mat=2 " How many tenths of a second to blink when matching brackets
set autoread " Detect changes
set t_vb= " Flashing screen is annoying
set ruler " Always show current position
set cmdheight=1 " Height of the command bar
set showcmd " Show command in status bar
set formatoptions=tcqj " Format options, each letter means something
set history=10000 " Sets how many lines of history VIM has to remember
set so=5 " Set 7 lines to the cursor - when moving vertically using j/k
set backspace=indent,eol,start " fix: backspace past start of operation
set linespace=0 " No extra spaces between rows
set whichwrap=b,s,h,l,<,>,[,] " Backspace and cursor keys wrap too
set ff=unix " Use Unix as the standard file type
set ffs=unix,dos,mac " This gives the end-of-line (<EOL>) formats that will be tried
set virtualedit=block " If you need to define a block in visual block mode with bounds outside the actual text (that is, past the end of lines), you can allow this with:
set relativenumber " Use relative numbers instead of absolute
set wrap! " Don't wrap long lines
set background=dark " Dark
set autoindent " Auto indent
set shiftwidth=2 " Use indents of 2 spaces
set expandtab " Tabs are spaces, not tabs
set tabstop=2 " An indentation every four columns
set softtabstop=2 " Let backspace delete indent
set ai " Auto indent
set si " Smart indent
set nojoinspaces " Prevents inserting two spaces after punctuation on a join (J)
set switchbuf=useopen,usetab " Specify the behavior when switching between buffers
set hlsearch " Highlight search results
set incsearch " Makes search act like search in modern browsers
" set ignorecase " Ignore case when searching
" set smartcase " When searching try to be smart about cases
set gdefault " Add g (global) to substitute operations, :s/pattern/replacement/
set splitbelow " Open split below
set splitright " Open split right
set listchars=trail:-
set mouse=a " Mouse support in all modes
set undofile

" Wildmenu
set wildmenu " Show list instead of just completing
set wildignore=*.o,*~,*.pyc " Ignore compiled files
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
set wildcharm=<tab>

" Directories. Separate vim and neovim to avoid conflicts on format
if(has('nvim'))
  call mkdir($HOME."/.vim/nvimtmp","p") " Create dir if not exists
  set runtimepath^=~/.vim runtimepath+=~/.vim/after
  let &packpath = &runtimepath
  set backupdir=$HOME/.vim/nvimtmp//
  set directory=$HOME/.vim/nvimtmp//
  set undodir=$HOME/.vim/nvimtmp//
  command! Tmpfilesremove !rm ~/.vim/nvimtmp/*
else
  call mkdir($HOME."/.vim/tmp","p") " Create dir if not exists
  set runtimepath^=~/.vim runtimepath+=~/.vim/after
  set backupdir=$HOME/.vim/tmp//
  set directory=$HOME/.vim/tmp//
  set undodir=$HOME/.vim/tmp//
  command! Tmpfilesremove !rm ~/.vim/tmp/*
endif

" Leader Key
let mapleader=" "
let maplocalleader = "\\"

""""""""""
" Movement
""""""""""

" Lines
nnoremap <C-l> g_
vnoremap <C-l> g_
nnoremap <C-h> ^
vnoremap <C-h> ^

" Buffers
nnoremap <C-j> :bn<CR>
nnoremap <C-k> :bp<CR>

" Alternate buffer
nnoremap <leader>k :b#<CR>

" Tabs
nnoremap <leader>tt :tabnew<CR>
nnoremap <leader>tc :tabclose<CR>
nnoremap ) :tabnext<CR>
nnoremap ( :tabprevious<CR>

" Go to end of page and center
nnoremap G Gzz

" Add movement to jumplist when using relative numbers
nnoremap <expr> k (v:count > 2 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 2 ? "m'" . v:count : "") . 'j'

" Scroll viewport faster: >
nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>

"""""""""
" Buffers
"""""""""

" close buffer
nnoremap <leader>q :bd<CR>

" close unsaved buffer, no save
nnoremap <leader>Q :bd!<CR>

" just die please
nnoremap <leader>gq :qa!<CR>

" write
nnoremap <leader>w :w!<CR>

" close all buffers
nnoremap <leader>bd :%bd<CR>

" keep current window only
nnoremap <leader>o :only<CR>

""""""""
" Splits
""""""""

nnoremap <leader><up> :resize -10<CR>
nnoremap <leader><down> :resize +10<CR>
nnoremap <leader><left> :vertical resize -10<CR>
nnoremap <leader><right> :vertical resize +10<CR>

""""""""""""""""""
" Visual Shortcuts
""""""""""""""""""

" Visual line
nnoremap <leader>l _vg_

" Visual document
nnoremap <leader>a ggVG

" Move lines in visual mode
vnoremap N :m '>+1<CR>gv=gv
vnoremap P :m '<-2<CR>gv=gv

" J K just move
vnoremap J j
vnoremap K k

"""""""""""
" Quick fix
"""""""""""

nnoremap [c :cprevious<cr>
nnoremap ]c :cnext<cr>
nnoremap <leader>co :copen<CR>;
nnoremap <leader>cc :cclose<CR>;

""""""""
" Macros
""""""""

" Execute macro q
nnoremap Q @q

" Execute macro q on visual selection
vnoremap Q :normal @q<CR>

"""""""""""""""""""""""
" Clipboard / registers
"""""""""""""""""""""""

" Copy text to the end of line, behave like C D
nnoremap Y y$

" Fix issues when pasting a lot of code
nnoremap F2 :set pastetoggle<CR>

" ALWAYS use the clipboard for ALL operations 
set clipboard+=unnamedplus,unnamed

" Don't lose clipboard when pasting
vnoremap p pgvy

" delete/change without changing clipboard
nnoremap <leader>x "_x
nnoremap <leader>d "_d
nnoremap <leader>c "_c

" Delete all registers
command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor

if (has("nvim")) 
  " Fixes copying special chars
  lang en_US 
endif

""""""""""""""""
" Search replace
""""""""""""""""

" Clear search
nnoremap <silent> <leader><Esc> :let @/=""<cr>

" No highlight search
nnoremap <leader>/ :nohlsearch<cr>

" don't move cursor on * #
nmap * *N
nmap # #N

" * search selection (uses z register)
vnoremap * "zy:set hlsearch<cr>:let @z=escape(@z,'\\/')<cr>:let @/='\V'.@z<cr>

" <leader>r replace, repeat with .
nmap <leader>r viw*cgn
vmap <leader>r *cgn

" <leader>R replace all
nmap <leader>R viw*:%s/\V<C-r>z/<C-r>z
vmap <leader>R *:%s/\V<C-r>z/<C-r>z

" spanish keyboard
nnoremap ñ /

"""""""""""""""""""""""""""""""""""
" Appereance / GUI
"""""""""""""""""""""""""""""""""""

" wrap/unwrap long text
nnoremap <leader>gw :set wrap<CR>
nnoremap <leader>gW :set wrap!<CR>

" Set extra options when running in GUI mode
if has("gui_running")

    set guioptions-=m "remove menu bar
    set guioptions-=T "remove toolbar

    " Good fonts: source code pro, jetbrains mono, consolas, cascadia
    " select with: set guifont=*
    " check current with: :echo &guifont
    set guifont=CascadiaCode-Regular:h13
    " set guifont=Cascadia_Code_SemiBold:h10:W600:cANSI:qDRAFT

    " in windows, set render option for ligatures <> != >= <=
    if (has('win32') || has('win64'))
      set renderoptions=type:directx
    endif

else

  " Cursor in terminal
  " https://vim.fandom.com/wiki/Configuring_the_cursor
  " 1 or 0 -> blinking block
  " 2 solid block
  " 3 -> blinking underscore
  " 4 solid underscore
  " Recent versions of xterm (282 or above) also support
  " 5 -> blinking vertical bar
  " 6 -> solid vertical bar

  if &term =~ '^xterm'
    " normal mode
    let &t_EI .= "\<Esc>[3 q"
    " insert mode
    let &t_SI .= "\<Esc>[6 q"
  endif

endif

" Run maximized in GUI
if ((has('win32') || has('win64')) && has("gui_running"))
    set lines=999 columns=999
    autocmd GUIEnter * simalt ~x " https://vim.fandom.com/wiki/Maximize_or_set_initial_window_size
endif

" Save
nnoremap <C-s> :w!<CR>
vnoremap <C-s> <Esc>:w!<CR>
inoremap <C-s> <Esc>:w!<CR>

" Refresh
nnoremap <F5> :e<CR>

" In graphical vim save with save dialog
function! SaveAsNative()
  browse confirm saveas
endfunction
command! SaveAsNative :call SaveAsNative()

" Open native file explorer in current file, project directory
if (has('win32') || has('win64'))
  nnoremap <leader>e :!start explorer /e,%:p:h<CR>
  nnoremap <leader>E :execute "!start explorer /e," . shellescape(getcwd(),1)<CR>
endif 

if(has('unix'))
  if(has('macunix'))
    nnoremap <leader>e :silent execute '![ -f "%:p" ] && open -R "%:p" \|\| open "%:p:h"'<CR>
    nnoremap <leader>E :!open .<CR>
  else
    nnoremap <leader>e :execute '!explorer.exe `wslpath -w ' . expand('%:p:h'). '`'<CR>
    nnoremap <leader>E :!explorer.exe .<CR>
  endif
endif

""""""""""""""""""""""""""""""
" Files manipulation, browsing
""""""""""""""""""""""""""""""

let g:netrw_altfile = 1 " Don't register netrw as the alternate buffer

noremap <F4> :Explore<CR>

" Change dir to current path
command! ChangeDir :cd %:p:h<CR>

" Expand %% to current dir in command line
cnoremap %% <C-R>=fnameescape(expand("%:p:h")."/")<CR>

" Expand ^^ to current file path in command line
cnoremap ^^ <C-R>=fnameescape(expand("%:p"))<CR>

" Expand && to only file name (tail)
cnoremap && <C-R>=fnameescape(expand("%:t"))<CR>

" Insert filename
nnoremap <localleader>fn :let @z=expand('%:t')<Cr>"zp 
imap <localleader>fn <esc><localleader>fn 

" Insert other window filename
nnoremap <localleader>wn <C-w><C-w>:let @z=expand('%:t')<Cr><C-w><C-w>"zp 
imap <localleader>wn <esc><localleader>wn 

" Duplicate File
function! s:duplicate(name)
  if a:name != ''
    execute "w %:h/" . a:name
    execute "e %:h/" . a:name
  endif
endfunction
:command! -nargs=1 -bar Duplicate :call s:duplicate(<f-args>)

""""""""""
" Commands
""""""""""

" Repeat last command
nnoremap g. @:

if (has("nvim")) 
  " Shows the effects of a command incrementally, as you type.
  set inccommand=nosplit 
endif

"""""""""""""""""""""""""
" Code formatting
"""""""""""""""""""""""""

" Indent all document
nnoremap == gg=G

" Delete blank lines
:command! DeleteBlankLines g/^\s*$/d

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

"""""""""""""""""""""""""""
" Filetypes specific tuning
"""""""""""""""""""""""""""

augroup filetypes
  autocmd!

  " PHP 
  autocmd BufReadPost *.php setlocal iskeyword-=- 

  " Blade filetype
  autocmd BufRead,BufNewFile *.blade.php set filetype=blade
  autocmd BufReadPost *.blade.php setlocal iskeyword+=-,$

  " Txt as markdown
  autocmd BufReadPost *.txt set filetype=markdown

  " Html
  autocmd BufRead,BufNewFile {*.html,*.css,*.scss} setlocal iskeyword+=#,-,$
  autocmd BufRead,BufNewFile *.html setlocal formatprg=prettier\ --parser=html\ --print-width=999

  " Css
  autocmd BufRead,BufNewFile *.css setlocal iskeyword+=#,-

  " Scss
  autocmd BufRead,BufNewFile *.scss setlocal iskeyword+=#,-,$

augroup END

"""""""""""""""""""""""""""""""""""
" Utils
"""""""""""""""""""""""""""""""""""

" Insert date
nnoremap <localleader>h i<c-r>=strftime("%Y-%m-%d")<CR><esc>
inoremap <localleader>h <c-r>=strftime("%Y-%m-%d")<CR>

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

