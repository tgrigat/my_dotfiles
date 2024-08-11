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
            ["<Leader>a"] = { name = "Chat" },
            ["<Leader>at"] = { name = "Toggle" },
            ["<Leader>atv"] = { "<cmd>GpChatToggle vsplit<cr>", desc = "Toggle Vsplit" },
            ["<Leader>ats"] = { "<cmd>GpChatToggle split<cr>", desc = "Toggle Split" },
            ["<Leader>att"] = { "<cmd>GpChatToggle tabnew<cr>", desc = "Toggle New Tab" },
            ["<Leader>atp"] = { "<cmd>GpChatToggle popup<cr>", desc = "Toggle Popup" },
            ["<Leader>av"] = { "<cmd>GpChatToggle vsplit<cr>", desc = "Toggle Vsplit" },
            ["<Leader>af"] = { "<cmd>GpChatFinder<cr>", desc = "Search History" },
            ["<Leader>ad"] = { "<cmd>GpChatDelete<cr>", desc = "Delete Current" },
            ["<Leader>an"] = { "<cmd>GpChatNew<cr>", desc = "New Chat" },
            ["<Leader>aa"] = { "<cmd>GpChatRespond<cr>", desc = "Response" },
          },
          v = {
            ["<Leader>a"] = { name = "Chat" },
            ["<Leader>at"] = { name = "To" },
            ["<Leader>atv"] = { "<cmd>'<,'>GpChatPaste vsplit<cr>", desc = "Vsplit" },
            ["<Leader>ats"] = { "<cmd>'<,'>GpChatPaste split<cr>", desc = "Split" },
            ["<Leader>att"] = { "<cmd>'<,'>GpChatPaste tabnew<cr>", desc = "New Tab" },
            ["<Leader>atp"] = { "<cmd>'<,'>GpChatPaste popup<cr>", desc = "Popup" },
            ["<Leader>av"] = { "<cmd>'<,'>GpChatPaste vsplit<cr>", desc = "Send to Vsplit" },
            ["<Leader>ap"] = { "<cmd>'<,'>GpChatPaste<cr>", desc = "Send to Last" },
            ["<Leader>ar"] = { name = "Write" },
            ["<Leader>ara"] = { "<cmd>'<,'>GpAppend<cr>", desc = "Append Answer" },
            ["<Leader>arp"] = { "<cmd>'<,'>GpPrepend<cr>", desc = "Prepend Answer" },
            ["<Leader>arr"] = { "<cmd>'<,'>GpRewrite<cr>", desc = "Rewrite selection" },
            ["<Leader>ari"] = { "<cmd>'<,'>GpImplement<cr>", desc = "Implement From Comment" },
            ["<Leader>ac"] = { "<cmd>'<,'>GpContext vsplit<cr>", desc = "Add Context" },
          },
        },
      },
    },
  },
}
