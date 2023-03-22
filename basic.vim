"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim specific settings
" old vim requires some extra configuration
" taken from: https://neovim.io/doc/user/vim_diff.html
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if !has('nvim')
  " set backupdir=.,~/.local/state/vim/backup//
  " set directory=~/.local/state/vim/swap//
  " set undodir=~/.local/state/vim/undo//
  colorscheme slate
  filetype indent on " Enable loading the indent file for specific file types
  filetype off " basic
  filetype plugin on " Enable filetype plugins
  set autoindent " Auto indent
  set autoread " Detect changes
  set background=dark " Dark
  set backspace=indent,eol,start " fix: backspace past start of operation
  set belloff=all
  set compatible!
  set complete=.,w,b,u,t
  set encoding=utf-8 " Encoding (needed in youcompleteme)
  set fileencoding=utf-8 " The encoding written to file.
  set fillchars=""
  set formatoptions=tcqj " Format options, each letter means something
  set fsync!
  set hidden " Allow buffer switching without saving
  set hlsearch " Highlight search results
  set incsearch " Makes search act like search in modern browsers
  set joinspaces!
  set langnoremap
  set langremap!
  set laststatus=2
  set linespace=0 " No extra spaces between rows
  set listchars=
  set maxmempattern=1000 " Max memory for syntax in Kb
  set mouse=a
  set mousemodel=popup_setpos
  set nocompatible " basic
  set noerrorbells " No annoying sound on errors
  set nojoinspaces " Prevents inserting two spaces after punctuation on a join (J)
  set nrformats=bin,hex
  set ruler " Show the line and column number of the cursor position, separated by a comma.
  set sessionoptions=blank,buffers,curdir,folds,help,tabpages,winsize,terminal
  set shortmess=filnxtToOF
  set showcmd " Show command in status bar
  set sidescroll=1
  set smarttab
  set startofline!
  set switchbuf=uselast " Specify the behavior when switching between buffers
  set t_vb= " Flashing screen is annoying
  set tabpagemax=50
  set tabstop=2 " An indentation every n columns
  set tags=./tags;,tags
  set ttimeoutlen=50
  set ttyfast
  set viewoptions=folds,cursor,curdir
  set viminfo=!,'100,<50,s10,h
  set whichwrap=b,s,h,l,<,>,[,] " Backspace and cursor keys wrap too
  set wildmenu
  syntax enable " Enable syntax highlighting
endif

"""""""""""""""""
" neovim settings
"""""""""""""""""

let mapleader=" " " leader is a key to prepend your mappings
let maplocalleader="\\" " localleader is another key to prepend your mappings
set clipboard=unnamedplus,unnamed " ALWAYS use the clipboard for ALL operations
set expandtab " Tabs are spaces, not tabs
set ff=unix " Use Unix as the standard file type
set gdefault " Add g (global) to substitute operations, :s/pattern/replacement/
set history=10000 " Sets how many lines of history VIM has to remember
set lazyredraw " Don't redraw while executing macros (good performance config)
set mouse=a " Mouse support in all modes
set number " Line numbers on
set relativenumber " Use relative numbers instead of absolute
set scrolloff=5 " Minimal number of screen lines to keep above and below the cursor.
set shiftwidth=2 " Use indents of x spaces
set showmatch " Show matching brackets/parenthesis
set signcolumn=yes " Fixed space on the left for git and linting signs, otherwise it 'jumps'
set smartindent! " Smart indent
set ignorecase " ignore casing on search
set smartcase " if search has uppercase, don't ignore case
set softtabstop=2 " Number of spaces that a <Tab> counts for while performing editing
set splitbelow
set splitright
set undofile " saves undo history to an undo file, so it persists
set virtualedit=block " If you need to define a block in visual block mode with bounds outside the actual text (that is, past the end of lines), you can allow this with:
set wrap! " Don't wrap long lines
set formatoptions=tcq " Format options, each letter means something
set redrawtime=1000 " After this milliseconds, stop processing syntax

""""""""""
" mappings
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

"""""""""""""""""""""""""""""""
" Buffers
"""""""""""""""""""""""""""""""

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

" wrap/unwrap long text
nnoremap <leader>gw :set wrap<CR>
nnoremap <leader>gW :set wrap!<CR>

" Refresh
nnoremap <F5> :e<CR>

"""""""""""""""""""""""""""""""
" Splits
"""""""""""""""""""""""""""""""

nnoremap <leader><up> :resize -10<CR>
nnoremap <leader><down> :resize +10<CR>
nnoremap <leader><left> :vertical resize -10<CR>
nnoremap <leader><right> :vertical resize +10<CR>

"""""""""""""""""""""""""""""""
" Visual Shortcuts
"""""""""""""""""""""""""""""""

" Visual line
nnoremap <leader>l _vg_

" Visual document
nnoremap <leader>a ggVG

" Move lines in visual mode
xnoremap <c-n> :m '>+1<CR>gv=gv
xnoremap <c-p> :m '<-2<CR>gv=gv

" J K just move
xnoremap J j
xnoremap K k

" sort selection
xnoremap <leader>s :sort<CR>

"""""""""""""""""""""""""""""""
" Quick fix
"""""""""""""""""""""""""""""""

nnoremap [c :cprevious<cr>
nnoremap ]c :cnext<cr>
nnoremap <leader>co :copen<CR>
nnoremap <leader>cc :cclose<CR>

"""""""""""""""""""""""""""""""
" Macros
"""""""""""""""""""""""""""""""

" Execute macro q
nnoremap Q @q

" Execute macro q on visual selection
xnoremap Q :normal @q<CR>

"""""""""""""""""""""""""""""""
" Clipboard / registers
"""""""""""""""""""""""""""""""

" Copy text to the end of line, behave like C D
nnoremap Y y$

" Fix issues when pasting a lot of code
nnoremap F2 :set pastetoggle<CR>

" Don't lose clipboard when pasting
xnoremap p pgvy

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
xnoremap * "zy:set hlsearch<cr>:let @z=escape(@z,'\\/')<cr>:let @/='\V'.@z<cr>

" <leader>r replace, repeat with .
nmap <leader>r viw*cgn
vmap <leader>r *cgn

" <leader>R replace all
nmap <leader>R viw*:%s/\V<C-r>z/<C-r>z
vmap <leader>R *:%s/\V<C-r>z/<C-r>z

"""""""""""""""""""""""""""""""
" Files manipulation, browsing
"""""""""""""""""""""""""""""""

nnoremap <leader>e :!open -R '%:p'<CR>
nnoremap <leader>E :!open .<CR>

" Change dir to current file
nnoremap <leader>cd :cd %:p:h<cr>

"""""""""""""""""""""""""""""""
" Command line mappings
"""""""""""""""""""""""""""""""

" Expand to current file path in command line
cnoremap =% <C-R>=fnameescape(expand("%:p:h"))<CR>

" Expand && to only file name (tail)
cnoremap =t <C-R>=fnameescape(expand("%:t"))<CR>

" Expand to current date
cnoremap =d <C-R>=strftime("%Y-%m-%d")<CR>

"""""""""""""""""""""""""""""""
" Commands
"""""""""""""""""""""""""""""""

" Repeat last command
nnoremap g. @:

"""""""""""""""""""""""""""""""
" Operator pending motions
"""""""""""""""""""""""""""""""

" operator pending motion: line
" example: dil delete inside line
xnoremap il ^og_
onoremap <silent> il :normal vil<CR>

"""""""""""""""""""""""""""""""
" Formatting
"""""""""""""""""""""""""""""""

" Indent all document
nnoremap == gg=G
