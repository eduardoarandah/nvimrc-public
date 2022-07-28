-- Automatically install packer if not found on disk then set a local variable to show it's just installed
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local do_packer_sync = nil

if fn.empty(fn.glob(install_path)) > 0 then
	do_packer_sync = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
end

return require("packer").startup(function(use)
	local conf = require("plugins_config")

	-- packer
	use("wbthomason/packer.nvim")

	------------
	-- Interface
	------------

	-- Theme
	use({ "Mofiqul/dracula.nvim", config = conf.dracula })

	-- status line / tabs
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = conf.lualine,
	})

	-- file explorer
	use({
		"kyazdani42/nvim-tree.lua",
		requires = {
			"kyazdani42/nvim-web-devicons", -- optional, for file icons
		},
		tag = "nightly", -- optional, updated every week.
		config = conf.nvim_tree,
	})

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
			require("gitsigns").setup()
		end,
	})

	-- zoom in / out
	use({
		"nyngwang/NeoZoom.lua",
		config = conf.neozoom,
	})

	------------
	-- IDE
	------------

	-- Syntax
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate", config = conf.treesitter })

	-- Git
	use({ "tpope/vim-fugitive", config = conf.vim_fugitive })

	-- lsp
	use({ "neovim/nvim-lspconfig", config = conf.lsp_config }) -- A collection of common configurations for Neovim's built-in language server client.
	use({
		"williamboman/nvim-lsp-installer",
		requires = {
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		config = conf.lsp_installer,
	}) -- Allows you to seamlessly install LSP servers locally

	-- Completion
	use({ "hrsh7th/nvim-cmp", config = conf.cmp }) -- A completion engine plugin for neovim written in Lua.

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

	----------
	-- Actions
	----------

	-- prettify
	use({
		"prettier/vim-prettier",
		run = "yarn install",
	})

	-- comment
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
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
	use({ "johmsalas/text-case.nvim", config = conf.text_case })

	--------------
	-- Find things
	--------------

	-- Telescope fuzzy finder
	use({
		"nvim-telescope/telescope.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = conf.telescope,
	})

	-- Search with ripgrep :Rg
	use({ "jremmen/vim-ripgrep", config = conf.vim_ripgrep })

	-----------
	-- snippets
	-----------

	-- Snippets luasnip
	use({
		"L3MON4D3/LuaSnip",
		config = conf.lua_snip,
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

	-- typescript
	use("jose-elias-alvarez/typescript.nvim")

	-- lua format
	use("andrejlevkovitch/vim-lua-format")

	-- Css Color
	use({
		"ap/vim-css-color",
		ft = { "css", "scss" },
	})

	-- Markdown
	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app & yarn install",
	})

	--------
	-- utils
	--------

	-- Useful commands like :Delete
	use("tpope/vim-eunuch")

	-- fix things in quickfix list
	use("stefandtw/quickfix-reflector.vim")

	-- align in | with :Tabularize /|
	use("godlygeek/tabular")

	-- session https://github.com/rmagatti/auto-session
	use({ "rmagatti/auto-session", config = conf.auto_session })

	-- REPL, send commands to another window
	use({ "jpalardy/vim-slime", config = conf.vim_slime })

	-- calculate
	use({ "sk1418/HowMuch", config = conf.how_much })

	-- Automatically set up your configuration after cloning packer.nvim
	if do_packer_sync then
		require("packer").sync()
	end
end)
