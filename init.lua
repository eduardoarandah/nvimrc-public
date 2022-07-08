-- update:
-- :PackerSync
-- :TSUpdate
-- :LspInstallInfo
require("settings")
require("mappings")
require("commands")
require("plugins")
require("syntax")
require("completion")
require("lsp")
local rtp = vim.fn.stdpath("config")
vim.cmd("source " .. rtp .. "/commands.vim")


 -- Douglas Massolari, [7 jul 2022 17:06:32]:
 -- You do the same thing in lua as you do in vimscript, but calling vimscript functions with vim.fn
 -- When you need to do something thatÕs not related to vim like merging two tables, you have vim.tbl_extend , you can check these help functions in :help lua-vim
 --
 -- So, when you need getpos(Ò.Ó) you do vim.fn.getpos(Ò.Ó)
 --
 -- Also, you have lua methods like string.format , string.gmatch etc
 -- You can check these here http://www.lua.org/manual/5.3/contents.html#index
