-- add git details to status line
-- local function git_username()
-- 	local ssh_identity = vim.fn.systemlist(
-- 		'if [[ "$(ssh-add -l)" == "The agent has no identities." ]]  then; echo "(no ssh identity)"; else; echo "(ssh identity: $(ssh-add -l | cut -f3 -d \' \'))"; fi'
-- 	)
-- 	local name = vim.fn.systemlist("git config user.name")
-- 	local email = vim.fn.systemlist("git config user.email")
-- 	return ssh_identity[1] .. " " .. name[1] .. " " .. email[1]
-- end

return {
  -- status line / tabs
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = function()
      -- https://github.com/nvim-lualine/lualine.nvim#default-configuration
      local buffersTabsLayout = {
        lualine_a = {
          {
            "buffers",
            show_filename_only = true, -- Shows shortened relative path when set to false.
            mode = 2, -- filename only
            max_length = vim.o.columns * 2 / 3,
          },
        },
        lualine_z = {
          {
            "tabs",
            show_filename_only = true, -- Shows shortened relative path when set to false.
            mode = 2, -- filename only
            max_length = vim.o.columns * 1 / 3,
          },
        },
      }

      local tabsLayout = {
        lualine_a = {},
        lualine_z = {
          {
            "tabs",
            show_filename_only = true, -- Shows shortened relative path when set to false.
            mode = 2, -- filename only
            max_length = vim.o.columns, -- full width
          },
        },
      }

      -- setup
      require("lualine").setup({ tabline = buffersTabsLayout })

      -- rename tab
      vim.keymap.set("n", "<leader>tr", ":LualineRenameTab ")

      -- add/remove buffers from tabline
      vim.api.nvim_create_user_command("BuffersTabsLayout", function()
        require("lualine").setup({ tabline = buffersTabsLayout })
      end, { bang = true })

      vim.api.nvim_create_user_command("TabsLayout", function()
        require("lualine").setup({ tabline = tabsLayout })
      end, { bang = true })
    end,
  },
}
