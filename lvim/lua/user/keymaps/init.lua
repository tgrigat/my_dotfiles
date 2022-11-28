require("user.keymaps.lsp_saga")

lvim.builtin.which_key.mappings["="] = {
  name = "Settings",
  l = { "<cmd>set background=light<cr>", "Theme Light" },
  d = { "<cmd>set background=dark<cr>", "Theme Dark" },
  s = { "<cmd>source ~/.config/lvim/config.lua<cr>", "Source Setting"},
  w = { "<cmd>set wrap<cr>", "Wrap"},
  W = { "<cmd>set nowrap<cr>", "Unwrap"}
}

lvim.builtin.which_key.mappings["lo"] = {"<cmd>LSoutlineToggle<cr>", "Saga Outline"}
