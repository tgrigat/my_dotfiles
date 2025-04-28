-- return {} if not on hostname node
if vim.fn.hostname() ~= "node" then return {} end

local beancount_file = "/home/yang/Documents/git/finance/beans/main.bean"

return {
  {
    "saghen/blink.compat",
    -- use the latest release, via version = '*', if you also use the latest release for blink.cmp
    version = "*",
    -- lazy.nvim will automatically load the plugin when it's required by blink.cmp
    lazy = true,
    -- make sure to set opts so that lazy.nvim calls blink.compat's setup
    opts = {
      sources = {
        default = {"breacount"},
        providers = {
          beancount = {
            name = "beancount",
            module = "blink.compat.source",
            option = {
              account = beancount_file,
            }
          }
        }
      },
    },
  },
  {
    "AstroNvim/astrolsp",
    -- we need to use the function notation to get access to the `lspconfig` module
    ---@param opts AstroLSPOpts
    opts = function(plugin, opts)
      -- insert `beancount` into our list of servers
      opts.servers = opts.servers or {}
      table.insert(opts.servers, "beancount")

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- Add com_nvim_lsp capabilities
      local cmp_lsp = require "cmp_nvim_lsp"
      local cmp_lsp_capabilities = cmp_lsp.default_capabilities()
      capabilities = vim.tbl_deep_extend("keep", capabilities, cmp_lsp_capabilities)
      -- Add any additional plugin capabilities here.
      -- Make sure to follow the instructions provided in the plugin's docs.

      -- extend our configuration table to include `beancount`
      opts.config = require("astrocore").extend_tbl(opts.config or {}, {
        -- Beancount LSP configuration
        beancount = {
          init_options = {
            journal_file = beancount_file,
          },
          filetypes = { "beancount" },
          capabilities = capabilities,
        },
      })
    end,
  },
}
