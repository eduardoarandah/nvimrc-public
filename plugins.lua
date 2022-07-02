local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
end

return require("packer").startup(function()
	local function nnoremap(l, r)
		vim.api.nvim_set_keymap("n", l, r, { noremap = true })
	end

	use("wbthomason/packer.nvim")

	-- Syntax
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("sheerun/vim-polyglot")
	use("Mofiqul/dracula.nvim")

	-- search with * escaping special chars
	use("nelstrom/vim-visual-star-search")

	-- Status/tabline
	use("vim-airline/vim-airline")
	vim.cmd("let g:airline#extensions#tabline#enabled = 1")
	-- Show just the filename
	vim.cmd("let g:airline#extensions#tabline#fnamemod = ':t'")
	-- Show terminal buffers
	vim.cmd(
		"let g:airline#extensions#tabline#ignore_bufadd_pat = 'defx|gundo|nerd_tree|startify|tagbar|undotree|vimfiler'"
	)

	-- File explorer
	use("scrooloose/nerdtree")
	vim.cmd("let NERDTreeShowHidden=1")
	nnoremap("<F7>", ":NERDTreeToggle<CR>")
	nnoremap("<F8> ", ":NERDTreeFind<CR>")

	-- Change current dir to current file
	vim.cmd("nnoremap <leader>cd :cd %:p:h<CR>:NERDTreeCWD<CR>")

	-- Comment lines
	use("numToStr/Comment.nvim")

	-- FZF Fuzzy Finder
	use({ "junegunn/fzf", run = ":call fzf#install()" })
	use("junegunn/fzf.vim")
	nnoremap("<C-p>", "<cmd>Files<CR>")  -- all files
	nnoremap("<leader>hi", ":History<CR>") --recent files
	nnoremap("<leader>:", ":History:<CR>") -- commands
	nnoremap("<leader>j", ":Lines<CR>") -- all lines in all buffers
	nnoremap("<C-f>", ":Buffers<CR>") -- buffers

	-- Allow repeating for plugin mappings like surround
	use("tpope/vim-repeat")

	-- Surround with ys
	use("tpope/vim-surround")

	-- Git
	use("tpope/vim-fugitive")

	-- Shows a git diff in the sign column.
	use("mhinz/vim-signify")

	-- Maximizes and restores the current window in Vim.
	use("szw/vim-maximizer")

	-- Auto close brackets
	use("jiangmiao/auto-pairs")

	-- Search with ripgrep :Rg
	use("jremmen/vim-ripgrep")

	-- Sessions
	use("xolox/vim-misc")
	use("romgrk/vim-session")
	vim.cmd("let g:session_autoload = 'no'")
	vim.cmd("let g:session_autosave = 'yes'")
	vim.cmd("let g:session_directory = $HOME.'/.nvim/sessions'")
	vim.cmd("let g:session_extension = ''")

	-- Useful commands
	use("tpope/vim-eunuch")

	-- Calculate simple formulas
	use("sk1418/HowMuch")

	-- Align in | with :Tabularize /|
	use("godlygeek/tabular")

	-- Display markers
	use("kshenoy/vim-signature")

	-- Css Color
	use({
		"ap/vim-css-color",
		ft = { "css", "scss" },
	})

	-- Change case (casing)
	use("arthurxavierx/vim-caser")

	-- Markdown
	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app & yarn install",
	})

	-- Prettier
	use("prettier/vim-prettier")

	-- REPL, send commands to another window
	use("jpalardy/vim-slime")

	-- editorconfig respect .editorconfig settings like indenting
	use("editorconfig/editorconfig-vim")

	-- lua format
	use("andrejlevkovitch/vim-lua-format")

	-- Completion
	use("hrsh7th/nvim-cmp") -- A completion engine plugin for neovim written in Lua.
	use("neovim/nvim-lspconfig") -- A collection of common configurations for Neovim's built-in language server client.
	use("williamboman/nvim-lsp-installer") -- Allows you to seamlessly install LSP servers locally

	-- Completion sources
	use("hrsh7th/cmp-nvim-lsp") -- nvim-cmp source for neovim's built-in language server client.
	use("hrsh7th/cmp-buffer") -- nvim-cmp source for buffer words.
	use("hrsh7th/cmp-path") -- nvim-cmp source for filesystem paths.
	use("hrsh7th/cmp-cmdline") -- nvim-cmp source for vim's cmdline.
	use("hrsh7th/cmp-nvim-lua") -- nvim-cmp source for neovim Lua API.
	use("uga-rosa/cmp-dictionary") -- https://github.com/uga-rosa/cmp-dictionary

	-- Snippets ultisnips users.
	use("SirVer/ultisnips") -- UltiSnips is the ultimate solution for snippets in Vim
	use("quangnguyen30192/cmp-nvim-ultisnips") -- UltiSnips completion source for nvim-cmp

	-- fix things in quickfix list
	use("stefandtw/quickfix-reflector.vim")

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require("packer").sync()
	end
end)
