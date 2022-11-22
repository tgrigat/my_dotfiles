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
--
return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  -- Leap for better navigation
  use { "ggandor/leap.nvim",
    config = function()
      require('leap').add_default_mappings()
    end
  }
  use 'sainnhe/everforest'
  use {
    'neovim/nvim-lspconfig',
    config = function() require('user.lsp') end
  } -- Configurations for Nvim LSP
  use { 
      'nvim-tree/nvim-tree.lua' ,
        requires = {
    'nvim-tree/nvim-web-devicons', -- optional, for file icons
  },
  } -- nvim tree for the file exploration
  -- The following plugins are borrowed from LunarVim
  use {
  'nvim-telescope/telescope.nvim', tag = '0.1.0',
-- or                            , branch = '0.1.x',
  requires = { {'nvim-lua/plenary.nvim'} }
}
  use { 'hrsh7th/nvim-cmp',
    config = function() require('user.cmp') end,
    requires = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-cmdline' },
      -- {'SirVer/ultisnips'},
      -- {'quangnguyen30192/cmp-nvim-ultisnips'}
      { 'hrsh7th/cmp-vsnip' },
      { 'hrsh7th/vim-vsnip' },
    },
  }

  use { 'nvim-lua/popup.nvim',
  }
  use {
    'akinsho/toggleterm.nvim',
  }
  use 'rcarriga/nvim-notify'
  use "goolord/alpha-nvim"
  use { "folke/which-key.nvim" }

  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }

  use {
    "windwp/nvim-autopairs",
    config = function() require("user.autopair") end
  }
  -- Autopairsintegrates with both cmp and treesitter
  use "williamboman/nvim-lsp-installer"

  -- comment

  use { "terrortylor/nvim-comment",
    config = function() require('nvim_comment').setup(
        {
          -- Linters prefer comment and line to have a space in between markers
          marker_padding = true,
          -- should comment out empty or whitespace only lines
          comment_empty = true,
          -- trim empty comment whitespace
          comment_empty_trim_whitespace = true,
          -- Should key mappings be created
          create_mappings = true,
          -- Normal mode mapping left hand side
          line_mapping = "gcc",
          -- Visual/Operator mapping left hand side
          operator_mapping = "gc",
          -- text object mapping, comment chunk,,
          comment_chunk_text_object = "ic",
          -- Hook function to call before commenting takes place
          hook = nil
        }
      )
    end
  }
  use { "tpope/vim-surround" }
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
