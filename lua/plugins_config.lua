local M = {}

---------
-- dracula
----------

function M.dracula()
	vim.cmd("colorscheme dracula")
	vim.g.rehash256 = 1
end

--------------
-- lualine
--------------

function M.lualine()
	require("lualine").setup({
		tabline = {
			lualine_a = { "buffers" },
			lualine_z = {
				{
					"tabs",
					mode = 2,
					max_length = vim.o.columns, -- full width
				},
			},
		},
	})
	local map = vim.keymap.set
	map("n", "<leader>tr", ":LualineRenameTab ")
end

-----------
-- tree
-----------

function M.nvim_tree()
	require("nvim-tree").setup()
	local map = vim.keymap.set
	local cmd = vim.api.nvim_create_user_command
	map("n", "<F7>", ":NvimTreeToggle<CR>")
	map("n", "<F8>", ":NvimTreeFindFile<CR>")
	cmd("NvimTreeDefaultMappings", function()
		vim.cmd("help nvim-tree-default-mappings")
	end, { bang = true })
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
	map("n", "<leader>j", function()
		require("telescope.builtin").live_grep({ grep_open_files = true })
	end)

	map("n", "<leader><leader>", t.commands)
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

----------
-- NeoZoom
----------
function M.neozoom()
	local map = vim.keymap.set
	require("neo-zoom").setup({
		width_ratio = 1,
		height_ratio = 1,
	})
	map("n", "<leader>z", require("neo-zoom").neo_zoom)
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
-- https://github.com/johmsalas/text-case.nvim#setup
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
	local map = vim.keymap.set
	local operator = require("textcase").operator
	map("n", "ga.", "<cmd>TextCaseOpenTelescope<CR>", { desc = "Telescope" })
	map("v", "ga.", "<cmd>TextCaseOpenTelescope<CR>", { desc = "Telescope" })
	map("n", "gau", function()
		operator("to_upper_case")
	end)
	map("n", "gal", function()
		operator("to_lower_case")
	end)
	map("n", "gas", function()
		operator("to_snake_case")
	end)
	map("n", "gad", function()
		operator("to_dash_case")
	end)
	map("n", "gan", function()
		operator("to_constant_case")
	end)
	map("n", "gad", function()
		operator("to_dot_case")
	end)
	map("n", "gaa", function()
		operator("to_phrase_case")
	end)
	map("n", "gac", function()
		operator("to_camel_case")
	end)
	map("n", "gap", function()
		operator("to_pascal_case")
	end)
	map("n", "gat", function()
		operator("to_title_case")
	end)
	map("n", "gaf", function()
		operator("to_path_case")
	end)
end

------------
-- vim-slime
------------

function M.vim_slime()
	local map = vim.keymap.set
	vim.g.slime_target = "tmux"
	vim.cmd('let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}')

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
	local l = require("luasnip")
	local map = vim.keymap.set
	local cmd = vim.api.nvim_create_user_command

	-- configs
	l.config.setup({
		update_events = "TextChanged,TextChangedI", -- change on every keystroke
	})

	-- loaders
	-- https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#loaders
	require("luasnip.loaders.from_snipmate").lazy_load({ paths = { "./snippets/snipmate" } })
	-- https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#lua
	require("luasnip.loaders.from_lua").lazy_load({ paths = { "./snippets/luasnip" } })

	-- commands
	cmd("SnipEdit", require("luasnip.loaders").edit_snippet_files, { bang = true })

	-- jump on snippet positions
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

-------------
-- treesitter
-------------

function M.treesitter()
	require("nvim-treesitter.configs").setup({
		ensure_installed = {
			"bash",
			"css",
			"html",
			"javascript",
			"json",
			"jsonc",
			"lua",
			"php",
			"python",
			"regex",
			"ruby",
			"tsx",
			"vue",
			"yaml",
		}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
		highlight = {
			enable = true,
		},
		indent = {
			enable = true,
		},
		context_commentstring = {
			enable = true,
		},
	})
end

-----------------------------------------------------------------------------
-- nvim-cmp
-- A completion engine plugin for neovim written in Lua.
-- Completion sources are installed from external repositories and "sourced".
-- https://github.com/hrsh7th/nvim-cmp
-----------------------------------------------------------------------------

