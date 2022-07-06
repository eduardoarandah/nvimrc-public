-------------------------------------------------------------------------------------
-- 1) Copy this file anywhere,
-- 2) Paste your options in "opts"
-- 3) Source it with :source %
--
-- If you get "unknown option" then remove it from opts and put it in "globals"
--
-- checkopts() checks for values that already are defaults. Remove this function when you're done
-- checkglobals() the same but for globals
--
-- https://eduardoarandah.github.io/
-------------------------------------------------------------------------------------

-- Here's some examples:
local opts = {
	ai = true, -- Auto indent
	autoindent = true, -- Auto indent
	autoread = true, -- Detect changes
	background = "dark", -- Dark
	backspace = "indent,eol,start", -- fix: backspace past start of operation
	cmdheight = 1, -- Height of the command bar
	encoding = "utf-8", -- Encoding (needed in youcompleteme)
	expandtab = true, -- Tabs are spaces, not tabs
	ff = "unix", -- Use Unix as the standard file type
	ffs = "unix,dos,mac", -- This gives the end-of-line (<EOL>) formats that will be tried
	fileencoding = "utf-8", -- The encoding written to file.
	formatoptions = "tcqj", -- Format options, each letter means something
	gdefault = true, -- Add g (global) to substitute operations, :s/pattern/replacement/
	hidden = true, -- Allow buffer switching without saving
	history = 10000, -- Sets how many lines of history VIM has to remember
	hlsearch = true, -- Highlight search results
	ignorecase = true, -- Ignore case when searching
	incsearch = true, -- Makes search act like search in modern browsers
	lazyredraw = true, -- Don't redraw while executing macros (good performance config)
	linespace = 0, -- No extra spaces between rows
	magic = true, -- For regular expressions turn magic on
	mat = 2, -- How many tenths of a second to blink when matching brackets
	maxmempattern = 1000000, -- Max memory for syntax in Kb
	mouse = "a", -- Mouse support in all modes
	number = true, -- Line numbers on
	redrawtime = 5000, -- After this milliseconds, stop processing syntax
	relativenumber = true, -- Use relative numbers instead of absolute
	ruler = true, -- Always show current position
	shiftwidth = 4, -- Use indents of x spaces
	showcmd = true, -- Show command in status bar
	showmatch = true, -- Show matching brackets/parenthesis
	si = true, -- Smart indent
	signcolumn = "yes", -- Fixed space on the left for git and linting signs, otherwise it 'jumps'
	smartcase = true, -- When searching try to be smart about cases
	so = 5, -- Set 7 lines to the cursor - when moving vertically using j/k
	softtabstop = 2, -- Let backspace delete indent
	splitbelow = true, -- Open split below
	splitright = true, -- Open split right
	switchbuf = "useopen,usetab", -- Specify the behavior when switching between buffers
	syntax = "enable", -- Turn on syntax
	tabstop = 2, -- An indentation every x columns
	undofile = true,
	viewoptions = "folds,options,cursor,unix,slash", -- Better Unix / Windows compatibility
	virtualedit = "block", -- If you need to define a block in visual block mode with bounds outside the actual text (that is, past the end of lines), you can allow this with:
	whichwrap = "b,s,h,l,<,>,[,]", -- Backspace and cursor keys wrap too
	wrap = false, -- Don't wrap long lines
}

local globals = {
	colorscheme = "desert",
}

local function checkopts()
	print("Options that you can discard because they're default:")
	for k, v in pairs(opts) do
		if vim.opt[k]:get() == v then
			print(k, v)
		end
	end
end

local function checkglobals()
	print("globals that you can discard because they're default:")
	for k, v in pairs(globals) do
		if vim.g[k] == v then
			print(k, v)
		end
	end
end

checkopts()
checkglobals()

-- set options
for k, v in pairs(opts) do
	-- the same as vim.opt.youroption = yourvalue
	vim.opt[k] = v
end

-- set globals
for k, v in pairs(globals) do
	-- the same as vim.g.youroption = yourvalue
	vim.g[k] = v
end
