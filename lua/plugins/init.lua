return {
	------------
	-- Interface
	------------

	-- Theme

	-- monokaipro
	-- default the default Monokai Pro look
	-- machine a variant with a bluish background
	-- ristretto a variant with a red/brown background
	-- octogon a variant with a purple/indigo background
	-- spectrum a variant with a flat gray background
	-- classic a variant based on original Monokai colors
	-- vim.g.monokaipro_filter = "machine"
	-- vim.cmd("colorscheme monokaipro")

	{
		"Mofiqul/dracula.nvim",
		config = function()
			vim.g.rehash256 = 1
			vim.cmd("colorscheme dracula")
		end,
	},

	-- status line / tabs
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "kyazdani42/nvim-web-devicons" },
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
	},

	-- file explorer
	{
		"kyazdani42/nvim-tree.lua",
		dependencies = {
			"kyazdani42/nvim-web-devicons", -- optional, for file icons
		},
		config = true,
	},

	-- Automatically create any non-existent directories before writing the buffer.
	"pbrisbin/vim-mkdir",

	-- show markers
	"chentoast/marks.nvim",

	-- show git diffs
	"lewis6991/gitsigns.nvim",

	-- zoom in / out
	{
		"nyngwang/NeoZoom.lua",
		cmd = { "NeoZoomToggle" },
		config = function()
			require("neo-zoom").setup({
				width_ratio = 1,
				height_ratio = 1,
			})
		end,
	},

	------------
	-- IDE
	------------

	-- Syntax
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
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
	},

	-- syntax: blade https://github.com/jwalton512/vim-blade
	"jwalton512/vim-blade",

	-- Git
	"tpope/vim-fugitive",

	-- AI completion
	{
		"Exafunction/codeium.vim",
		config = function()
			vim.g.codeium_enabled = false
			-- Change '<C-g>' here to any keycode you like.
			vim.keymap.set("i", "<C-g>", function()
				return vim.fn["codeium#Accept"]()
			end, { expr = true })
		end,
	},

	-- Automatically install LSPs
	{
		"williamboman/mason.nvim",
		config = true,
	},
	-- Integrate mason with lspconfig
	{
		"williamboman/mason-lspconfig.nvim",
		config = true,
	},

	-- Additional typescript support
	"jose-elias-alvarez/typescript.nvim",

	-- Useful status updates for LSP
	{ "j-hui/fidget.nvim", config = true },

	-- LSP configuration
	-- https://github.com/neovim/nvim-lspconfig
	{
		"neovim/nvim-lspconfig",
		requires = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"jose-elias-alvarez/typescript.nvim",
			"j-hui/fidget.nvim",
		},

		config = function()
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
			-- lsp.vuels.setup({ on_attach = on_attach })
			lsp.volar.setup({ on_attach = on_attach })
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
	},

	-----------------------------------------------------------------------------
	-- nvim-cmp
	-- A completion engine plugin for neovim written in Lua.
	-- Completion sources are installed from external repositories and "sourced".
	-- https://github.com/hrsh7th/nvim-cmp
	-----------------------------------------------------------------------------

	{
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
	},
	-- A completion engine plugin for neovim written in Lua.

	-- Completion sources
	{ "hrsh7th/cmp-nvim-lsp", dependencies = { "hrsh7th/nvim-cmp" } }, -- nvim-cmp source for neovim's built-in language server client.
	{ "hrsh7th/cmp-buffer", dependencies = { "hrsh7th/nvim-cmp" } }, -- nvim-cmp source for buffer words.
	{ "hrsh7th/cmp-path", dependencies = { "hrsh7th/nvim-cmp" } }, -- nvim-cmp source for filesystem paths.
	{ "hrsh7th/cmp-cmdline", dependencies = { "hrsh7th/nvim-cmp" } }, -- nvim-cmp source for vim's cmdline.
	{ "hrsh7th/cmp-nvim-lua", dependencies = { "hrsh7th/nvim-cmp" } }, -- nvim-cmp source for neovim Lua API.
	{ "uga-rosa/cmp-dictionary", dependencies = { "hrsh7th/nvim-cmp" } }, -- https://github.com/uga-rosa/cmp-dictionary

	-- .editorconfig compatibilty
	"editorconfig/editorconfig-vim",

	-- emmet
	{
		"mattn/emmet-vim",
		ft = { "html", "php", "blade", "jsx", "tsx", "vue", "css", "scss" },
	},

	----------
	-- Actions
	----------

	-- prettify
	{
		"prettier/vim-prettier",
		ft = { "html", "php", "blade", "jsx", "vue", "css", "scss", "typescript", "json", "markdown", "yaml" },
		cmd = { "Prettier", "PrettierAsync" },
		build = "npm install",
	},

	-- comment
	{ "numToStr/Comment.nvim", config = true },

	-- surround with ys
	"tpope/vim-surround",

	-- auto pairs
	{ "windwp/nvim-autopairs", config = true },

	-- change case https://github.com/johmsalas/text-case.nvim
	{
		"johmsalas/text-case.nvim",
		config = true,
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
	},

	--------------
	-- Find things
	--------------

	-- Telescope fuzzy finder
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = true,
	},

	-- Search with ripgrep :Rg
	{
		"jremmen/vim-ripgrep",
		cmd = { "Rg", "RgRoot" },
		config = function()
			vim.g.rg_command = 'rg --vimgrep --pcre2 --type-add="scss:*.scss"'
		end,
	},

	-----------
	-- snippets
	-----------

	-- Snippets luasnip
	{
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
	},
	{
		"saadparwaiz1/cmp_luasnip",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"hrsh7th/nvim-cmp",
		},
	},

	----------------
	-- lang specific
	----------------

	-- Css Color
	{
		"ap/vim-css-color",
		ft = { "css", "scss" },
	},

	-- Markdown
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		config = function()
			vim.g.mkdp_filetypes = { "markdown" }
			vim.g.mkdp_markdown_css = vim.fn.stdpath("config") .. "/assets/markdown.css"
		end,
		ft = { "markdown" },
	},

	--------
	-- utils
	--------

	-- Useful commands like :Delete
	"tpope/vim-eunuch",

	-- fix things in quickfix list
	"stefandtw/quickfix-reflector.vim",

	-- align in | with :Tabularize /|
	{
		"godlygeek/tabular",
		cmd = { "Tabularize" },
	},

	-- REPL, send commands to another window
	{
		"jpalardy/vim-slime",
		config = function()
			vim.g.slime_target = "tmux"

			-- target_pane
			-- {last} current window, last pane,
			-- :.2 current window, second pane
			-- %pane_id get it with echo $TMUX_PANE
			vim.g.slime_default_config = '{"socket_name": "default", "target_pane": "{last}"}'
			vim.g.slime_no_mappings = 1
		end,
	},

	-- calculate
	{
		"sk1418/HowMuch",
		config = function()
			vim.g.HowMuch_scale = 8
		end,
	},

	-- table mode
	"dhruvasagar/vim-table-mode",

	-- sql client
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			"tpope/vim-dadbod",
			"kristijanhusak/vim-dadbod-completion",
			"tpope/vim-dotenv",
		},
		cmd = { "DBUI" },
		config = function()
			vim.g.db_ui_use_nerd_fonts = 1
			vim.g.db_ui_show_database_icon = 1

			-- add autocompletion to cmp
			vim.cmd(
				"autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })"
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
	},
}
