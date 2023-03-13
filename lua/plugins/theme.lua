-- Theme

return {

	-- {
	-- 	"Mofiqul/dracula.nvim",
	-- 	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	-- 	priority = 1000, -- make sure to load this before all the other start plugins
	-- 	config = function()
	-- 		vim.g.rehash256 = 1
	-- 		vim.cmd([[
	--      colorscheme dracula
	--      " Missing highlight from theme on diffs
	--      " highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=green
	--      " highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=red
	--      highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=gray
	--      highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=orange
	--      ]])
	-- 	end,
	-- },

	-- monokaipro
	-- https://github.com/loctvl842/monokai-pro.nvim
	-- default the default Monokai Pro look
	-- machine a variant with a bluish background
	-- ristretto a variant with a red/brown background
	-- octogon a variant with a purple/indigo background
	-- spectrum a variant with a flat gray background
	-- classic a variant based on original Monokai colors
	-- vim.g.monokaipro_filter = "machine"
	-- vim.cmd("colorscheme monokaipro")

	{
		"loctvl842/monokai-pro.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("monokai-pro").setup({
				filter = "pro", -- classic | octagon | pro | machine | ristretto | spectrum
			})
			vim.cmd("colorscheme monokai-pro")

			-- Missing highlight from theme on diffs
      -- colors: https://github.com/loctvl842/monokai-pro.nvim/blob/master/lua/monokai-pro/colorscheme/palette/pro.lua
      -- https://lawlesscreation.github.io/hex-color-visualiser/
			vim.cmd([[
      " Added line
      highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=#a9dc76
      " Changed line
      highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=#78dce8
      " Deleted line
      highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=#ff6188
      " Changed text within a changed line
      highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=#fc9867
      ]])
		end,
	},
}
