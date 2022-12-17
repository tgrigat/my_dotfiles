require "user.lsp.lang.python"

lvim.lsp.diagnostics.virtual_text = false

lvim.builtin.treesitter.ensure_installed = {
  "python",
}

-- keymaps for lsp

-- lvim.builtin.which_key.mappings["o"] = {"<cmd>SymbolsOutline<cr>", "Show outline"}
lvim.builtin.which_key.mappings["o"] = {
  name = "Obsidian",
  ['t'] = {"<cmd>ObsidianToday<cr>", "Daily note"},
  ['y'] = {"<cmd>ObsidianYesterday<cr>", "Yesterday's note"},
  ['s'] = {"<cmd>ObsidianSearch<cr>", "Search notes"},
  ['o'] = {"<cmd>ObsidianFollowLink<cr>", "Goto link"}
}
