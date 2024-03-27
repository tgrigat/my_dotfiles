--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
-- lvim.colorscheme = "everforest"
-- lvim.colorscheme = "everforest"
lvim.log.level = "warn"
lvim.format_on_save = false
vim.cmd("set background=dark")
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.nvimtree.setup.sync_root_with_cwd = false
-- lvim.builtin.nvimtree.setup.view.width = 60

lvim.builtin.project.manual_mode = true

lvim.builtin.project.patterns = { ".is_project_root", ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile",
  "package.json",
  "pom.xml",
  "compile_commands.json" }

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
  "rust",
  "tex"
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true

lvim.builtin.cmp.experimental.ghost_text = true

lvim.builtin.terminal.active = true

-- All the treesitter parsers you want to install. If you want all of them, just
-- replace everything with "all".
--

vim.opt.titlestring = "%<%F%=%l/%L - lvim" -- what the title of the window will be set to
vim.opt.undodir = vim.fn.stdpath "cache" .. "/undo"
vim.opt.undofile = true                    -- enable persistent undo

-- set virtual text level

local diagnostic_config = {
  signs = {
    active = true,
    values = {
      { name = "DiagnosticSignError", text = lvim.icons.diagnostics.Error },
      { name = "DiagnosticSignWarn",  text = lvim.icons.diagnostics.Warning },
      { name = "DiagnosticSignHint",  text = lvim.icons.diagnostics.Hint },
      { name = "DiagnosticSignInfo",  text = lvim.icons.diagnostics.Information },
    },
  },
  virtual_text = true,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    focusable = true,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
}

vim.diagnostic.config(diagnostic_config)

vim.opt.shell = "/bin/bash"

lvim.builtin.terminal.shell = function()
  if vim.fn.executable('zsh') == 1 then
    return 'zsh'
  elseif vim.fn.executable('bash') == 1 then
    return 'bash'
  else
    return 'sh'
  end
end

-- Set command for setting filetypes
vim.cmd('command! Md set filetype=markdown')
vim.cmd('command! Ftpy set filetype=python')
vim.cmd('command! Ftcpp set filetype=cpp')

-- Set the localloader to ; , used by neorg
vim.g.maplocalleader = '\\'

-- table.insert(lvim.lsp.installer.setup.ensure_installed, "beautysh")
-- table.insert(lvim.lsp.installer.setup.ensure_installed, "shellcheck")
