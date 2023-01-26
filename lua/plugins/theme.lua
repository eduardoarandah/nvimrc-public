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

return {
	{
		"Mofiqul/dracula.nvim",
		config = function()
			vim.g.rehash256 = 1
			vim.api.nvim_cmd({
				cmd = "colorscheme",
				args = { "dracula" },
			}, {})
		end,
	},
}
