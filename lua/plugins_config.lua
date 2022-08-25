local map = vim.keymap.set
local cmd = vim.api.nvim_create_user_command

--------------
-- lualine
--------------

map("n", "<leader>tr", ":LualineRenameTab ")

-----------
-- tree
-----------

map("n", "<F7>", ":NvimTreeToggle<CR>")
map("n", "<F8>", ":NvimTreeFindFile<CR>")
map("n", "<leader>cd", ":cd %:p:h | NvimTreeOpen<cr>")

------------
-- telescope
------------

map("n", "<C-p>", ":Telescope find_files<CR>")
map("n", "<C-f>", ":Telescope buffers<CR>")
map("n", "<leader>hi", ":Telescope oldfiles<CR>")
map("n", "<leader>:", ":Telescope command_history<CR>")
map("n", "<leader>j", ":Telescope live_grep<CR>")
map("n", "<leader><leader>", ":Telescope commands<CR>")
map("n", "<localleader>s", ":Telescope lsp_document_symbols<CR>")
map("n", "<localleader>g", ":Telescope live_grep<CR>")
cmd("Options", ":Telescope vim_options<CR>", { bang = true })
cmd("LiveGrep", ":Telescope live_grep<CR>", { bang = true })
cmd("HelpTags", ":Telescope help_tags<CR>", { bang = true })
cmd("ManPages", ":Telescope man_pages<CR>", { bang = true })
cmd("Marks", ":Telescope marks<CR>", { bang = true })

-- git
cmd("Branch", ":Telescope git_branches<CR>", { bang = true }) -- Lists all branches with log preview, checkout action <cr>, track action <C-t> and rebase action<C-r>
cmd("Commits", ":Telescope git_commits<CR>", { bang = true }) -- Lists git commits with diff preview, checkout action <cr>, reset mixed <C-r>m, reset soft <C-r>s and reset hard <C-r>h
cmd("BufferCommits", ":Telescope git_bcommits<CR>", { bang = true }) -- Lists buffer's git commits with diff preview and checks them out on <cr>
cmd("Diff", ":Telescope git_status<CR>", { bang = true }) -- Lists buffer's git commits with diff preview and checks them out on <cr>

-- lsp https://github.com/nvim-telescope/telescope.nvim#neovim-lsp-pickers
cmd("References", ":Telescope lsp_references<CR>", { bang = true })
cmd("Diagnostics", ":Telescope diagnostics<CR>", { bang = true })
cmd("IncomingCalls", ":Telescope lsp_incoming_calls<CR>", { bang = true })
cmd("OutgoingCalls", ":Telescope lsp_outgoing_calls<CR>", { bang = true })
cmd("DocumentSymbols", ":Telescope lsp_document_symbols<CR>", { bang = true })
cmd("WorkspaceSymbols", ":Telescope lsp_workspace_symbols<CR>", { bang = true })

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

----------
-- NeoZoom
----------

map("n", "<leader>z", ":NeoZoomToggle<cr>")

----------
-- HowMuch
----------

map("n", "<leader>hm", "V<Plug>AutoCalcAppendWithEq")
map("x", "<leader>hm", "<Plug>AutoCalcAppendWithEq")
map("x", "<leader>hms", "<Plug>AutoCalcAppendWithEqAndSum")
map("x", "<leader>hmr", "<Plug>AutoCalcReplace")

------------
-- text-case
-- https://github.com/johmsalas/text-case.nvim#setup
------------

map("n", "gau", function()
	require("textcase").current_word("to_upper_case")
end)
map("n", "gal", function()
	require("textcase").current_word("to_lower_case")
end)
map("n", "gas", function()
	require("textcase").current_word("to_snake_case")
end)
map("n", "gad", function()
	require("textcase").current_word("to_dash_case")
end)
map("n", "gan", function()
	require("textcase").current_word("to_constant_case")
end)
map("n", "gad", function()
	require("textcase").current_word("to_dot_case")
end)
map("n", "gaa", function()
	require("textcase").current_word("to_phrase_case")
end)
map("n", "gac", function()
	require("textcase").current_word("to_camel_case")
end)
map("n", "gap", function()
	require("textcase").current_word("to_pascal_case")
end)
map("n", "gat", function()
	require("textcase").current_word("to_title_case")
end)
map("n", "gaf", function()
	require("textcase").current_word("to_path_case")
end)

map("n", "gaU", function()
	require("textcase").lsp_rename("to_upper_case")
end)
map("n", "gaL", function()
	require("textcase").lsp_rename("to_lower_case")
end)
map("n", "gaS", function()
	require("textcase").lsp_rename("to_snake_case")
end)
map("n", "gaD", function()
	require("textcase").lsp_rename("to_dash_case")
end)
map("n", "gaN", function()
	require("textcase").lsp_rename("to_constant_case")
end)
map("n", "gaD", function()
	require("textcase").lsp_rename("to_dot_case")
end)
map("n", "gaA", function()
	require("textcase").lsp_rename("to_phrase_case")
end)
map("n", "gaC", function()
	require("textcase").lsp_rename("to_camel_case")
end)
map("n", "gaP", function()
	require("textcase").lsp_rename("to_pascal_case")
end)
map("n", "gaT", function()
	require("textcase").lsp_rename("to_title_case")
end)
map("n", "gaF", function()
	require("textcase").lsp_rename("to_path_case")
end)

map("n", "geu", function()
	require("textcase").operator("to_upper_case")
end)
map("n", "gel", function()
	require("textcase").operator("to_lower_case")
end)
map("n", "ges", function()
	require("textcase").operator("to_snake_case")
end)
map("n", "ged", function()
	require("textcase").operator("to_dash_case")
end)
map("n", "gen", function()
	require("textcase").operator("to_constant_case")
end)
map("n", "ged", function()
	require("textcase").operator("to_dot_case")
end)
map("n", "gea", function()
	require("textcase").operator("to_phrase_case")
end)
map("n", "gec", function()
	require("textcase").operator("to_camel_case")
end)
map("n", "gep", function()
	require("textcase").operator("to_pascal_case")
end)
map("n", "get", function()
	require("textcase").operator("to_title_case")
end)
map("n", "gef", function()
	require("textcase").operator("to_path_case")
end)

------------
-- vim-slime
------------

map("x", "<F9>", ":SlimeSend<CR>")
map("n", "<F9>", ":SlimeSend<CR>")

----------
-- LuaSnip
----------

-- commands
cmd("SnipEdit", function()
	require("luasnip.loaders").edit_snippet_files()
end, { bang = true })

-- jump on snippet positions
map({ "s", "i" }, "<C-j>", function()
	local l = require("luasnip")
	if l.jumpable() then
		l.jump(1)
	end
end)

map({ "s", "i" }, "<C-k>", function()
	local l = require("luasnip")
	if l.jumpable() then
		l.jump(-1)
	end
end)

--------
-- emmet
--------

map("i", ",,", "<C-y>,", { remap = true })
