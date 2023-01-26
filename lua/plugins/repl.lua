-- REPL, send commands to another window
return {
	{
		"jpalardy/vim-slime",
		config = function()
			vim.g.slime_target = "tmux"

			-- target_pane
			-- {last} current window, last pane,
			-- :.2 current window, second pane
			-- %pane_id get it with echo $TMUX_PANE
			-- vim.g.slime_default_config = '{"socket_name": "default", "target_pane": "{last}"}'
			vim.g.slime_no_mappings = 1
		end,
	},
}
