require "user.lsp.lang.python"

vim.diagnostic.config({ virtual_text = false })

lvim.builtin.treesitter.ensure_installed = {
  "python",
}

-- keymaps for lsp

-- lvim.builtin.which_key.mappings["o"] = {"<cmd>SymbolsOutline<cr>", "Show outline"}
