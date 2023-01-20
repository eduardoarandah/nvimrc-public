local map = vim.keymap.set
local cmd = vim.api.nvim_create_user_command

--------
-- theme
--------

-- dracula
vim.g.rehash256 = 1
vim.cmd("colorscheme dracula")

-- monokaipro
-- default the default Monokai Pro look
-- machine a variant with a bluish background
-- ristretto a variant with a red/brown background
-- octogon a variant with a purple/indigo background
-- spectrum a variant with a flat gray background
-- classic a variant based on original Monokai colors
-- vim.g.monokaipro_filter = "machine"
-- vim.cmd("colorscheme monokaipro")

--------------
-- lualine
--------------

local function git_username()
	local ssh_identity = vim.fn.systemlist(
		'if [[ "$(ssh-add -l)" == "The agent has no identities." ]]  then; echo "(no ssh identity)"; else; echo "(ssh identity: $(ssh-add -l | cut -f3 -d \' \'))"; fi'
	)
	local name = vim.fn.systemlist("git config user.name")
	local email = vim.fn.systemlist("git config user.email")
	return ssh_identity[1] .. " " .. name[1] .. " " .. email[1]
end

-- https://github.com/nvim-lualine/lualine.nvim#default-configuration
require("lualine").setup({
	sections = {
		lualine_x = { "encoding", "fileformat", "filetype" },
	},
})

map("n", "<leader>tr", ":LualineRenameTab ")

-- add/remove buffers from tabline
cmd("RemoveBuffersFromTabline", function()
	require("lualine").setup({ tabline = { lualine_a = {} } })
end, { bang = true })

cmd("AddBuffersFromTabline", function()
	require("lualine").setup({ tabline = { lualine_a = { "buffers" } } })
end, { bang = true })

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
map("n", "<leader>p", ":Telescope registers<CR>")
map("n", "<leader><leader>", ":Telescope commands<CR>")
map("n", "<localleader>s", ":Telescope lsp_document_symbols<CR>")
map("n", "<localleader>g", ":Telescope live_grep<CR>")
cmd("Options", ":Telescope vim_options", { bang = true })
cmd("LiveGrep", ":Telescope live_grep", { bang = true })
cmd("HelpTags", ":Telescope help_tags", { bang = true })
cmd("ManPages", ":Telescope man_pages", { bang = true })
cmd("Marks", ":Telescope marks", { bang = true })
cmd("Registers", ":Telescope registers", { bang = true })

-- git
cmd("GBranch", ":Telescope git_branches", { bang = true }) -- Lists all branches with log preview, checkout action <cr>, track action <C-t> and rebase action<C-r>
cmd("GBufferCommits", ":Telescope git_bcommits", { bang = true }) -- Lists buffer's git commits with diff preview and checks them out on <cr>

-- lsp https://github.com/nvim-telescope/telescope.nvim#neovim-lsp-pickers
cmd("References", ":Telescope lsp_references", { bang = true })
cmd("Diagnostics", ":Telescope diagnostics", { bang = true })
cmd("IncomingCalls", ":Telescope lsp_incoming_calls", { bang = true })
cmd("OutgoingCalls", ":Telescope lsp_outgoing_calls", { bang = true })
cmd("DocumentSymbols", ":Telescope lsp_document_symbols", { bang = true })
cmd("WorkspaceSymbols", ":Telescope lsp_workspace_symbols", { bang = true })

-- Focus on current dir for fuzzy finding
local cmd = vim.api.nvim_create_user_command
cmd("FocusHere", function()
	-- get dir
	local current_dir = vim.fn.expand("%:h")

	-- remap fuzzy find
	vim.keymap.set("n", "<C-p>", function()
		require("telescope.builtin").find_files({
			cwd = current_dir,
		})
	end)

end, { bang = true })

---------------
-- vim-fugitive
---------------

map("n", "<leader>gs", ":tabnew<cr>:Git<cr>:only<cr>")
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

-------------
-- Table mode
-- https://github.com/dhruvasagar/vim-table-mode
-------------

vim.g.table_mode_map_prefix = "<localleader>t"

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

require("telescope").load_extension("textcase")
map("n", "ga.", "<cmd>TextCaseOpenTelescope<CR>", { desc = "Telescope" })
map("v", "ga.", "<cmd>TextCaseOpenTelescope<CR>", { desc = "Telescope" })

------------
-- vim-slime
------------

map("x", "<F1>", ":SlimeSend<CR>")
map("n", "<F1>", ":SlimeSend<CR>")

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

------------
-- syntax
------------

-- https://github.com/jwalton512/vim-blade

-- Define some single Blade directives. This variable is used for highlighting only.
vim.g.blade_custom_directives = { "datetime", "javascript", "error" }

-- Define pairs of Blade directives. This variable is used for highlighting and indentation.
vim.g.blade_custom_directives_pairs = {
	markdown = "endmarkdown",
	cache = "endcache",
	error = "enderror",
}
