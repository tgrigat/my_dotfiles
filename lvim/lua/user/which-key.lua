local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

vim.cmd('autocmd FileType * lua setKeybinds()')

function setKeybinds()
  local fileTy = vim.api.nvim_buf_get_option(0, "filetype")
  local opts = { prefix = '', buffer = 0 }

  if fileTy == 'python' then
    which_key.register({
      ["<leader>j"] = {
        name = "Jupyter",
        i = { "<Cmd>MagmaInit<CR>", "Init Magma" },
        d = { "<Cmd>MagmaDeinit<CR>", "Deinit Magma" },
        e = { "<Cmd>MagmaEvaluateLine<CR>", "Evaluate Line" },
        r = { "<Cmd>MagmaReevaluateCell<CR>", "Re evaluate cell" },
        D = { "<Cmd>MagmaDelete<CR>", "Delete cell" },
        s = { "<Cmd>MagmaShowOutput<CR>", "Show Output" },
        R = { "<Cmd>MagmaRestart!<CR>", "Restart Magma" },
        S = { "<Cmd>MagmaSave<CR>", "Save" },
      },
      ["<leader>d"] = {
        name = "Debug",
        s = { "<cmd>lua require('dap-python').debug_selection()<cr>", "Debug Selection" },
        f = { "<cmd>lua require('dap-python').test_class()<cr>", "Test Class" },
        m = { "<cmd>lua require('dap-python').test_method()<cr>", "Test Method" }
      }

    }, opts)
  elseif fileTy == 'sh' then which_key.register({
    }, opts)
  end
end

local setup = {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    -- spelling = {
    --   enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
    --   suggestions = 20, -- how many suggestions should be shown in the list?
    -- },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
}

which_key.setup(setup)
