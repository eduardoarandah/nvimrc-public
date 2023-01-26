return {

	-- Automatically create any non-existent directories before writing the buffer.
	"pbrisbin/vim-mkdir",

	-- Useful commands like :Delete
	"tpope/vim-eunuch",

	-- .editorconfig compatibilty
	"editorconfig/editorconfig-vim",

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

	-- fix things directly in quickfix list
	"stefandtw/quickfix-reflector.vim",

	-- Search with ripgrep :Rg
	{
		"jremmen/vim-ripgrep",
		cmd = { "Rg", "RgRoot" },
		config = function()
			vim.g.rg_command = 'rg --vimgrep --pcre2 --type-add="scss:*.scss"'
		end,
	},

	-- align things, example: Tabularize /,
	{
		"godlygeek/tabular",
		cmd = { "Tabularize" },
	},

	-- calculate
	{
		"sk1418/HowMuch",
		config = function()
			vim.g.HowMuch_scale = 8
		end,
	},
}
