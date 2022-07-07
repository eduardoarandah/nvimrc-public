local set = vim.opt
local g = vim.g
g.mapleader = " "
g.maplocalleader = "\\"
set.clipboard = "unnamedplus,unnamed" -- ALWAYS use the clipboard for ALL operations
set.expandtab = true -- Tabs are spaces, not tabs
set.ff = "unix" -- Use Unix as the standard file type
set.gdefault = true -- Add g (global) to substitute operations, :s/pattern/replacement/
set.history = 10000 -- Sets how many lines of history VIM has to remember
set.lazyredraw = true -- Don't redraw while executing macros (good performance config)
set.mouse = "a" -- Mouse support in all modes
set.number = true -- Line numbers on
set.relativenumber = true -- Use relative numbers instead of absolute
set.scrolloff = 5 -- Minimal number of screen lines to keep above and below the cursor.
set.shiftwidth = 2 -- Use indents of x spaces
set.showmatch = true -- Show matching brackets/parenthesis
set.signcolumn = "yes" -- Fixed space on the left for git and linting signs, otherwise it 'jumps'
set.smartindent = false -- Smart indent
set.softtabstop = 2 -- Number of spaces that a <Tab> counts for while performing editing
set.splitbelow = true
set.splitright = true
set.undofile = true -- saves undo history to an undo file, so it persists
set.virtualedit = "block" -- If you need to define a block in visual block mode with bounds outside the actual text (that is, past the end of lines), you can allow this with:
set.wrap = false -- Don't wrap long lines

-- lua-highlight
vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 120 })
	end,
	desc = "Highlight yank",
})
