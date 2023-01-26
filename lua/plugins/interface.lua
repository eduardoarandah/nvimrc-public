return {

	-- show markers
	"chentoast/marks.nvim",

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
}
