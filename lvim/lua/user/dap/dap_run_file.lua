local status_ok, dap = pcall(require, "dap")
if not status_ok then
  return
end

vim.api.nvim_create_user_command("RunScriptWithArgs", function(t)
  -- :help nvim_create_user_command
  local args = vim.split(vim.fn.expand(t.args), '\n')
  local approval = vim.fn.confirm(
    "Will try to run:\n    " ..
    vim.bo.filetype .. " " ..
    vim.fn.expand('%') .. " " ..
    t.args .. "\n\n" ..
    "Do you approve? ",
    "&Yes\n&No", 1
  )
  if approval == 1 then
    dap.run({
      type = vim.bo.filetype,
      request = 'launch',
      name = 'Launch file with custom arguments (adhoc)',
      program = '${file}',
      args = args,
    })
  end
end, {
  complete = 'file',
  nargs = '*'
})
