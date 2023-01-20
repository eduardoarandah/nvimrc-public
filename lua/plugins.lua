-- Run in command line to update packages without opening nvim
-- nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

-- Check requirements
local all_requirements = 1
for _, requirement in ipairs({ "git", "rg", "node", "npm" }) do
	if vim.fn.executable(requirement) == 0 then
		print("plugins require " .. requirement)
		all_requirements = 0
	end
end

if all_requirements == 0 then
	print("can't install plugins")
	return
end

-- Automatically install packer if not found on disk then set a local variable to show it's just installed
-- install path: print(vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim")
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
	vim.cmd([[packadd packer.nvim]])
end

-- Automatically resource and compile when this file is saved
-- vim.api.nvim_create_autocmd( "BufWritePost", {
--   group=vim.api.nvim_create_augroup('AutoCompilePlugins', { clear = true }),
--   pattern = "lua/plugins.lua,lua/plugins_config.lua",
--   command = "echo 'compiling...' | source % | PackerCompile"
-- })

return require("packer").startup(function(use)
	-- packer
	use("wbthomason/packer.nvim")

	------------
	-- Interface
	------------

	-- Theme
	use("Mofiqul/dracula.nvim")
	use("Dre-Bk201/monokai-pro.nvim")

	-- status line / tabs
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = function()
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
		end,
	})

	-- file explorer
	use({
		"kyazdani42/nvim-tree.lua",
		requires = {
			"kyazdani42/nvim-web-devicons", -- optional, for file icons
		},
		tag = "nightly", -- optional, updated every week.
		config = function()
			require("nvim-tree").setup({})
		end,
	})

	-- Automatically create any non-existent directories before writing the buffer.
	use("pbrisbin/vim-mkdir")

	-- show markers
	use({
		"chentoast/marks.nvim",
		config = function()
			require("marks").setup({})
		end,
	})

	-- show git diffs
	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({})
		end,
	})

	-- zoom in / out
	use({
		"nyngwang/NeoZoom.lua",
		opt = true, -- lazy load
		cmd = { "NeoZoomToggle" },
		config = function()
			require("neo-zoom").setup({
				width_ratio = 1,
				height_ratio = 1,
			})
		end,
	})

	------------
	-- IDE
	------------

	-- Syntax
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = function()
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
					"typescript",
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
		end,
	})

	use({
		"nvim-treesitter/playground",
		config = function()
			require("nvim-treesitter.configs").setup({
				playground = {
					enable = true,
					disable = {},
					updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
					persist_queries = false, -- Whether the query persists across vim sessions
					keybindings = {
						toggle_query_editor = "o",
						toggle_hl_groups = "i",
						toggle_injected_languages = "t",
						toggle_anonymous_nodes = "a",
						toggle_language_display = "I",
						focus_language = "f",
						unfocus_language = "F",
						update = "R",
						goto_node = "<cr>",
						show_help = "?",
					},
				},
			})
		end,
	})

	-- syntax: blade https://github.com/jwalton512/vim-blade
	use("jwalton512/vim-blade")

	-- Git
	use("tpope/vim-fugitive")

	-- Neogen Your Annotation Toolkit
	-- https://github.com/danymat/neogen
	-- Alternative: https://github.com/heavenshell/vim-jsdoc
	-- Alternative: https://github.com/kkoomen/vim-doge#supported-languages-and-doc-standards
	use({
		"danymat/neogen",
		config = function()
			require("neogen").setup({})
		end,
		requires = "nvim-treesitter/nvim-treesitter",
		-- Uncomment next line if you want to follow only stable versions
		-- tag = "*"
	})

	-- JSDoc
	-- https://github.com/heavenshell/vim-jsdoc
	-- Alternative: https://github.com/kkoomen/vim-doge#supported-languages-and-doc-standards
	use({
		"heavenshell/vim-jsdoc",
		ft = { "javascript", "javascript.jsx", "typescript" },
		run = "npm install",
	})

	use({
		"Exafunction/codeium.vim",
		config = function()
			vim.g.codeium_enabled = false
			-- Change '<C-g>' here to any keycode you like.
			vim.keymap.set("i", "<C-g>", function()
				return vim.fn["codeium#Accept"]()
			end, { expr = true })
		end,
	})

	--------------------------------------------------------------------------
	-- LSP installer
	-- Neovim plugin that allows you to seamlessly install LSP servers locally
	-- :LspInstallInfo - opens a graphical overview of your language servers
	-- https://github.com/williamboman/nvim-lsp-installer
	--------------------------------------------------------------------------

	use({
		"williamboman/nvim-lsp-installer",
		requires = {
			"neovim/nvim-lspconfig", -- A collection of common configurations for Neovim's built-in language server client.
			"nvim-treesitter/nvim-treesitter",
			"jose-elias-alvarez/typescript.nvim",
		},
		config = function()
			-- In order for nvim-lsp-installer to register the necessary hooks at the right moment, make sure you call the require("nvim-lsp-installer").setup() function before you set up any servers
			require("nvim-lsp-installer").setup({})

			-- now configure lspconfig https://github.com/neovim/nvim-lspconfig
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
			-- lsp.volar.setup({ on_attach = on_attach })
			lsp.yamlls.setup({ on_attach = on_attach })
			lsp.bashls.setup({ on_attach = on_attach })
			lsp.pylsp.setup({ on_attach = on_attach })
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
		end,
	})

	-----------------------------------------------------------------------------
	-- nvim-cmp
	-- A completion engine plugin for neovim written in Lua.
	-- Completion sources are installed from external repositories and "sourced".
	-- https://github.com/hrsh7th/nvim-cmp
	-----------------------------------------------------------------------------

	use({
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")

			-- fallback to be safe in case of plugins mappings  :h cmp-mapping
			local function next(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				else
					fallback()
				end
			end
			local function prev(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				else
					fallback()
				end
			end
			local function confirm_first(fallback)
				if cmp.visible() then
					cmp.confirm({ select = true })
				else
					fallback()
				end
			end

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
					["<CR>"] = confirm_first,
					["<tab>"] = confirm_first,
					["<C-n>"] = next,
					["<down>"] = next,
					["<C-p>"] = prev,
					["<up>"] = prev,
				},
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "nvim_lua" },
					{ name = "path" },
					{ name = "dictionary", keyword_length = 2 },
					{ name = "luasnip" },
					{
						name = "buffer",
						option = {
							max_indexed_line_length = 50, -- prevent super long line to be indexed
						},
					},
				}),
			})

			-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
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
		end,
	}) -- A completion engine plugin for neovim written in Lua.

	-- Completion sources
	local completion_sources = {
		"hrsh7th/cmp-nvim-lsp", -- nvim-cmp source for neovim's built-in language server client.
		"hrsh7th/cmp-buffer", -- nvim-cmp source for buffer words.
		"hrsh7th/cmp-path", -- nvim-cmp source for filesystem paths.
		"hrsh7th/cmp-cmdline", -- nvim-cmp source for vim's cmdline.
		"hrsh7th/cmp-nvim-lua", -- nvim-cmp source for neovim Lua API.
		"uga-rosa/cmp-dictionary", -- https://github.com/uga-rosa/cmp-dictionary
	}
	for _, plugin in ipairs(completion_sources) do
		use({
			plugin,
			requires = { "hrsh7th/nvim-cmp" },
		})
	end

	-- .editorconfig compatibilty
	use("editorconfig/editorconfig-vim")

	-- emmet
	use({
		"mattn/emmet-vim",
		opt = true, -- lazy load
		ft = { "html", "php", "blade", "jsx", "tsx", "vue", "css", "scss" },
	})

	----------
	-- Actions
	----------

	-- prettify
	use({
		"prettier/vim-prettier",
		opt = true, -- lazy load
		ft = { "html", "php", "blade", "jsx", "vue", "css", "scss", "typescript", "json", "markdown", "yaml" },
		cmd = { "Prettier", "PrettierAsync" },
		run = "npm install",
	})

	-- comment
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup({})
		end,
	})

	-- surround with ys
	use("tpope/vim-surround")

	-- auto pairs
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})

	-- change case https://github.com/johmsalas/text-case.nvim
	use({
		"johmsalas/text-case.nvim",
		config = function()
			require("textcase").setup({})
			require("telescope").load_extension("textcase")
			vim.api.nvim_set_keymap("n", "ga.", "<cmd>TextCaseOpenTelescope<CR>", { desc = "Telescope" })
			vim.api.nvim_set_keymap("v", "ga.", "<cmd>TextCaseOpenTelescope<CR>", { desc = "Telescope" })
		end,
	})

	-- docker remote
	-- This plugin aims to give you the functionality of VSCode's remote container development plugin. It will allow you to spawn and develop in docker containers and pulls config information from a devcontainer.json file.
	-- https://github.com/jamestthompson3/nvim-remote-containers
	use("jamestthompson3/nvim-remote-containers")

	--------------
	-- Find things
	--------------

	-- Telescope fuzzy finder
	use({
		"nvim-telescope/telescope.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({
				-- telescope.defaults.preview
				-- defaults = {
				-- 	preview = false,
				-- },
			})
		end,
	})

	-- Search with ripgrep :Rg
	use({
		"jremmen/vim-ripgrep",
		opt = true, -- lazy load
		cmd = { "Rg", "RgRoot" },
		config = function()
			vim.g.rg_command = 'rg --vimgrep --pcre2 --type-add="scss:*.scss"'
		end,
	})

	-----------
	-- snippets
	-----------

	-- Snippets luasnip
	use({
		"L3MON4D3/LuaSnip",
		config = function()
			require("luasnip").config.setup({
				update_events = "TextChanged,TextChangedI", -- change on every keystroke
			})
			-- https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#loaders
			require("luasnip.loaders.from_snipmate").lazy_load({ paths = { "./snippets/snipmate" } })
			-- https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#lua
			require("luasnip.loaders.from_lua").lazy_load({ paths = { "./snippets/luasnip" } })
		end,
	})
	use({
		"saadparwaiz1/cmp_luasnip",
		requires = {
			"L3MON4D3/LuaSnip",
			"hrsh7th/nvim-cmp",
		},
	})

	----------------
	-- lang specific
	----------------

	-- lua format
	use({
		"andrejlevkovitch/vim-lua-format",
		opt = true, -- lazy load
		ft = { "lua" },
	})

	-- Css Color
	use({
		"ap/vim-css-color",
		ft = { "css", "scss" },
	})

	-- Markdown
	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app && npm install",
		setup = function()
			vim.g.mkdp_filetypes = { "markdown" }
			vim.g.mkdp_markdown_css = vim.fn.stdpath("config") .. "/assets/markdown.css"
		end,
		opt = true,
		ft = { "markdown" },
	})

	--------
	-- utils
	--------

	-- Useful commands like :Delete
	use("tpope/vim-eunuch")

	-- fix things in quickfix list
	use("stefandtw/quickfix-reflector.vim")

	-- align in | with :Tabularize /|
	use({
		"godlygeek/tabular",
		opt = true, -- lazy load
		cmd = { "Tabularize" },
	})

	-- REPL, send commands to another window
	use({
		"jpalardy/vim-slime",
		config = function()
			vim.g.slime_target = "tmux"
			vim.cmd('let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}')

			-- target_pane
			-- {last} current window, last pane,
			-- :.2 current window, second pane
			-- %pane_id get it with echo $TMUX_PANE
			vim.g.slime_no_mappings = 1
		end,
	})

	-- calculate
	use({
		"sk1418/HowMuch",
		config = function()
			vim.g.HowMuch_scale = 8
		end,
	})

	-- table mode
	use({ "dhruvasagar/vim-table-mode" })

	-- sql client
	use({
		"kristijanhusak/vim-dadbod-ui",
		requires = {
			"tpope/vim-dadbod",
			"kristijanhusak/vim-dadbod-completion",
			"tpope/vim-dotenv",
		},
		opt = true, -- lazy load
		cmd = { "DBUI" },
		config = function()
			vim.g.db_ui_use_nerd_fonts = 1
			vim.g.db_ui_show_database_icon = 1

			-- add autocompletion to cmp
			vim.cmd(
				[[autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })]]
			)
			-- use tpope/vim-dotenv to leverage .env variables like this:
			-- DB_CONNECTION=mysql
			-- DB_HOST=127.0.0.1
			-- DB_PORT=3306
			-- DB_DATABASE=mydbname
			-- DB_USERNAME=root
			-- DB_PASSWORD=asdf
			-- DB_UI_DEV="${DB_CONNECTION}://${DB_USERNAME}:${DB_PASSWORD}@127.0.0.1:${DB_PORT}/${DB_DATABASE}"
		end,
	})
	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_just_installed then
		require("packer").sync()
	end
end)
