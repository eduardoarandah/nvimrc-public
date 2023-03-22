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

"""""""""""""""""""""""""""""""
" My plugins
"""""""""""""""""""""""""""""""

nnoremap <F12> :lua require("greport").greport()<cr>
