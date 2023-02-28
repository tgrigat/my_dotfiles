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
