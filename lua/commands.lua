---------------
-- Autocommands
---------------

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 120 })
	end,
	desc = "Highlight yank",
})

------------------
-- Custom commands
------------------

-- vimrc
vim.api.nvim_create_user_command("Editrc", function()
	vim.cmd("edit " .. vim.fn.stdpath("config") .. "/init.lua")
end, { bang = true })

vim.api.nvim_create_user_command("Reload", function()
	-- force reload
	package.loaded["settings"] = false
	package.loaded["mappings"] = false
	package.loaded["commands"] = false
	vim.cmd("source " .. vim.fn.stdpath("config") .. "/init.lua")
end, { bang = true })

-- git report
vim.api.nvim_create_user_command("Greport", require("greport").greport, { bang = true })

-- github prs
vim.api.nvim_create_user_command("Gprfiles", function()
	vim.cmd("argadd `gh pr diff --name-only`")
end, { bang = true })

-- Copy filename path
vim.api.nvim_create_user_command("CopyFullPath", function()
	vim.fn.setreg("*", vim.fn.expand("%:p"))
end, { bang = true })
vim.api.nvim_create_user_command("CopyRelativePath", function()
	vim.fn.setreg("*", vim.fn.expand("%:."))
end, { bang = true })
vim.api.nvim_create_user_command("CopyFileName", function()
	vim.fn.setreg("*", vim.fn.expand("%:t"))
end, { bang = true })

-- Copy filename, line number and branch
-- example: src/filename.js +123 # branch master
vim.api.nvim_create_user_command("CopyPathLineNumberBranch", function()
	local branch = vim.fn.systemlist("git branch --show-current")
	local comment = ""
	if not string.find(branch[1], "not a git repository") then
		comment = " # branch " .. branch[1]
	end
	vim.fn.setreg("*", vim.fn.expand("%") .. " +" .. vim.api.nvim_win_get_cursor(0)[1] .. comment)
end, { bang = true })

-- Search on relevant directories

vim.api.nvim_create_user_command("Clientes", function()
	require("telescope.builtin").find_files({ cwd = "~/clientes" })
end, { bang = true })

vim.api.nvim_create_user_command("Colegas", function()
	require("telescope.builtin").find_files({ cwd = "~/colegas" })
end, { bang = true })

vim.api.nvim_create_user_command("Kb", function()
	require("telescope.builtin").find_files({ cwd = "~/kb" })
end, { bang = true })

vim.api.nvim_create_user_command("Proyectos", function()
	require("telescope.builtin").find_files({ cwd = "~/proyectos" })
end, { bang = true })

vim.api.nvim_create_user_command("Repos", function()
	require("telescope.builtin").find_files({ cwd = "~/repos" })
end, { bang = true })

vim.api.nvim_create_user_command("Scripts", function()
	require("telescope.builtin").find_files({ cwd = "~/scripts" })
end, { bang = true })

-- custom dictionaries

vim.api.nvim_create_user_command("DictBoostrap4", function()
	local dic = require("cmp_dictionary")
	-- Download boostrap and generate classes:
	-- curl -s https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.css | egrep '{' | egrep -o '\.[a-z0-9:-]+' | sed 's/\.//g' | sort -u > ~/.nvim/dict/bootstrap4
	dic.setup({ dic = { ["php,html,blade"] = { "~/.nvim/dict/bootstrap4" } } })
	dic.update()
end, { bang = true })

vim.api.nvim_create_user_command("DictTailwind", function()
	local dic = require("cmp_dictionary")
	-- mkdir -p ~/.nvim/dict
	-- https://tailwindcss.com/docs/installation#using-tailwind-without-post-css
	-- npx tailwindcss-cli@latest build -o ~/.nvim/dict/tailwind.css
	-- cat ~/.nvim/dict/tailwind.css | egrep '{' | egrep -o '\.[a-z0-9:-]+' | sed 's/\.//g' | sort -u > ~/.nvim/dict/tailwind
	dic.setup({ dic = { ["php,html,blade"] = { "~/.nvim/dict/tailwind" } } })
	dic.update()
end, { bang = true })

-- json
vim.api.nvim_create_user_command("JsonDecodeFormat", "%!jq -r | jq", { bang = true })

-- inspect tables easily
-- https://vonheikemen.github.io/devlog/es/tools/configuring-neovim-using-lua/
-- vim.keymap.set("n", "<F1>", 'yW:lua require"utils".wat(")<CR>') -- explore settings with F1
function Wat(key)
	print(vim.inspect(key))
end

-------------------------------------------
-- capture work days using frontmatter spec
-------------------------------------------

-- New work document
vim.api.nvim_create_user_command("AddWorkLog", function()
	local today = os.date("%Y-%m-%d")
	-- Create folder if not exists
	vim.fn.mkdir("logs", "p")
	vim.cmd(":edit logs/" .. today .. ".md")
	-- Add template
	vim.api.nvim_buf_set_lines(0, 0, 0, false, {
		"---",
		"date: " .. today,
		"from: eduardo",
		"hours:",
		"summary:",
		"---",
		"",
	})
end, { bang = true })

-- Copy hours
vim.api.nvim_create_user_command("GetWorkLogInCurrentFile", function()
	-- clean register z
	vim.cmd("let @z=''")
	vim.cmd("g/\\C^date:\\|^hours:\\|^from:/y Z")
	vim.cmd("norm G")
	vim.cmd("put z")
end, { bang = true })

-- Get hours using repo https://github.com/eduardoarandah/worklog-extractor
vim.api.nvim_create_user_command("GetWorkLogInLogFolder", function()
	vim.cmd("read!node ~/repos/worklog-extractor/run.js")
end, { bang = true })
