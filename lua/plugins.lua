-- Run in command line to update packages without opening nvim
-- nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

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
	vim.cmd([[packadd packer.nvim]])
end

-- Automatically resource and compile when this file is saved
-- vim.api.nvim_create_autocmd( "BufWritePost", {
--   group=vim.api.nvim_create_augroup('AutoCompilePlugins', { clear = true }),
--   pattern = "lua/plugins.lua,lua/plugins_config.lua",
--   command = "echo 'compiling...' | source % | PackerCompile"
-- })

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
	use({
		"williamboman/nvim-lsp-installer",
		requires = {
			"neovim/nvim-lspconfig", -- A collection of common configurations for Neovim's built-in language server client.
			"nvim-treesitter/nvim-treesitter",
			"jose-elias-alvarez/typescript.nvim",
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

	-- emmet
	use({
		"mattn/emmet-vim",
		opt = true, -- lazy load
		ft = { "html", "php", "blade", "jsx", "tsx", "vue", "css", "scss" },
		config = conf.emmet,
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
	use({
		"jremmen/vim-ripgrep",
		opt = true, -- lazy load
		cmd = { "Rg", "RgRoot" },
		config = conf.vim_ripgrep,
	})

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
		opt = true, -- lazy load
		cmd = { "SlimeConfig", "SlimeSend" },
		config = conf.vim_slime,
	})

	-- calculate
	use({
		"sk1418/HowMuch",
		opt = true, -- lazy load
		ft = { "markdown", "txt", "" },
		config = conf.how_much,
	})

	-- sql client
	use({
		"kristijanhusak/vim-dadbod-ui",
		requires = {
			"tpope/vim-dadbod",
			"kristijanhusak/vim-dadbod-completion",
			"tpope/vim-dotenv",
		},
		config = conf.dadbodui,
		opt = true, -- lazy load
		cmd = { "DBUI" },
	})
	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_just_installed then
		require("packer").sync()
	end
end)
