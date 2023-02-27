local cmd = vim.api.nvim_create_user_command

local args = { bang = true }
local home = vim.fn.stdpath("config")

-- vimrc

cmd("Init", function()
	vim.cmd("edit " .. home .. "/init.lua")
end, args)

cmd("Reload", function()
	vim.cmd("luafile " .. home .. "/init.lua")
end, args)

cmd("ReloadCompile", function()
	vim.cmd("source % | PackerCompile")
end, args)

-- git report
cmd("Greport", require("greport").greport, args)

-- github prs
cmd("Gprfiles", function() vim.cmd("argadd `gh pr diff --name-only`") end, args)

-- Copy filename path
vim.api.nvim_create_user_command("CopyPath", function()
	vim.fn.setreg("*", vim.fn.expand("%"))
end, args)

-- Copy filename, line number and branch
-- example: src/filename.js +123 # branch master
vim.api.nvim_create_user_command("CopyPathLineNumberBranch", function()
	local branch = vim.fn.systemlist("git branch --show-current")
	local comment = ""
	if not string.find(branch[1], "not a git repository") then
		comment = " # branch " .. branch[1]
	end
	vim.fn.setreg("*", vim.fn.expand("%") .. " +" .. vim.api.nvim_win_get_cursor(0)[1] .. comment)
end, args)

-- Search on relevant directories

cmd("Clientes", function()
	require("telescope.builtin").find_files({ cwd = "~/clientes" })
end, args)

cmd("Colegas", function()
	require("telescope.builtin").find_files({ cwd = "~/colegas" })
end, args)

cmd("Kb", function()
	require("telescope.builtin").find_files({ cwd = "~/kb" })
end, args)

cmd("Proyectos", function()
	require("telescope.builtin").find_files({ cwd = "~/proyectos" })
end, args)

cmd("Repos", function()
	require("telescope.builtin").find_files({ cwd = "~/repos" })
end, args)

cmd("Scripts", function()
	require("telescope.builtin").find_files({ cwd = "~/scripts" })
end, args)

-- custom dictionaries

cmd("DictBoostrap4", function()
	local dic = require("cmp_dictionary")
	-- Download boostrap and generate classes:
	-- curl -s https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.css | egrep '{' | egrep -o '\.[a-z0-9:-]+' | sed 's/\.//g' | sort -u > ~/.nvim/dict/bootstrap4
	dic.setup({ dic = { ["php,html,blade"] = { "~/.nvim/dict/bootstrap4" } } })
	dic.update()
end, args)

cmd("DictTailwind", function()
	local dic = require("cmp_dictionary")
	-- mkdir -p ~/.nvim/dict
	-- https://tailwindcss.com/docs/installation#using-tailwind-without-post-css
	-- npx tailwindcss-cli@latest build -o ~/.nvim/dict/tailwind.css
	-- cat ~/.nvim/dict/tailwind.css | egrep '{' | egrep -o '\.[a-z0-9:-]+' | sed 's/\.//g' | sort -u > ~/.nvim/dict/tailwind
	dic.setup({ dic = { ["php,html,blade"] = { "~/.nvim/dict/tailwind" } } })
	dic.update()
end, args)

-- json
cmd("JsonDecodeFormat", "%!jq -r | jq", args)

-- inspect tables easily
-- https://vonheikemen.github.io/devlog/es/tools/configuring-neovim-using-lua/
-- vim.keymap.set("n", "<F1>", 'yW:lua require"utils".wat(")<CR>') -- explore settings with F1
function Wat(key)
	print(vim.inspect(key))
end
