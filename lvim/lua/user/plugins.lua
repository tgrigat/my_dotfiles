-------------------------------------------------------------------------
----------------------- Additional Plugins ------------------------------
-------------------------------------------------------------------------
lvim.plugins = {
  { "ggandor/leap.nvim",
    config = function()
      require('leap').add_default_mappings()
    end
  },
  "savq/melange",
  { "p00f/clangd_extensions.nvim" },
  {
    'rose-pine/neovim',
    as = 'rose-pine',
  },
  -- github light theme
  {
    'projekt0n/github-nvim-theme',
    -- config = function()
    --   require('github-theme').setup({
    --     -- ...
    --     dark_sidebar = true
    --   })
    -- end
  },
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
  {
    "petertriho/nvim-scrollbar",
    config = function()
      require("scrollbar").setup()
    end
  },
  -- add markdown preview
  {
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
    ft = 'markdown'
  },

  -- You can run blocks of code like jupyter notebook.
  { "dccsillag/magma-nvim", run = ':UpdateRemotePlugins' },

  {
    "glepnir/lspsaga.nvim",
    branch = "main",
    config = function()
      local saga = require("lspsaga")
      saga.init_lsp_saga({
        -- your configuration
        border_style = "rounded",
        symbol_in_winbar = {
          in_custom = true
        },
        show_outline = {
          win_position = 'right',
          win_with = '',
          win_width = 30,
          auto_enter = true,
          auto_preview = true,
          -- virt_text = '┃',
          jump_key = 'o',
          -- auto refresh when change buffer
          auto_refresh = true,
        },
      })
    end,
  },
  -- outline for languages
  { 'simrat39/symbols-outline.nvim', config = function() require("user.outline") end },
  { 'kkoomen/vim-doge', run = ':call doge#install()' },
  {
    'mrjones2014/legendary.nvim'
    -- sqlite is only needed if you want to use frecency sorting
    -- requires = 'kkharji/sqlite.lua'
  },
  { 'stevearc/dressing.nvim' },
  { 'hrsh7th/cmp-cmdline' },
}
