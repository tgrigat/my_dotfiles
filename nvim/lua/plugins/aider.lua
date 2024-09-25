local Terminal = require("toggleterm.terminal").Terminal
local aider = Terminal:new {
  cmd = "aider",
  hidden = true,
  direction = "float",
  float_opts = {
    border = "double",
  },
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<C-v>", "<C-\\><C-n>", {noremap = true, silent = true})
    vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<C-\\>", "<cmd>lua _G.AIDER_TOGGLE()<CR>", {noremap = true, silent = true})
    vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<C-a>", "<cmd>lua _G.AIDER_TOGGLE()<CR>", {noremap = true, silent = true})
  end,
}

_G.AIDER_TOGGLE = function() aider:toggle() end

return {
  {
    "akinsho/toggleterm.nvim",
    opts = {},
  },
  {
    "AstroNvim/astrocore",
    opts = {
      mappings = {
        n = {
          ["<leader>ta"] = { "<cmd>lua _G.AIDER_TOGGLE()<CR>", desc = "Toggle Aider" },
          ["<C-a>"] = { "<cmd>lua _G.AIDER_TOGGLE()<CR>", desc = "Toggle Aider" },
        },
      },
    },
  },
}
