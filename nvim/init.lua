if vim.g.vscode then
  require "vscode"
else
  require "user.plugins"
  require "user.options"
  require "user.which-key"
  require "user.nvim-tree"
  require "user.alpha"
end
