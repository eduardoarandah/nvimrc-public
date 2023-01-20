" Update:
" PlugUpgrade
" PlugUpdate
" TSUpdate

""""""""""""""""
" Basic settings
""""""""""""""""

scriptencoding utf-8 " basic
filetype off " basic
filetype plugin on " Enable filetype plugins
filetype indent on " Enable loading the indent file for specific file types
" syntax enable " Enable syntax highlighting

set nocompatible " basic
set redrawtime=5000 " After this milliseconds, stop processing syntax
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
set shiftwidth=4 " Use indents of x spaces
set expandtab " Tabs are spaces, not tabs
set tabstop=2 " An indentation every x columns
set softtabstop=2 " Let backspace delete indent
set ai " Auto indent
set si " Smart indent
set nojoinspaces " Prevents inserting two spaces after punctuation on a join (J)
set switchbuf=useopen,usetab " Specify the behavior when switching between buffers
set hlsearch " Highlight search results
set incsearch " Makes search act like search in modern browsers
set ignorecase " Ignore case when searching
" set smartcase " When searching try to be smart about cases
set gdefault " Add g (global) to substitute operations, :s/pattern/replacement/
set splitbelow " Open split below
set splitright " Open split right
" set listchars=trail:-
set mouse=a " Mouse support in all modes
set undofile
set signcolumn=yes " Fixed space on the left for git and linting signs, otherwise it 'jumps'

" Wildmenu
set wildmenu " Show list instead of just completing
set wildignore=*.o,*~,*.pyc " Ignore compiled files
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
set wildcharm=<tab>

" Directories. Separate vim and neovim to avoid conflicts on format
call mkdir($HOME."/.nvim/tmp","p") " Create dir if not exists
set runtimepath^=~/.nvim runtimepath+=~/.nvim/after
let &packpath = &runtimepath
set backupdir=$HOME/.nvim/tmp//
set directory=$HOME/.nvim/tmp//
set undodir=$HOME/.nvim/tmp//
command! Tmpfilesremove !rm ~/.nvim/tmp/*

"""""""""""""""""
" Highlight yanks
"""""""""""""""""

if(has('nvim'))
  augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=300 }
  augroup END
endif

" Leader Key
let mapleader=" "
let maplocalleader = "\\"

""""""""""
" Movement
""""""""""

" Lines
nnoremap <C-l> g_
xnoremap <C-l> g_
nnoremap <C-h> ^
xnoremap <C-h> ^

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

" Move tabs
nnoremap <leader>) :tabm +1<cr>
nnoremap <leader>( :tabm -1<cr>

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
nnoremap <localleader>q :qa!<CR>

" write
nnoremap <leader>w :w!<CR>

" close all buffers
nnoremap <leader>bd :%bd<CR>

" close other splits, keep current only
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
xnoremap N :m '>+1<CR>gv=gv
xnoremap P :m '<-2<CR>gv=gv

" J K just move
xnoremap J j
xnoremap K k

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
xnoremap Q :normal @q<CR>

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
xnoremap p pgvy

" delete/change without changing clipboard
nnoremap <leader>x "_x
nnoremap <leader>d "_d
nnoremap <leader>c "_c

" Delete all registers
command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor

" Fixes copying special chars (only nvim)
lang en_US

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
" xnoremap * "zy:set hlsearch<cr>:let @z=escape(@z,'\\/')<cr>:let @/='\V'.@z<cr>

" <leader>r replace, repeat with .
nmap <leader>r viw*Ncgn
xmap <leader>r *Ncgn

" <leader>R replace all
nmap <leader>R viw*:%s/\V<C-r>z/<C-r>z
xmap <leader>R *:%s/\V<C-r>z/<C-r>z

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
command! Fname normal i <c-r>=expand('%:t:r')<cr>
command! Fnameext normal i <c-r>=expand('%:t')<cr>

" Duplicate File
function! s:duplicate(name)
  if a:name != ''
    execute "w %:h/" . a:name
    execute "e %:h/" . a:name
  endif
endfunction
:command! -nargs=1 -bar Duplicate :call s:duplicate(<f-args>)

"""""""""""""""""""""""""
" Commands
"""""""""""""""""""""""""

" Repeat last command
nnoremap g. @:

"""""""""""""""""""""""""
" motions
"""""""""""""""""""""""""

" operator pending motion: yil to yank inside line
xnoremap il ^og_
onoremap <silent> il :normal vil<CR>

"""""""""""""""""""""""""
" Formatting
"""""""""""""""""""""""""

" Indent all document
nnoremap == gg=G

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

