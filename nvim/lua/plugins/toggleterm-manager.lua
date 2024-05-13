---@type LazySpec
return {
  {
    "ryanmsnyder/toggleterm-manager.nvim",
    config = function()
      local toggleterm_manager = require "toggleterm-manager"
      local actions = toggleterm_manager.actions
      toggleterm_manager.setup {
        mappings = { -- key mappings bound inside the telescope window
          i = {
            ["<CR>"] = { action = actions.toggle_term, exit_on_action = true }, -- toggles terminal open/closed
            ["<C-i>"] = { action = actions.create_term, exit_on_action = false }, -- creates a new terminal buffer
            ["<C-d>"] = { action = actions.delete_term, exit_on_action = false }, -- deletes a terminal buffer
            ["<C-r>"] = { action = actions.rename_term, exit_on_action = false }, -- provides a prompt to rename a terminal
          },
          n = {
            ["<CR>"] = { action = actions.toggle_term, exit_on_action = true }, -- toggles terminal open/closed
            ["r"] = { action = actions.rename_term, exit_on_action = false }, -- provides a prompt to rename a terminal
            ["d"] = { action = actions.delete_term, exit_on_action = false }, -- deletes a terminal buffer
            ["n"] = { action = actions.create_term, exit_on_action = false }, -- creates a new terminal buffer
          },
        },
      }
    end,
    dependencies = {
      "akinsho/nvim-toggleterm.lua",
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim", -- only needed because it's a dependency of telescope
      {
        "AstroNvim/astrocore",
        opts = {
          mappings = {
            n = {
              ["<Leader>ts"] = { "<cmd>Telescope toggleterm_manager<cr>", desc = "Toggleterm" },
            },
          },
        },
      },
    },
  },
}
