local cmd = vim.api.nvim_create_user_command
local args = { bang = true }
local home = vim.fn.stdpath("config")
local vimscript = vim.cmd

-- vimrc

cmd("Init", function()
	vimscript("edit " .. home .. "/init.lua")
end, args)

cmd("Reload", function()
	vimscript("luafile " .. home .. "/init.lua")
end, args)

-- git report

cmd("Greport", require("greport").greport, args)

-- copy file path and line name
cmd("CopyPathAndLineNumber", function()
	vim.fn.setreg("*", vim.fn.expand("%") .. " +" .. vim.api.nvim_win_get_cursor(0)[1])
end, args)

-- Search on relevant directories

local tfind = require("telescope.builtin").find_files

cmd("Clientes", function()
	tfind({ cwd = "~/clientes" })
end, args)

cmd("Colegas", function()
	tfind({ cwd = "~/colegas" })
end, args)

cmd("Conocimiento", function()
	tfind({ cwd = "~/conocimiento" })
end, args)

cmd("Proyectos", function()
	tfind({ cwd = "~/proyectos" })
end, args)

cmd("Repos", function()
	tfind({ cwd = "~/repos" })
end, args)

cmd("Scripts", function()
	tfind({ cwd = "~/scripts" })
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
