return {
	-- AI completion
	{
		"Exafunction/codeium.vim",
		-- ft = { "javascript", "typescript", "php" },
		config = function()
			-- A global boolean flag that controls whether codeium completions are enabled or disabled by default.
			-- enable with :Codeium Enable
			vim.g.codeium_enabled = false

			-- A global boolean flag that controls whether codeium uses <TAB> for the mapping codeium#Accept
			vim.g.codeium_no_map_tab = true

			-- Change '<C-g>' here to any keycode you like.
			vim.keymap.set("i", "<C-j>", function()
				return vim.fn["codeium#Accept"]()
			end, { expr = true })

		end,
	},
}
