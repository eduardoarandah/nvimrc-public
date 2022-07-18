local map = vim.keymap.set
local cmd = vim.api.nvim_create_user_command
local vimscript = vim.cmd
local g = vim.g

----------
-- dracula
----------

vimscript("colorscheme dracula")
g.rehash256 = 1

--------------
-- vim-airline
--------------

vimscript("let g:airline#extensions#tabline#enabled = 1")
-- Show just the filename
vimscript("let g:airline#extensions#tabline#fnamemod = ':t'")
-- Show terminal buffers
vimscript(
	"let g:airline#extensions#tabline#ignore_bufadd_pat = 'defx|gundo|nerd_tree|startify|tagbar|undotree|vimfiler'"
)

-----------
-- nerdtree
-----------

vimscript("let NERDTreeShowHidden=1")
map("n", "<F7>", ":NERDTreeToggle<CR>")
map("n", "<F8>", ":NERDTreeFind<CR>")
-- Change current dir to current file
vimscript("nnoremap <leader>cd :cd %:p:h<CR>:NERDTreeCWD<CR>")

------------
-- telescope
------------

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

---------------
-- vim-fugitive
---------------

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

-----------
-- gitsigns
-----------

require("gitsigns").setup()

----------------
-- vim-maximizer
----------------

map("n", "<leader>z", ":MaximizerToggle<CR>")
map("x", "<leader>z", ":MaximizerToggle<CR>gv")

-------------
-- auto-pairs
-------------

g.AutoPairsShortcutToggle = ""
g.AutoPairsMapCh = 0 -- don't map this one

--------------
-- vim-ripgrep
--------------

g.rg_command = 'rg --vimgrep --pcre2 --type-add="scss:*.scss"'

---------------
-- auto-session
---------------

require("auto-session").setup({
	log_level = "info",
	auto_session_suppress_dirs = { "~/" },
	auto_session_enabled = false,
})

----------
-- HowMuch
----------

g.HowMuch_scale = 8
map("n", "<leader>hm", "V<Plug>AutoCalcAppendWithEq")
map("x", "<leader>hm", "<Plug>AutoCalcAppendWithEq")
map("x", "<leader>hms", "<Plug>AutoCalcAppendWithEqAndSum")
map("x", "<leader>hmr", "<Plug>AutoCalcReplace")

-- vim-caser
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
vimscript([[
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

------------
-- vim-slime
------------

g.slime_target = "tmux"

-- target_pane
-- {last} current window, last pane,
-- :.2 current window, second pane
-- %pane_id get it with echo $TMUX_PANE
g.slime_no_mappings = 1
map("x", "<F9>", "<Plug>SlimeRegionSend")
map("n", "<F9>", "<Plug>SlimeParagraphSend")

----------
-- LuaSnip
----------

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
