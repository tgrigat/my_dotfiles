-- require("user.keymaps.lsp_saga")

lvim.builtin.which_key.setup.plugins.marks = true
lvim.builtin.which_key.setup.plugins.regiesters = true
lvim.builtin.which_key.setup.plugins.presets.operators = true
lvim.builtin.which_key.setup.plugins.presets.motions = true
lvim.builtin.which_key.setup.plugins.presets.text_objects = true
lvim.builtin.which_key.setup.plugins.presets.windows = true
lvim.builtin.which_key.setup.plugins.presets.nav = true
lvim.builtin.which_key.setup.plugins.presets.z = true
lvim.builtin.which_key.setup.plugins.presets.g = true

lvim.builtin.which_key.mappings["="] = {
  name = "Settings",
  l = { "<cmd>set background=light<cr>", "Theme Light" },
  d = { "<cmd>set background=dark<cr>", "Theme Dark" },
  s = { "<cmd>source ~/.config/lvim/config.lua<cr>", "Source Setting" },
  w = { "<cmd>set wrap<cr>", "Wrap" },
  W = { "<cmd>set nowrap<cr>", "Unwrap" },
  p = {
    name = "Plugins",
    i = { "<cmd>Lazy install<cr>", "Install" },
    s = { "<cmd>Lazy sync<cr>", "Sync" },
    S = { "<cmd>Lazy clear<cr>", "Status" },
    c = { "<cmd>Lazy clean<cr>", "Clean" },
    u = { "<cmd>Lazy update<cr>", "Update" },
    p = { "<cmd>Lazy profile<cr>", "Profile" },
    l = { "<cmd>Lazy log<cr>", "Log" },
    d = { "<cmd>Lazy debug<cr>", "Debug" },
  },
  P = { "<cmd>vs ~/.config/lvim/lua/user/lvim_plugins.lua<cr>", "Open Lvim Plugins" }
}

lvim.builtin.which_key.mappings["Q"] = { "<cmd>quitall<cr>", "Quit all" }

lvim.builtin.which_key.mappings["o"] = {
  name = "Obsidian",
  ['t'] = { "<cmd>ObsidianToday<cr>", "Daily note" },
  ['y'] = { "<cmd>ObsidianYesterday<cr>", "Yesterday's note" },
  ['s'] = { "<cmd>ObsidianSearch<cr>", "Search notes" },
  ['g'] = { "<cmd>ObsidianFollowLink<cr>", "Goto link" },
  ['o'] = { "<cmd>ObsidianOpen<cr>", "Open Obsidian" }
}

lvim.builtin.which_key.mappings["a"] = {
  name = "ChatGPT",
  ['i'] = { "<cmd>ChatGPT<cr>", "Chat" },
  ['o'] = { "<cmd>ChatGPTActAs<cr>", "Act as" },
}

lvim.builtin.which_key.vmappings["a"] = {
  ['i'] = { "<cmd>ChatGPTEditWithInstructions<cr>" }
}

lvim.builtin.which_key.mappings['P'] = {
  name = "Project",
  M = { "<cmd>lua lvim.builtin.project.manual_mode=true<cr>", "Manual CWD" },
  m = { "<cmd>lua lvim.builtin.project.manual_mode=true<cr>", "Auto CWD" },
  c = { "<cmd>ProjectRoot ", "Change Root" },
  s = { "<cmd>SessionsSave .session<cr>", "Save Session" },
  r = { "<cmd>SessionsLoad .session<cr>", "Restore Session" }
}

lvim.builtin.which_key.mappings['p'] = {
  name = "Palettes",
  p = { "<cmd>Telescope commands<cr>", "Telescope palette" },
  o = { "<cmd>Legendary commands<cr>", "Command palette" }
}

-- doc here: https://neovim.io/doc/user/diagnostic.html#diagnostic-api
lvim.builtin.which_key.mappings['lV'] = { "<cmd>lua vim.diagnostic.config({virtual_text = false})<cr>", "VirtualText Off" }
lvim.builtin.which_key.mappings['lv'] = { "<cmd>lua vim.diagnostic.config({virtual_text = true})<cr>", "VirtualText On" }

lvim.builtin.which_key.mappings['lc'] = { "<cmd>lua vim.diagnostic.disable(0,nil)<cr>", "Disable Diagnostics" }
lvim.builtin.which_key.mappings['lC'] = { "<cmd>lua vim.diagnostic.enable(0,nil)<cr>", "Enable Diagnostics" }

lvim.builtin.which_key.mappings['lx'] = { "<cmd>DogeGenerate<cr>", "Generate Docstring" }

lvim.builtin.which_key.mappings["lo"] = { "<cmd>AerialToggle right<cr>", "Saga Outline" }

local keymap = vim.keymap.set

keymap("n", "<C-p>", "<cmd>Legendary commands<CR>", { silent = true })

-- keymap("n", "<CR>", "o<Esc>k", { silent = true })
-- keymap("n", "<CR>", "O<Esc>j", { silent = true })
