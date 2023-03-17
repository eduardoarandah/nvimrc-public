-- ChatGPT
-- https://github.com/jackMort/ChatGPT.nvim
--
-- Install: Set environment variable called $OPENAI_API_KEY which you can obtain here: https://beta.openai.com/account/api-keys.
--
-- Commands:
--
-- ChatGPT command which opens interactive window.
-- ChatGPTActAs command which opens a prompt selection from Awesome ChatGPT Prompts to be used with the ChatGPT.
--
-- Keybindings:
-- <C-Enter> to submit.
-- <C-c> to close chat window.
-- <C-u> scroll up chat window.
-- <C-d> scroll down chat window.
-- <C-y> to copy/yank last answer.
-- <C-k> to copy/yank code from last answer.
-- <C-o> Toggle settings window.
-- <C-n> Start new session.
-- <Tab> Cycle over windows.
-- <C-i> [Edit Window] use response as input.

return {
  {
    "jackMort/ChatGPT.nvim",
    config = function()
      require("chatgpt").setup({
        -- configuration
        -- https://github.com/jackMort/ChatGPT.nvim#configuration
        keymaps = {
          close = { "<C-c>" },
          submit = "<F1>",
          yank_last = "<C-y>",
          yank_last_code = "<C-k>",
          scroll_up = "<C-u>",
          scroll_down = "<C-d>",
          toggle_settings = "<C-o>",
          new_session = "<C-n>",
          cycle_windows = "<Tab>",
          -- in the Sessions pane
          select_session = "<Space>",
          rename_session = "r",
          delete_session = "d",
        },
      })
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },
}
