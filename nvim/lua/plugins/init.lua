local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end
-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use 'sainnhe/everforest'

    use {
        'neovim/nvim-lspconfig', 
        config = function() require('plugins.lsp') end 
    } -- Configurations for Nvim LSP

    use {'kyazdani42/nvim-tree.lua'} -- nvim tree for the file exploration

    -- The following plugins are borrowed from LunarVim
    use {'nvim-telescope/telescope.nvim'}
    use {'hrsh7th/nvim-cmp',
        config = function() require('plugins.cmp') end,
        requires = {
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'hrsh7th/cmp-cmdline'},
            -- {'SirVer/ultisnips'},
            -- {'quangnguyen30192/cmp-nvim-ultisnips'}
            {'hrsh7th/cmp-vsnip'},
            {'hrsh7th/vim-vsnip'},
        },
        cond = function()
            return not vim.g.vscode
        end
    }
    
    use 'nvim-lua/popup.nvim'
    use 'akinsho/toggleterm.nvim'
    use 'rcarriga/nvim-notify'
    use "goolord/alpha-nvim"

    use { "folke/which-key.nvim" }
    
    use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    }
    
    use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter

    use "williamboman/nvim-lsp-installer"
    
    if PACKER_BOOTSTRAP then
    require("packer").sync()
    end
end)

