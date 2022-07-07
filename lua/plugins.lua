local map = vim.keymap.set
local cmd = vim.api.nvim_create_user_command

-- Automatically install packer if not found on disk then set a local variable to show it's just installed
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local packer_just_installed = nil
if fn.empty(fn.glob(install_path)) > 0 then
	packer_just_installed = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
end

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

	-- Syntax
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("sheerun/vim-polyglot")

	-- Theme
	use({
		"Mofiqul/dracula.nvim",
		config = "vim.cmd('colorscheme dracula')",
	})
	vim.g.rehash256 = 1

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
	map("n", "<F7>", ":NERDTreeToggle<CR>")
	map("n", "<F8>", ":NERDTreeFind<CR>")

	-- Change current dir to current file
	vim.cmd("nnoremap <leader>cd :cd %:p:h<CR>:NERDTreeCWD<CR>")

	-- Comment lines
	use("numToStr/Comment.nvim")

	-- FZF Fuzzy Finder
	use({ "junegunn/fzf", run = ":call fzf#install()" })
	use("junegunn/fzf.vim")
	map("n", "<C-p>", "<cmd>Files<CR>") -- all files
	map("n", "<leader>hi", ":History<CR>") --recent files
	map("n", "<leader>:", ":History:<CR>") -- commands
	map("n", "<leader>j", ":Lines<CR>") -- all lines in all buffers
	map("n", "<C-f>", ":Buffers<CR>") -- buffers

	vim.cmd([[ 
	if executable('rg')
		" Use RipGrep to list files for fzf, include dotfiles in current directory
		let $FZF_DEFAULT_COMMAND='{ rg --files; find . -type f -name ".*" -depth 1 }'
	else
		" Open GIT files if is a git repo, otherwise, just list files
		nnoremap <expr> <C-p> (len(system('git rev-parse')) ? ':Files' : ':GFiles --exclude-standard --others --cached')."\<cr>"
	endif
	]])

	vim.cmd([[ 
	function! ChangeFZFDir()
		let g:dir=expand('%:h')
		nnoremap <C-p> :Files <c-r>=g:dir<CR><CR>
		echo 'FZF files dir changed to: '. g:dir 
	endfunction
	nnoremap <leader>cz :call ChangeFZFDir()<CR>
	]])

	-- Allow repeating for plugin mappings like surround
	use("tpope/vim-repeat")

	-- Surround with ys
	use("tpope/vim-surround")

	-- Git
	use("tpope/vim-fugitive")
	map("n", "<leader>gs", ":Git<cr>")
	map("n", "<leader>ga", ":Git add %<cr>")
	map("n", "<leader>gr", ":Gread<cr>")
	map("n", "<leader>gl", ":Git log --name-only<cr>")
	map("n", "<leader>gA", ":Git add -A<cr>")
	map("n", "<leader>gco", ":Git checkout<space>")
	map("n", "<leader>gcb", ":Git checkout -b<space>")
	map("n", "<leader>gp", ":Git push<cr>")

	-- git diff (:Gdiffsplit! for merge conflicts)
	map("n", "<leader>gd", ":Gdiffsplit<cr>")

	-- git merge left-right
	map("n", "<leader>mh", ":diffget //2<cr>")
	map("n", "<leader>ml", ":diffget //3<cr>")

	-- All commits
	cmd("Ghistory", ":Gclog", { bang = true })

	-- Commits for current file
	cmd("Ghistoryfile", ":0Gclog!", { bang = true })

	-- Shows a git diff in the sign column.
	use("mhinz/vim-signify")

	-- Maximizes and restores the current window in Vim.
	use("szw/vim-maximizer")
	map("n", "<leader>z", ":MaximizerToggle<CR>")
	map("x", "<leader>z", ":MaximizerToggle<CR>gv")

	-- Auto close brackets
	use("jiangmiao/auto-pairs")
	vim.g.AutoPairsShortcutToggle = ""
	vim.g.AutoPairsMapCh = 0 -- don't map this one

	-- Search with ripgrep :Rg
	use("jremmen/vim-ripgrep")
	vim.g.rg_command = 'rg --vimgrep --pcre2 --type-add="scss:*.scss"'

	-- Sessions
	use("xolox/vim-misc")
	use("romgrk/vim-session")
	vim.g.session_autoload = "no"
	vim.g.session_autosave = "yes"
	vim.g.session_directory = "~/.nvim/sessions"
	vim.g.session_extension = ""

	-- Useful commands
	use("tpope/vim-eunuch")
	-- :Delete: Delete a buffer and the file on disk simultaneously.
	-- :Unlink: Like :Delete, but keeps the now empty buffer.
	-- :Move: Rename a buffer and the file on disk simultaneously.
	-- :Rename: Like :Move, but relative to the current file's containing directory.
	-- :Chmod: Change the permissions of the current file.
	-- :Mkdir: Create a directory, defaulting to the parent of the current file.
	-- :Cfind: Run find and load the results into the quickfix list.
	-- :Clocate: Run locate and load the results into the quickfix list.
	-- :Lfind/:Llocate: Like above, but use the location list.
	-- :Wall: Write every open window. Handy for kicking off tools like guard.
	-- :SudoWrite: Write a privileged file with sudo.
	-- :SudoEdit: Edit a privileged file with sudo.
	-- File type detection for sudo -e is based on original file name.
	-- New files created with a shebang line are automatically made executable.
	-- New init scripts are automatically prepopulated with /etc/init.d/skeleton.

	-- Calculate simple formulas
	use("sk1418/HowMuch")
	vim.g.HowMuch_scale = 8
	map("n", "<leader>hm", "V<Plug>AutoCalcAppendWithEq")
	map("x", "<leader>hm", "<Plug>AutoCalcAppendWithEq")
	map("x", "<leader>hms", "<Plug>AutoCalcAppendWithEqAndSum")
	map("x", "<leader>hmr", "<Plug>AutoCalcReplace")

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
	-- let g:caser_no_mappings = 1
	-- let g:caser_prefix = 'gs'
	-- p PascalCase
	-- c camelCase
	-- _ snake_case
	-- U UPPER_CASE
	-- t Title Case
	-- s Sentence case
	-- <space> space case
	-- - dash-case
	-- K Title-Dash-Case
	-- . dot.case
	vim.cmd([[ 
	" Visual select and change case
	function! Case()
		 let l:myMakeTargets = ["", "gsc", "gs-", "gsp", "gs_", "gsU", "gst", "gss", "gs\<space>", "gsKse", "gs."]
		 let l:c=0
		 let l:c = confirm("Change case","&c camelCase\n&d dash-case\n&p PascalCase\n&_ snake_case\n&u UPPER_CASE\n&t Title Case\n&s Sentence case\n&a space case\n&k Title-Dash-Case\n&. dot.case")
		 if l:c != 0
					 exec "norm gv" . l:myMakeTargets[l:c]
		 endif
	endfunction
	command! -range Case :call Case()
	xnoremap <leader>c :call Case()<cr>
	]])

	-- Markdown
	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app & yarn install",
	})

	-- Prettier
	use({
		"prettier/vim-prettier",
		run = "yarn install",
	})

	-- REPL, send commands to another window
	use("jpalardy/vim-slime")
	vim.g.slime_target = "tmux"

	-- target_pane
	-- {last} current window, last pane,
	-- :.2 current window, second pane
	-- %pane_id get it with echo $TMUX_PANE
	vim.g.slime_no_mappings = 1
	map("x", "<F9>", "<Plug>SlimeRegionSend")
	map("n", "<F9>", "<Plug>SlimeParagraphSend")

	-- editorconfig respect .editorconfig settings like indenting
	use("editorconfig/editorconfig-vim")

	-- lua format
	use("andrejlevkovitch/vim-lua-format")

	-- typescript
	use("jose-elias-alvarez/typescript.nvim")

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
	if packer_just_installed then
		require("packer").sync()
	end
end)
