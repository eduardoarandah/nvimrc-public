-- https://dev.to/2nit/how-to-write-neovim-plugins-in-lua-5cca
local function build_floating_buffer()
	local api = vim.api
	local buf = api.nvim_create_buf(false, true) -- create new emtpy buffer

	api.nvim_buf_set_option(buf, "bufhidden", "wipe")
	api.nvim_buf_set_option(buf, "filetype", "git")

	-- get dimensions
	local width = api.nvim_get_option("columns")
	local height = api.nvim_get_option("lines")

	-- calculate our floating window size
	local win_height = math.ceil(height * 0.8 - 4)
	local win_width = math.ceil(width * 0.8)

	-- and its starting position
	local row = math.ceil((height - win_height) / 2 - 1)
	local col = math.ceil((width - win_width) / 2)

	-- set some options
	local opts = {
		style = "minimal",
		relative = "editor",
		width = win_width,
		height = win_height,
		row = row,
		col = col,
		border = "double",
	}
	-- and finally create it with buffer attached
	api.nvim_open_win(buf, true, opts)
	return buf
end

local function add_branch_to_buffer(buf)
	local branch = vim.fn.systemlist("git branch --show-current")
	local title = "branch: " .. branch[1]
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, { title, string.rep("-", string.len(title)), "" })
end

-- we will use vim systemlist function which run shell command and return result as list
local function add_log_to_buffer(buf)
	if vim.b.greport_number == nil then
		vim.b.greport_number = 0
	end

	local log = vim.fn.systemlist("git log --name-only -n 1 --skip " .. vim.b.greport_number)
	vim.api.nvim_buf_set_lines(buf, 3, -1, false, log)
end

local function add_mappings_to_buffer(buf)
	local opts = { nowait = true, noremap = true, silent = true }
	vim.api.nvim_buf_set_keymap(buf, "n", "<up>", ":lua require'greport'.next()<cr>", opts)
	vim.api.nvim_buf_set_keymap(buf, "n", "<down>", ":lua require'greport'.prev()<cr>", opts)
end

local function prev()
	vim.b.greport_number = vim.b.greport_number + 1
	add_log_to_buffer(0) -- 0 is current buffer
end

local function next()
	if vim.b.greport_number > 0 then
		vim.b.greport_number = vim.b.greport_number - 1
		add_log_to_buffer(0) -- 0 is current buffer
	end
end

local function greport()
	local buf = build_floating_buffer()
	add_branch_to_buffer(buf)
	add_log_to_buffer(buf)
	add_mappings_to_buffer(buf)
end

return {
	greport = greport,
	prev = prev,
	next = next,
}
