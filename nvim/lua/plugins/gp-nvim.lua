return {
  "robitx/gp.nvim",
  config = function(_, opts)
    -- Only setup the plugin if OPENAI_API_KEY environment variable exists
    if vim.fn.getenv "OPENAI_API_KEY" ~= vim.NIL then
      require("gp").setup(opts)
      -- or setup with your own config (see Install > Configuration in Readme)
      -- require("gp").setup(config)
      -- shortcuts might be setup here (see Usage > Shortcuts in Readme)
    end
  end,
  dependencies = {
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            ["<Leader>a"] = {
              name = "Chat",
              ["t"] = {
                name = "Toggle",
                ["v"] = { "<cmd>GpChatToggle vsplit<cr>", "Toggle Vsplit" },
                ["s"] = { "<cmd>GpChatToggle split<cr>", "Toggle Split" },
                ["t"] = { "<cmd>GpChatToggle tabnew<cr>", "Toggle New Tab" },
                ["p"] = { "<cmd>GpChatToggle popup<cr>", "Toggle Popup" },
              },
              ["v"] = { "<cmd>GpChatToggle vsplit<cr>", "Toggle Vsplit" },
              ["f"] = { "<cmd>GpChatFinder<cr>", "Search History" },
              ["d"] = { "<cmd>GpChatDelete<cr>", "Delete Current" },
              ["n"] = { "<cmd>GpChatNew<cr>", "New Chat" },
              ["a"] = { "<cmd>GpChatRespond<cr>", "Response" },
            },
          },
          v = {
            ["<Leader>a"] = {
              name = "Chat",
              ["t"] = {
                name = "To",
                ["v"] = { "<cmd>'<,'>GpChatPaste vsplit<cr>", "Vsplit" },
                ["s"] = { "<cmd>'<,'>GpChatPaste split<cr>", "Split" },
                ["t"] = { "<cmd>'<,'>GpChatPaste tabnew<cr>", "New Tab" },
                ["p"] = { "<cmd>'<,'>GpChatPaste popup<cr>", "Popup" },
              },
              ["v"] = { "<cmd>'<,'>GpChatPaste vsplit<cr>", "Send to Vsplit" },
              ["p"] = { "<cmd>'<,'>GpChatPaste<cr>", "Send to Last" },
              ["r"] = {
                name = "Write",
                ["a"] = { "<cmd>'<,'>GpAppend<cr>", "Append Answer" },
                ["p"] = { "<cmd>'<,'>GpPrepend<cr>", "Prepend Answer" },
                ["r"] = { "<cmd>'<,'>GpRewrite<cr>", "Rewrite selection" },
                ["i"] = { "<cmd>'<,'>GpImplement<cr>", "Implement From Comment" },
              },
              ["c"] = { "<cmd>'<,'>GpContext vsplit<cr>", "Add Context" },
            },
          },
        },
      },
    },
  },
}
