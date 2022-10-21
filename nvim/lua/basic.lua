vim.opt.number = true
vim.opt.relativenumber = true

vim.scriptencoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.mouse = "a"
vim.opt.clipboard:append("unnamedplus")

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.autoread = true
vim.bo.autoread = true

vim.wo.signcolumn = "no"

-- this is for the automatic install on every machine (Packer)
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  -- My plugins here
  -- use 'foo1/bar1.nvim'
  -- use 'foo2/bar2.nvim'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
