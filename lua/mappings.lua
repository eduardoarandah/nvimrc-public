local map = vim.keymap.set

-----------
-- Movement
-----------

-- Lines
map("n", "<C-l>", "g_")
map("x", "<C-l>", "g_")
map("n", "<C-h>", "^")
map("x", "<C-h>", "^")

-- Buffers
map("n", "<C-j>", ":bn<CR>")
map("n", "<C-k>", ":bp<CR>")

-- Alternate buffer
map("n", "<leader>k", ":b#<CR>")

-- Tabs
map("n", "<leader>tt", ":tabnew<CR>")
map("n", "<leader>tc", ":tabclose<CR>")
map("n", ")", ":tabnext<CR>")
map("n", "(", ":tabprevious<CR>")

-- Move tabs
map("n", "<leader>)", ":tabm +1<cr>")
map("n", "<leader>(", ":tabm -1<cr>")

-- Go to end of page and center
map("n", "G", "Gzz")

-- Add movement to jumplist when using relative numbers
map("n", "k", '(v:count > 2 ? "m\'" . v:count : "") . "k"', { expr = true })
map("n", "j", '(v:count > 2 ? "m\'" . v:count : "") . "j"', { expr = true })

-- Scroll viewport faster: >
map("n", "<C-e>", "2<C-e>")
map("n", "<C-y>", "2<C-y>")

----------
-- Buffers
----------

-- close buffer
map("n", "<leader>q", ":bd<CR>")

-- close unsaved buffer, no save
map("n", "<leader>Q", ":bd!<CR>")

-- just die please
map("n", "<localleader>q", ":qa!<CR>")

-- write
map("n", "<leader>w", ":w!<CR>")

-- close all buffers
map("n", "<leader>bd", ":%bd<CR>")

-- close other splits, keep current only
map("n", "<leader>o", ":only<CR>")

---------
-- Splits
---------

map("n", "<leader><up>", ":resize -10<CR>")
map("n", "<leader><down>", ":resize +10<CR>")
map("n", "<leader><left>", ":vertical resize -10<CR>")
map("n", "<leader><right>", ":vertical resize +10<CR>")

-------------------
-- Visual Shortcuts
-------------------

-- Visual line
map("n", "<leader>l", "_vg_")

-- Visual document
map("n", "<leader>a", "ggVG")

-- Move lines in visual mode
map("x", "<c-n>", ":m '>+1<CR>gv=gv")
map("x", "<c-p>", ":m '<-2<CR>gv=gv")

-- J K just move
map("x", "J", "j")
map("x", "K", "k")

-- sort selection
map("x", "<leader>s", ":sort<CR>")

------------
-- Quick fix
------------

map("n", "[c", ":cprevious<cr>")
map("n", "]c", ":cnext<cr>")
map("n", "<leader>co", ":copen<CR>")
map("n", "<leader>cc", ":cclose<CR>")

--------
-- Macros
--------

-- Execute macro q on visual selection
map("x", "Q", ":normal Q<CR>", { remap = true })

-----------------------
-- Clipboard / registers
-----------------------

-- Copy text to the end of line, behave like C D
map("n", "Y", "y$")

-- Fix issues when pasting a lot of code
map("n", "F2", ":set pastetoggle<CR>")

-- Don't lose clipboard when pasting
map("x", "p", "pgvy")

----------------
-- Search replace
----------------

-- Clear search
map("n", "<leader><Esc>", ":let @/=''<cr>", { silent = true })

-- No highlight search
map("n", "<leader>/", ":nohlsearch<cr>")

-- Makes * and # work on visual mode too.
vim.cmd([[
function! s:VSetSearch(cmdtype)
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>
]])

-- don't move cursor on * #
map("n", "*", "*N")
map("n", "#", "#N")

-- <leader>r replace, repeat with .
map("n", "<leader>r", "*Ncgn")
map("x", "<leader>r", "*Ncgn", { remap = true }) -- first execute VSetSearch

-- <leader>R replace all
map("n", "<leader>R", 'yiw:%s/\\V<C-r>"/<C-r>"')
map("x", "<leader>R", 'y:%s/\\V<C-r>"/<C-r>"')

-----------------------------------
-- Appereance / GUI
-----------------------------------

-- wrap/unwrap long text
map("n", "<leader>gw", ":set wrap<CR>")
map("n", "<leader>gW", ":set wrap!<CR>")

-- Refresh
map("n", "<F5>", ":e<CR>")

-------------------------------
-- Files manipulation, browsing
-------------------------------

map("n", "<leader>e", ":!open -R '%:p'<CR>")
map("n", "<leader>E", ":!open .<CR>")

-- Change dir to current file
map("n", "<leader>cd", ":cd %:p:h<cr>")

-------------------------
-- Command line mappings
-------------------------

-- Expand to current file path in command line
map("c", "<localleader>%", '<C-R>=fnameescape(expand("%:p"))<CR>')

-- Expand && to only file name (tail)
map("c", "<localleader>t", '<C-R>=fnameescape(expand("%:t"))<CR>')

-- Expand to current date
map("c", "<localleader>d", '<C-R>=strftime("%Y-%m-%d")<CR>')

-------------------------
-- Commands
-------------------------

-- Repeat last command
map("n", "g.", "@:")

---------------------------
-- Operator pending motions
---------------------------

-- yil to yank inside line
map("x", "il", "^og_")
map("o", "il", ":normal vil<CR>", { silent = true })

-------------------------
-- Formatting
-------------------------

-- Indent all document
map("n", "==", "gg=G")

-------------------------
-- My plugins
-------------------------

map("n", "<F12>", require("greport").greport)
