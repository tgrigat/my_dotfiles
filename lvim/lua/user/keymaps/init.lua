require("user.keymaps.lsp_saga")

lvim.builtin.which_key.mappings["="] = {
  name = "Settings",
  l = { "<cmd>set background=light<cr>", "Theme Light" },
  d = { "<cmd>set background=dark<cr>", "Theme Dark" },
  s = { "<cmd>source ~/.config/lvim/config.lua<cr>", "Source Setting" },
  w = { "<cmd>set wrap<cr>", "Wrap" },
  W = { "<cmd>set nowrap<cr>", "Unwrap" },
  p = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    r = { "<cmd>lua require('lvim.plugin-loader').recompile()<cr>", "Re-compile" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    S = { "<cmd>PackerStatus<cr>", "Status" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  }
}

lvim.builtin.which_key.mappings['P'] = { "<cmd>Legendary commands<cr>","Command palette" }
lvim.builtin.which_key.mappings['p'] = { "<cmd>Telescope commands<cr>","Command palette" }

lvim.builtin.which_key.mappings["lo"] = { "<cmd>LSoutlineToggle<cr>", "Saga Outline" }
