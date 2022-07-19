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
	use("wbthomason/packer.nvim")

	-- Syntax
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("sheerun/vim-polyglot")

	-- Theme
	use({ "Mofiqul/dracula.nvim", config = require("plugins_config").dracula })

	-- Status/tabline
	use({ "vim-airline/vim-airline", config = require("plugins_config").vim_airline })

	-- File explorer
	use({ "scrooloose/nerdtree", config = require("plugins_config").nerdtree })

	-- Comment lines
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})

	-- Telescope fuzzy finder
	use({
		"nvim-telescope/telescope.nvim",
		requires = { "nvim-lua/plenary.nvim", config = require("plugins_config").telescope },
	})

	-- Allow repeating for plugin mappings like surround
	use("tpope/vim-repeat")

	-- Surround with ys
	use("tpope/vim-surround")

	-- Git
	use({ "tpope/vim-fugitive", config = require("plugins_config").vim_fugitive })

	-- Shows a git diff in the sign column.
	use({ "lewis6991/gitsigns.nvim", config = require("plugins_config").gitsigns })

	-- Maximizes and restores the current window in Vim.
	use({ "szw/vim-maximizer", config = require("plugins_config").vim_maximizer })

	-- Auto close brackets
	use({ "jiangmiao/auto-pairs", config = require("plugins_config").auto_pairs })

	-- Search with ripgrep :Rg
	use({ "jremmen/vim-ripgrep", config = require("plugins_config").vim_ripgrep })

	-- session https://github.com/rmagatti/auto-session
	use({ "rmagatti/auto-session", config = require("plugins_config").auto_session })

	-- Useful commands
	use("tpope/vim-eunuch")

	-- Calculate simple formulas
	use({ "sk1418/HowMuch", config = require("plugins_config").how_much })

	-- Align in | with :Tabularize /|
	use("godlygeek/tabular")

	-- Display markers
	use("kshenoy/vim-signature")

	-- Css Color
	use({
		"ap/vim-css-color",
		ft = { "css", "scss" },
	})

	-- casing https://github.com/johmsalas/text-case.nvim
	use({ "johmsalas/text-case.nvim", config = require("plugins_config").text_case })

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
	use({ "jpalardy/vim-slime", config = require("plugins_config").vim_slime })

	-- editorconfig respect .editorconfig settings like indenting
	use("editorconfig/editorconfig-vim")

	-- lua format
	use("andrejlevkovitch/vim-lua-format")

	-- typescript
	use("jose-elias-alvarez/typescript.nvim")

	-- lsp
	use("neovim/nvim-lspconfig") -- A collection of common configurations for Neovim's built-in language server client.
	use({
		"williamboman/nvim-lsp-installer",
		requires = {
			"neovim/nvim-lspconfig",
		},
	}) -- Allows you to seamlessly install LSP servers locally

	-- Completion
	use("hrsh7th/nvim-cmp") -- A completion engine plugin for neovim written in Lua.

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

	-- Snippets ultisnips users.
	-- use("SirVer/ultisnips") -- UltiSnips is the ultimate solution for snippets in Vim
	-- use("quangnguyen30192/cmp-nvim-ultisnips") -- UltiSnips completion source for nvim-cmp

	-- Snippets luasnip
	use({ "L3MON4D3/LuaSnip", config = require("plugins_config").lua_snip })
	use({
		"saadparwaiz1/cmp_luasnip",
		requires = {
			"L3MON4D3/LuaSnip",
			"hrsh7th/nvim-cmp",
		},
	})

	-- fix things in quickfix list
	use("stefandtw/quickfix-reflector.vim")

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if do_packer_sync then
		require("packer").sync()
	end
end)
