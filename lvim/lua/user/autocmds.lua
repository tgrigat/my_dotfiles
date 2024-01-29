-- disable syntax highlighting in big files
local function disableSyntaxTreesitter(bufnr)
  -- print("Big file, disabling syntax, treesitter, and folding")
  print("Big file, disable some functionalities")
  if vim.fn.exists(':TSBufDisable') then
    vim.api.nvim_buf_call(bufnr, function()
      vim.cmd('TSBufDisable autotag')
      vim.cmd('TSBufDisable highlight')
      -- etc...
    end)
  end

  -- vim.api.nvim_buf_set_option(bufnr, 'foldmethod', 'manual')
  -- vim.cmd('syntax clear')
  vim.cmd('syntax off')   -- hmmm, which one to use?
  -- vim.cmd('setlocal filetype=off')
  vim.cmd('setlocal noundofile')
  vim.cmd('setlocal noswapfile')
  -- vim.cmd('setlocal noloadplugins')
end

vim.api.nvim_create_autocmd({ "BufReadPre", "FileReadPre" }, {
  pattern = "*",
  callback = function()
    local file_size = vim.fn.getfsize(vim.fn.expand("%"))
    if file_size > 512 * 1024 then
      disableSyntaxTreesitter(0)
    end
  end
})
