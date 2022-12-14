if vim.g.vscode then
    require "vscode"
else
    require "user.plugins"
    require "user.options"
    require "user.which-key"
    require "user.nvim-tree"
    require "user.alpha"
    require "user.ft-which-key"
    require "user.command-palette"
    require "user.indentlines"
    require "user.tree-sitter"
    require "user.winbar"
end
