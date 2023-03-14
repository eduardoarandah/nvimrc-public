-- add git details to status line
-- local function git_username()
-- 	local ssh_identity = vim.fn.systemlist(
-- 		'if [[ "$(ssh-add -l)" == "The agent has no identities." ]]  then; echo "(no ssh identity)"; else; echo "(ssh identity: $(ssh-add -l | cut -f3 -d \' \'))"; fi'
-- 	)
-- 	local name = vim.fn.systemlist("git config user.name")
-- 	local email = vim.fn.systemlist("git config user.email")
-- 	return ssh_identity[1] .. " " .. name[1] .. " " .. email[1]
-- end

local function config()
	local map = vim.keymap.set
	local cmd = vim.api.nvim_create_user_command
	map("n", "<leader>tr", ":LualineRenameTab ")

	-- add/remove buffers from tabline
	cmd("RmBuffersFromTabline", function()
		require("lualine").setup({ tabline = { lualine_a = {} } })
	end, { bang = true })

	cmd("AddBuffersFromTabline", function()
		require("lualine").setup({ tabline = { lualine_a = { "buffers" } } })
	end, { bang = true })
end

return {
	-- status line / tabs
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "kyazdani42/nvim-web-devicons" },
		config = function()
			-- https://github.com/nvim-lualine/lualine.nvim#default-configuration
			require("lualine").setup({
				tabline = {
					lualine_a = {}, -- "buffers"
					lualine_z = {
						{
							"tabs",
							mode = 2,
							max_length = vim.o.columns, -- full width
						},
					},
				},
				sections = {
					lualine_x = { "encoding", "fileformat", "filetype" },
				},
			})
			config()
		end,
	},
}
