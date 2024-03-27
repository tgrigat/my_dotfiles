reload("user.dap.dap_run_file")
reload("user.dap.project_wise")

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local project_dap_config = require("user.dap.project_wise").search_project_config()
    local status_ok, dap = pcall(require, "dap")
    if not status_ok then
      vim.notify("[nvim-dap-project] Fail to load DAP")
      return
    end

    if project_dap_config == nil then
      vim.notify("[nvim-dap-project] empty project configuration found")
      return
    end

    for filetype, config in pairs(project_dap_config) do
      dap.configurations[filetype] = config
    end
  end,
})
