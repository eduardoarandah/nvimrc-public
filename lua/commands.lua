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

cmd("SaveCompile", function()
	vim.cmd("luafile % || PackerCompile")
end, args)

-- git report

cmd("Greport", require("greport").greport, args)

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
