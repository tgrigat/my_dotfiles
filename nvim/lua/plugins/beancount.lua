-- return {} if not on hostname node
-- if true then return {} end

-- if vim.fn.hostname() ~= "node" then return {} end

local formatter = require "customformatter"

return {
  "crispgm/cmp-beancount",
  config = function(_, opts)
    local lspconfig = require "lspconfig"
    lspconfig.beancount.setup = {
      init_options = {
        journal_file = "/home/yang/Documents/git/finance/beans/main.bean",
      },
    }
    -- local cmpbeancount = require "cmp-beancount"
    --
    -- cmpbeancount.setup(opts)
  end,
  dependencies = {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      autocmds = {
        formatter_options = {
          {
            -- Trigger the autocmd on the "BufWritePost" event
            event = "BufWritePost",
            -- Specify the patterns for the filetypes
            pattern = { "*.bean", "*.beancount" },
            -- Description for the autocmd
            desc = "Format bean files on save",
            -- Add the autocmd to the "formatter_options" augroup
            group = "formatter_options",
            -- The callback function to format bean files
            callback = formatter.bean_format,
          },
          {
            -- Trigger the autocmd on the "BufWritePost" event
            event = "BufWritePost",
            -- Specify the patterns for the filetypes
            pattern = { "*.bean", "*.beancount" },
            -- Description for the autocmd
            desc = "Run bean-check on save",
            -- Add the autocmd to the "formatter_options" augroup
            group = "formatter_options",
            -- The callback function to run bean-check
            callback = function() vim.cmd "!bean-check %" end,
          },
        },
      },
    },
  },
  spec = {
    "hrsh7th/nvim-cmp",
    dependencies = { "crispgm/cmp-beancount" },
    opts = {
      sources = {
        name = "beancount",
        option = {
          account = "/home/yang/Documents/git/finance/beans/main.bean",
        },
      },
    },
  },
}
