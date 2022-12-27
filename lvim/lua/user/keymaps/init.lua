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
    p = { "<cmd>vs ~/dotfiles/lvim/lua/user/plugins.lua<cr>", "Plugins" }
  }
}

lvim.builtin.which_key.mappings["o"] = {
  name = "Obsidian",
  ['t'] = { "<cmd>ObsidianToday<cr>", "Daily note" },
  ['y'] = { "<cmd>ObsidianYesterday<cr>", "Yesterday's note" },
  ['s'] = { "<cmd>ObsidianSearch<cr>", "Search notes" },
  ['g'] = { "<cmd>ObsidianFollowLink<cr>", "Goto link" },
  ['o'] = { "<cmd>ObsidianOpen<cr>", "Open Obsidian" }
}


lvim.builtin.which_key.mappings['P'] = { "<cmd>Legendary commands<cr>", "Command palette" }

lvim.builtin.which_key.mappings['p'] = { "<cmd>Telescope commands<cr>", "Command palette" }

-- doc here: https://neovim.io/doc/user/diagnostic.html#diagnostic-api
lvim.builtin.which_key.mappings['lV'] = { "<cmd>lua vim.diagnostic.config({virtual_text = false})<cr>", "VirtualText Off" }
lvim.builtin.which_key.mappings['lv'] = { "<cmd>lua vim.diagnostic.config({virtual_text = true})<cr>", "VirtualText On" }

lvim.builtin.which_key.mappings['lc'] = { "<cmd>lua vim.diagnostic.disable(0,nil)<cr>", "Disable Diagnostics" }
lvim.builtin.which_key.mappings['lC'] = { "<cmd>lua vim.diagnostic.enable(0,nil)<cr>", "Enable Diagnostics" }

lvim.builtin.which_key.mappings["lo"] = { "<cmd>AerialToggle right<cr>", "Saga Outline" }

local keymap = vim.keymap.set

keymap("n", "<C-p>", "<cmd>Legendary commands<CR>", { silent = true })