function M.cmp()
	local cmp = require("cmp")
	local cmd = vim.api.nvim_create_user_command

	cmp.setup({
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
			end,
		},
		mapping = {
			["<C-e>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
			["<C-y>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
			["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
			-- fallback to be safe in case of plugins mappings  :h cmp-mapping
			["<CR>"] = function(fallback)
				if cmp.visible() then
					cmp.confirm({ select = true })
				else
					fallback()
				end
			end,
			["<tab>"] = function(fallback)
				if cmp.visible() then
					cmp.confirm({ select = true })
				else
					fallback()
				end
			end,
			["<C-n>"] = function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				else
					fallback()
				end
			end,
			["<down>"] = function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				else
					fallback()
				end
			end,
			["<C-p>"] = function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				else
					fallback()
				end
			end,
			["<up>"] = function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				else
					fallback()
				end
			end,
		},
		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			{ name = "nvim_lua" },
			{ name = "buffer" },
			{ name = "path" },
			{ name = "dictionary", keyword_length = 2 },
			{ name = "luasnip" },
		}),
	})

	-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline("/", {
		sources = {
			{ name = "buffer" },
		},
	})

	-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline(":", {
		sources = cmp.config.sources({
			{ name = "path" },
		}, {
			{ name = "cmdline" },
		}),
	})

	---------------------------------------------
	-- dictionary
	-- https://github.com/uga-rosa/cmp-dictionary
	---------------------------------------------

	require("cmp_dictionary").setup({
		dic = {},
		async = true,
		debug = false,
	})
end

--------------------------------------------------------------------------
-- LSP installer
-- Neovim plugin that allows you to seamlessly install LSP servers locally
-- :LspInstallInfo - opens a graphical overview of your language servers
-- https://github.com/williamboman/nvim-lsp-installer
--------------------------------------------------------------------------

function M.lsp_installer()
	require("nvim-lsp-installer").setup({
		ensure_installed = {
			"cssls",
			"eslint",
			"intelephense",
			"jsonls",
			"tailwindcss",
			"tsserver",
			"vimls",
			"vuels",
			"yamlls",
			"sumneko_lua",
			"html",
		},
	})
end

--------------------------------------------------------------------------------------
-- LSP config
-- A collection of common configurations for Neovim's built-in language server client.
-- https://github.com/neovim/nvim-lspconfig
-- See also :help lspconfig.
--------------------------------------------------------------------------------------

function M.lsp_config()
	local on_attach = function(_, bufnr)
		vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
		local map = vim.keymap.set
		local cmd = vim.api.nvim_create_user_command
		local b = vim.lsp.buf
		local d = vim.diagnostic
		map("n", "<localleader>D", b.declaration)
		map("n", "<localleader>d", b.definition)
		map("n", "K", b.hover)
		map("n", "<localleader>i", b.implementation)
		map("n", "<localleader>k", b.signature_help)
		map("n", "<localleader>D", b.type_definition)
		map("n", "<localleader>r", b.rename)
		map("n", "<localleader>a", b.code_action)
		map("n", "<localleader>o", d.open_float)
		map("n", "[d", d.goto_prev)
		map("n", "]d", d.goto_next)
		cmd("LspFormat", b.formatting, { bang = true })
		cmd("LspReferences", b.references, { bang = true })
		cmd("LspSetqflist", d.setqflist, { bang = true })
		cmd("LspWorkspaceAdd", b.add_workspace_folder, { bang = true })
		cmd("LspWorkspaceRemove", b.remove_workspace_folder, { bang = true })
		cmd("LspWorkspaceList", function()
			print(vim.inspect(b.list_workspace_folders()))
		end, { bang = true })
	end

	local lsp = require("lspconfig")
	lsp.cssls.setup({ on_attach = on_attach })
	lsp.eslint.setup({ on_attach = on_attach })
	lsp.html.setup({ on_attach = on_attach })
	lsp.intelephense.setup({ on_attach = on_attach })
	lsp.jsonls.setup({ on_attach = on_attach })
	lsp.tailwindcss.setup({ on_attach = on_attach })
	lsp.tsserver.setup({ on_attach = on_attach })
	lsp.vimls.setup({ on_attach = on_attach })
	lsp.vuels.setup({ on_attach = on_attach })
	lsp.yamlls.setup({ on_attach = on_attach })
	lsp.sumneko_lua.setup({
		on_attach = on_attach,
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" }, -- Get the language server to recognize the `vim` global
				},
			},
		},
	})

	-- typescript
	-- https://github.com/jose-elias-alvarez/typescript.nvim
	require("typescript").setup({
		server = { -- pass options to lspconfig's setup method
			on_attach = on_attach,
		},
	})
end

function M.emmet()
	-- expand automatically
	vim.keymap.set("i", ",,", "<C-y>,", { remap = true })
end

return M
