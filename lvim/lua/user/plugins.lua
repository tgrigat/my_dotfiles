-------------------------------------------------------------------------
----------------------- Additional Plugins ------------------------------
-------------------------------------------------------------------------
lvim.plugins = {
  -- You can switch between vritual environmnts.
  -- "AckslD/swenv.nvim",
  "mfussenegger/nvim-dap-python",
  'sainnhe/everforest',
  {
    -- You can generate docstrings automatically.
    "danymat/neogen",
    config = function()
      require("neogen").setup {
        enabled = true,
        languages = {
          python = {
            template = {
              annotation_convention = "numpydoc",
            },
          },
        },
      }
    end,
  },
  {
    'glacambre/firenvim',
    run = function() vim.fn['firenvim#install'](0) end
  },
  -- {
  --   "utilyre/barbecue.nvim",
  --   requires = {
  --     "neovim/nvim-lspconfig",
  --     "smiteshp/nvim-navic",
  --     "kyazdani42/nvim-web-devicons", -- optional
  --   },
  --   config = function()
  --     require("barbecue").setup()
  --   end,
  -- },

  {
    "rmagatti/goto-preview",
    config = function()
      require('goto-preview').setup {
        width = 120; -- Width of the floating window
        height = 25; -- Height of the floating window
        default_mappings = false; -- Bind default mappings
        debug = false; -- Print debug information
        opacity = nil; -- 0-100 opacity level of the floating window where 100 is fully transparent.
        post_open_hook = nil -- A function taking two arguments, a buffer and a window to be ran as a hook.
        -- You can use "default_mappings = true" setup option
        -- Or explicitly set keybindings
        -- vim.cmd("nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>")
        -- vim.cmd("nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>")
        -- vim.cmd("nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>")
      }
    end
  },

  -- add markdown preview
  {
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
    ft = 'markdown'
  },

  -- You can run blocks of code like jupyter notebook.
  { "dccsillag/magma-nvim", run = ":UpdateRemotePlugins" },

  {
    "glepnir/lspsaga.nvim",
    branch = "main",
    config = function()
      local saga = require("lspsaga")
      saga.init_lsp_saga({
        -- your configuration
        border_style = "rounded"
      })
    end,
  },
  -- outline for languages
  { 'simrat39/symbols-outline.nvim', config = function() require("user.outline") end }
}
