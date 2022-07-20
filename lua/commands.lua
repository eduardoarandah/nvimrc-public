local cmd = vim.api.nvim_create_user_command

cmd("Greport", require("greport").greport, { bang = true })

-- brew install silicon
cmd("Silicon", function(opts)
	local lines = vim.api.nvim_buf_get_lines(0, opts.line1 - 1, opts.line2 + 1, false)
	vim.fn.system({
		"silicon",
		"--to-clipboard",
		"--theme",
		"gruvbox",
		"--background",
		"#D6D6D6",
		"--shadow-blur-radius",
		"5",
		"--shadow-offset-x",
		"10",
		"--shadow-offset-y",
		"8",
		"--pad-horiz",
		"40",
		"--pad-vert",
		"40",
		"--language",
		vim.bo.filetype,
	}, lines)
end, { range = true })
vim.keymap.set("x", "SS", ":Silicon<CR>")
