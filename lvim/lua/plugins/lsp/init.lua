require "plugins.lsp.lang.python"

lvim.lsp.diagnostics.virtual_text = false

lvim.builtin.treesitter.ensure_installed = {
  "python",
}


local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "g",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
  v = { "<cmd>Lspsaga hover_doc<CR>", "Hover_doc" }
}

which_key.register(mappings, opts)
