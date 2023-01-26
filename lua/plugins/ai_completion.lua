return {
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
}
