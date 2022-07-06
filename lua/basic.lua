-- utility functions
local u = require("utils")
local nnoremap = u.nnoremap
local xnoremap = u.xnoremap
local map = u.map

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.opt.clipboard = "unnamedplus,unnamed" -- ALWAYS use the clipboard for ALL operations
vim.opt.expandtab = true -- Tabs are spaces, not tabs
vim.opt.ff = "unix" -- Use Unix as the standard file type
vim.opt.gdefault = true -- Add g (global) to substitute operations, :s/pattern/replacement/
vim.opt.history = 10000 -- Sets how many lines of history VIM has to remember
vim.opt.lazyredraw = true -- Don't redraw while executing macros (good performance config)
vim.opt.mouse = "a" -- Mouse support in all modes
vim.opt.number = true -- Line numbers on
vim.opt.relativenumber = true -- Use relative numbers instead of absolute
vim.opt.scrolloff = 5 -- Minimal number of screen lines to keep above and below the cursor.
vim.opt.shiftwidth = 2 -- Use indents of x spaces
vim.opt.showmatch = true -- Show matching brackets/parenthesis
vim.opt.signcolumn = "yes" -- Fixed space on the left for git and linting signs, otherwise it 'jumps'
vim.opt.smartindent = false -- Smart indent
vim.opt.softtabstop = 2 -- Number of spaces that a <Tab> counts for while performing editing
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.undofile = true -- saves undo history to an undo file, so it persists
vim.opt.virtualedit = "block" -- If you need to define a block in visual block mode with bounds outside the actual text (that is, past the end of lines), you can allow this with:
vim.opt.wrap = false -- Don't wrap long lines

-- lua-highlight
vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 120 })
	end,
	desc = "Highlight yank",
})

-----------
-- Movement
-----------

-- Lines
nnoremap("<C-l>", "g_")
xnoremap("<C-l>", "g_")
nnoremap("<C-h>", "^")
xnoremap("<C-h>", "^")

-- Buffers
nnoremap("<C-j>", ":bn<CR>")
nnoremap("<C-k>", ":bp<CR>")

-- Alternate buffer
nnoremap("<leader>k", ":b#<CR>")

-- Tabs
nnoremap("<leader>tt", ":tabnew<CR>")
nnoremap("<leader>tc", ":tabclose<CR>")
nnoremap(")", ":tabnext<CR>")
nnoremap("(", ":tabprevious<CR>")
-- Move tabs
nnoremap("<leader>)", ":tabm +1<cr>")
nnoremap("<leader>(", ":tabm -1<cr>")

-- Go to end of page and center
nnoremap("G", "Gzz")

-- Add movement to jumplist when using relative numbers
-- nnoremap <expr> k (v:count > 2 ? "m'" . v:count : "") . 'k'
-- nnoremap <expr> j (v:count > 2 ? "m'" . v:count : "") . 'j'

-- Scroll viewport faster: >
nnoremap("<C-e>", "2<C-e>")
nnoremap("<C-y>", "2<C-y>")

----------
-- Buffers
----------

-- close buffer
nnoremap("<leader>q", ":bd<CR>")

-- close unsaved buffer, no save
nnoremap("<leader>Q", ":bd!<CR>")

-- just die please
nnoremap("<localleader>q", ":qa!<CR>")

-- write
nnoremap("<leader>w", ":w!<CR>")

-- close all buffers
nnoremap("<leader>bd", ":%bd<CR>")

-- close other splits, keep current only
nnoremap("<leader>o", ":only<CR>")

---------
-- Splits
---------

nnoremap("<leader><up>", ":resize -10<CR>")
nnoremap("<leader><down>", ":resize +10<CR>")
nnoremap("<leader><left>", ":vertical resize -10<CR>")
nnoremap("<leader><right>", ":vertical resize +10<CR>")

-------------------
-- Visual Shortcuts
-------------------

-- Visual line
nnoremap("<leader>l", "_vg_")

-- Visual document
nnoremap("<leader>a", "ggVG")

-- Move lines in visual mode
xnoremap("N", ":m '>+1<CR>gv=gv")
xnoremap("P", ":m '<-2<CR>gv=gv")

-- J K just move
xnoremap("J", "j")
xnoremap("K", "k")

------------
-- Quick fix
------------

nnoremap("[c", ":cprevious<cr>")
nnoremap("]c", ":cnext<cr>")
nnoremap("<leader>co", ":copen<CR>")
nnoremap("<leader>cc", ":cclose<CR>")

--------
-- Macros
--------

-- Execute macro q
nnoremap("Q", "@q")

-- Execute macro q on visual selection
xnoremap("Q", ":normal @q<CR>")

-----------------------
-- Clipboard / registers
-----------------------

-- Copy text to the end of line, behave like C D
nnoremap("Y", "y$")

-- Fix issues when pasting a lot of code
nnoremap("F2", ":set pastetoggle<CR>")

-- Don't lose clipboard when pasting
xnoremap("p", "pgvy")

-- delete/change without changing clipboard
nnoremap("<leader>x", '"_x')
nnoremap("<leader>d", '"_d')
nnoremap("<leader>c", '"_c')

-- Delete all registers
-- command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor

----------------
-- Search replace
----------------

-- Clear search
map("n", "<leader><Esc>", ":let @/=''<cr>", { noremap = true, silent = true })

-- No highlight search
nnoremap("<leader>/", ":nohlsearch<cr>")

-- don't move cursor on * #
nnoremap("*", "*N")
nnoremap("#", "#N")

-- <leader>r replace, repeat with .
map("n", "<leader>r", "*cgn", {})
map("x", "<leader>r", "*Ncgn", {})

-- <leader>R replace all
map("n", "<leader>R", '*ygn:%s/<C-r>"/<C-r>"', {})
map("x", "<leader>R", 'y:%s/<C-r>"/<C-r>"', {})

-----------------------------------
-- Appereance / GUI
-----------------------------------

-- wrap/unwrap long text
nnoremap("<leader>gw", ":set wrap<CR>")
nnoremap("<leader>gW", ":set wrap!<CR>")

-- Refresh
nnoremap("<F5>", ":e<CR>")

-------------------------------
-- Files manipulation, browsing
-------------------------------

nnoremap("<leader>e", ":!open -R '%:p'<CR>")
nnoremap("<leader>E", ":!open .<CR>")

nnoremap("<F4>", ":Explore<CR>")

-- Change dir to current path
-- command! ChangeDir :cd %:p:h<CR>

-- Expand %% to current dir in command line
-- cnoremap %% <C-R>=fnameescape(expand("%:p:h")."/")<CR>

-- Expand ^^ to current file path in command line
-- cnoremap ^^ <C-R>=fnameescape(expand("%:p"))<CR>

-- Expand && to only file name (tail)
-- cnoremap && <C-R>=fnameescape(expand("%:t"))<CR>

-- Insert filename
-- command! Fname normal i <c-r>=expand('%:t:r')<cr>
-- command! Fnameext normal i <c-r>=expand('%:t')<cr>

-------------------------
-- Commands
-------------------------

-- Repeat last command
nnoremap("g.", "@:")

-------------------------
-- motions
-------------------------

-- operator pending motion: yil to yank inside line
xnoremap("il", "^og_")
map("o", "il", ":normal vil<CR>", { noremap = true, silent = true })

-------------------------
-- Formatting
-------------------------

-- Indent all document
nnoremap("==", "gg=G")
