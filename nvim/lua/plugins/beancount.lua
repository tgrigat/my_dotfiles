-- return {} if not on hostname node
if vim.fn.hostname() ~= "node" then return {} end

local beancount_fn = "/home/yang/Documents/git/finance/beans/main.bean"

return {
  "AstroNvim/astrolsp",
  -- we need to use the function notation to get access to the `lspconfig` module
  ---@param opts AstroLSPOpts
  opts = function(plugin, opts)
    -- insert `beancount` into our list of servers
    opts.servers = opts.servers or {}
    table.insert(opts.servers, "beancount")

    -- extend our configuration table to include `beancount`
    opts.config = require("astrocore").extend_tbl(opts.config or {}, {
      -- Beancount LSP configuration
      beancount = {
        init_options = {
          journal_file = beancount_fn,
        },
      },
    })
  end,
}
