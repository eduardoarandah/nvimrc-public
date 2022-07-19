local M = {}

---------
-- dracula
----------

function M.dracula()
	vim.cmd("colorscheme dracula")
	vim.g.rehash256 = 1
end

--------------
-- vim-airline
--------------

function M.vim_airline()
	vim.cmd("let g:airline#extensions#tabline#enabled = 1")
	-- Show just the filename
	vim.cmd("let g:airline#extensions#tabline#fnamemod = ':t'")
	-- Show terminal buffers
	vim.cmd(
		"let g:airline#extensions#tabline#ignore_bufadd_pat = 'defx|gundo|nerd_tree|startify|tagbar|undotree|vimfiler'"
	)
end

-----------
-- nerdtree
-----------

function M.nerdtree()
	local map = vim.keymap.set
	vim.cmd("let NERDTreeShowHidden=1")
	map("n", "<F7>", ":NERDTreeToggle<CR>")
	map("n", "<F8>", ":NERDTreeFind<CR>")
	-- Change current dir to current file
	vim.cmd("nnoremap <leader>cd :cd %:p:h<CR>:NERDTreeCWD<CR>")
end

------------
-- telescope
------------

function M.telescope()
	local map = vim.keymap.set
	local cmd = vim.api.nvim_create_user_command
	-- https://github.com/nvim-telescope/telescope.nvim#file-pickers
	local t = require("telescope.builtin")
	map("n", "<C-p>", t.find_files)
	map("n", "<C-f>", t.buffers)
	map("n", "<leader>hi", t.oldfiles)
	map("n", "<leader>:", t.command_history)
	map("n", "<leader>j", t.current_buffer_fuzzy_find)
	map("n", "<localleader>c", t.commands) -- available commands
	map("n", "<localleader>s", t.lsp_document_symbols)
	map("n", "<localleader>g", t.live_grep)
	cmd("Options", t.vim_options, { bang = true })
	cmd("LiveGrep", t.live_grep, { bang = true })
	cmd("HelpTags", t.help_tags, { bang = true })
	cmd("ManPages", t.man_pages, { bang = true })
	cmd("Marks", t.marks, { bang = true })

	-- git
	cmd("Branch", t.git_branches, { bang = true }) -- Lists all branches with log preview, checkout action <cr>, track action <C-t> and rebase action<C-r>
	cmd("Commits", t.git_commits, { bang = true }) -- Lists git commits with diff preview, checkout action <cr>, reset mixed <C-r>m, reset soft <C-r>s and reset hard <C-r>h
	cmd("BufferCommits", t.git_bcommits, { bang = true }) -- Lists buffer's git commits with diff preview and checks them out on <cr>
	cmd("Diff", t.git_status, { bang = true }) -- Lists buffer's git commits with diff preview and checks them out on <cr>

	-- lsp https://github.com/nvim-telescope/telescope.nvim#neovim-lsp-pickers
	cmd("References", t.lsp_references, { bang = true })
	cmd("Diagnostics", t.diagnostics, { bang = true })
	cmd("IncomingCalls", t.lsp_incoming_calls, { bang = true })
	cmd("OutgoingCalls", t.lsp_outgoing_calls, { bang = true })
	cmd("DocumentSymbols", t.lsp_document_symbols, { bang = true })
	cmd("WorkspaceSymbols", t.lsp_workspace_symbols, { bang = true })
end

---------------
-- vim-fugitive
---------------

function M.vim_fugitive()
	local map = vim.keymap.set
	local cmd = vim.api.nvim_create_user_command
	map("n", "<leader>gs", ":tabnew | Git | only<cr>")
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
end

-----------
-- gitsigns
-----------

function M.gitsigns()
	require("gitsigns").setup()
end
----------------
-- vim-maximizer
----------------
function M.vim_maximizer()
	local map = vim.keymap.set

	map("n", "<leader>z", ":MaximizerToggle<CR>")
	map("x", "<leader>z", ":MaximizerToggle<CR>gv")
end

-------------
-- auto-pairs
-------------

function M.auto_pairs()
	vim.g.AutoPairsShortcutToggle = ""
	vim.g.AutoPairsMapCh = 0 -- don't map this one
end

--------------
-- vim-ripgrep
--------------

function M.vim_ripgrep()
	vim.g.rg_command = 'rg --vimgrep --pcre2 --type-add="scss:*.scss"'
end

---------------
-- auto-session
---------------

function M.auto_session()
	require("auto-session").setup({
		log_level = "info",
		auto_session_suppress_dirs = { "~/" },
		auto_session_enabled = false,
	})
end

----------
-- HowMuch
----------

function M.how_much()
	local map = vim.keymap.set
	vim.g.HowMuch_scale = 8
	map("n", "<leader>hm", "V<Plug>AutoCalcAppendWithEq")
	map("x", "<leader>hm", "<Plug>AutoCalcAppendWithEq")
	map("x", "<leader>hms", "<Plug>AutoCalcAppendWithEqAndSum")
	map("x", "<leader>hmr", "<Plug>AutoCalcReplace")
end

------------
-- text-case
------------

-- gau Upper case	LOREM IPSUM
-- gal Lower case	lorem ipsum
-- gas Snake case	lorem_ipsum
-- gad Dash case	lorem-ipsum
-- gan Constant case	LOREM_IPS
-- gad Dot case	lorem.ipsum
-- gaa Camel case	loremIpsum
-- gac Pascal case	LoremIpsum
-- gap Title case	Lorem Ipsum
-- gat Path case	lorem/ipsum
-- gaf Phrase case	Lorem ipsum
function M.text_case()
	require("textcase").setup({})
	require("telescope").load_extension("textcase")
	vim.api.nvim_set_keymap("n", "ga.", "<cmd>TextCaseOpenTelescope<CR>", { desc = "Telescope" })
	vim.api.nvim_set_keymap("v", "ga.", "<cmd>TextCaseOpenTelescope<CR>", { desc = "Telescope" })
end

------------
-- vim-slime
------------

function M.vim_slime()
	local map = vim.keymap.set
	vim.g.slime_target = "tmux"

	-- target_pane
	-- {last} current window, last pane,
	-- :.2 current window, second pane
	-- %pane_id get it with echo $TMUX_PANE
	vim.g.slime_no_mappings = 1
	map("x", "<F9>", "<Plug>SlimeRegionSend")
	map("n", "<F9>", "<Plug>SlimeParagraphSend")
end

----------
-- LuaSnip
----------

function M.lua_snip()
	local map = vim.keymap.set
	local cmd = vim.api.nvim_create_user_command
	-- https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#loaders
	require("luasnip.loaders.from_snipmate").lazy_load({ paths = { "./snippets/snipmate" } })
	-- https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#lua
	require("luasnip.loaders.from_lua").lazy_load({ paths = { "./snippets/luasnip" } })
	cmd("SnipEdit", require("luasnip.loaders").edit_snippet_files, { bang = true })

	-- jump on snippet positions
	local l = require("luasnip")
	map({ "s", "i" }, "<C-j>", function()
		if l.jumpable() then
			l.jump(1)
		end
	end)

	map({ "s", "i" }, "<C-k>", function()
		if l.jumpable() then
			l.jump(-1)
		end
	end)
end

return M
