if vim.g.vscode then
  require "code"
else
  require "user.plugins"

  if vim.g.started_by_firenvim == true then
    require "user.firenvim"
  end
end
