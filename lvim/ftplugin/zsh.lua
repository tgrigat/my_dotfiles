vim.api.nvim_exec([[
  if exists(':TSDisableAll')
    TSDisableAll highlight bash
  endif
]], false)

