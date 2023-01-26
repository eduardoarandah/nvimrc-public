return {
	-- sql client
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			"tpope/vim-dadbod",
			"kristijanhusak/vim-dadbod-completion",
			"tpope/vim-dotenv",
		},
		cmd = { "DBUI" },
		config = function()
			vim.g.db_ui_use_nerd_fonts = 1
			vim.g.db_ui_show_database_icon = 1

			-- add autocompletion to cmp
			vim.cmd(
				"autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })"
			)

			-- use tpope/vim-dotenv to leverage .env variables like this:
			-- DB_CONNECTION=mysql
			-- DB_HOST=127.0.0.1
			-- DB_PORT=3306
			-- DB_DATABASE=mydbname
			-- DB_USERNAME=root
			-- DB_PASSWORD=asdf
			-- DB_UI_DEV="${DB_CONNECTION}://${DB_USERNAME}:${DB_PASSWORD}@127.0.0.1:${DB_PORT}/${DB_DATABASE}"
		end,
	},
}
