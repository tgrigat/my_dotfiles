-- require("user.keymaps.lsp_saga")

lvim.builtin.which_key.setup.plugins.marks = true
lvim.builtin.which_key.setup.plugins.registers = true
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
  c = { "<cmd>Copilot disable<cr>", "Disable Copilot" },
  C = { "<cmd>Copilot enable<cr>", "Enable Copilot" },
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
    r = { "<cmd>Lazy restore<cr>", "Restore (as Lockfile)" },
  },
  P = { "<cmd>vs ~/.config/lvim/lua/user/lvim_plugins.lua<cr>", "Open Lvim Plugins" }
}

lvim.builtin.which_key.mappings["n"] = {
  name = "Note",
  i = { "<cmd>Neorg index<cr>", "Open Neorg index" },
  r = { "<cmd>Neorg return<cr>", "Return" },
  h = { "<cmd>help norg<cr>", "Help" },
  w = {
    name = "Workspaces",
    m = { "<cmd>Neorg workspace main<cr>", "Main" }
  },
  t = { "<cmd>Neorg journal today<cr>", "Today" },
  k = { "<cmd>Neorg keybind all<cr>", "Keybinds" },
  j = {
    name = "Journal",
    t = { "<cmd>Neorg journal today<cr>", "Today" },
    n = { "<cmd>Neorg journal tomorrow<cr>", "Tomorrow" },
  },
  -- r = { "<cmd>Neorg return<cr>", "Return" },
  -- m = { "<cmd>MindOpenMain<cr>", "Open Main" },
  -- n = { "<cmd>MindOpenSmart<cr>", "Open Project" },
}

lvim.builtin.which_key.mappings["r"] = {
  name = "REPL",
  r = { "<cmd>normal <C-c><C-c><cr>", "Run" },
  c = { "<cmd>SlimeConfig<cr>", "Config" },
}
lvim.builtin.which_key.vmappings["r"] = {
  name = "REPL",
  r = { "<cmd>normal <C-c><C-c><cr>", "Run" },
}

lvim.builtin.which_key.mappings["y"] = {
  name = "Yank",
  y = { "<cmd>let @+=expand('%:p') . ':' . line('.')<cr>", "Absolute Path w/ LN" },
  f = { "<cmd>let @+=expand('%:p')<cr>", "Absolute Path" },
}


lvim.builtin.which_key.mappings["Q"] = { "<cmd>quitall<cr>", "Quit all" }
lvim.builtin.which_key.mappings[";"] = nil

lvim.builtin.which_key.mappings["o"] = {
  name = "Obsidian",
  ['t'] = { "<cmd>ObsidianToday<cr>", "Daily note" },
  ['y'] = { "<cmd>ObsidianYesterday<cr>", "Yesterday's note" },
  ['f'] = { "<cmd>ObsidianSearch<cr>", "Search notes" },
  ['g'] = { "<cmd>ObsidianFollowLink<cr>", "Goto link" },
  ['o'] = { "<cmd>ObsidianOpen<cr>", "Open Obsidian" },
  ['c'] = { function()
    return require("obsidian").util.toggle_checkbox()
  end, "Open Obsidian" }
}

lvim.builtin.which_key.mappings["a"] = {
  name = "Chat",
  ['t'] = {
    name = "Toggle",
    ['v'] = { "<cmd>GpChatToggle vsplit<cr>", "Toggle Vsplit" },
    ['s'] = { "<cmd>GpChatToggle split<cr>", "Toggle Split" },
    ['t'] = { "<cmd>GpChatToggle tabnew<cr>", "Toggle New Tab" },
    ['p'] = { "<cmd>GpChatToggle popup<cr>", "Toggle Popup" },
  },
  ['v'] = { "<cmd>GpChatToggle vsplit<cr>", "Toggle Vsplit" },
  ['f'] = { "<cmd>GpChatFinder<cr>", "Search History" },
  ['d'] = { "<cmd>GpChatDelete<cr>", "Delete Current" },
  ['n'] = { "<cmd>GpChatNew<cr>", "New Chat" },
}

lvim.builtin.which_key.vmappings["a"] = {
  name = "Chat",
  ['t'] = {
    name = "To",
    ['v'] = { "<cmd>'<,'>GpChatPaste vsplit<cr>", "Vsplit" },
    ['s'] = { "<cmd>'<,'>GpChatPaste split<cr>", "Split" },
    ['t'] = { "<cmd>'<,'>GpChatPaste tabnew<cr>", "New Tab" },
    ['p'] = { "<cmd>'<,'>GpChatPaste popup<cr>", "Popup" },
  },
  ['v'] = { "<cmd>'<,'>GpChatPaste vsplit<cr>", "Send to Vsplit" },
  ['r'] = {
    name = "Write",
    ['a'] = { "<cmd>'<,'>GpAppend<cr>", "Append Answer" },
    ['p'] = { "<cmd>'<,'>GpPrepend<cr>", "Prepend Answer" },
    ['r'] = { "<cmd>'<,'>GpRewrite<cr>", "Rewrite selection" },
    ['i'] = { "<cmd>'<,'>GpImplement<cr>", "Implement From Comment" },
  },
  ['c'] = { "<cmd>'<,'>GpContext vsplit<cr>", "Add Context" },
}
-- lvim.builtin.which_key.vmappings["a"] = {
--   ['i'] = { "<cmd>ChatGPTEditWithInstructions<cr>" }
-- }

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

-- vim.diagnostic.disable()

Diagnostic_config = {
  signs = {
    active = true,
    values = {
      { name = "DiagnosticSignError", text = lvim.icons.diagnostics.Error },
      { name = "DiagnosticSignWarn",  text = lvim.icons.diagnostics.Warning },
      -- { name = "DiagnosticSignHint",  text = lvim.icons.diagnostics.Hint },
      -- { name = "DiagnosticSignInfo",  text = lvim.icons.diagnostics.Information },
    },
  },
  virtual_text = false,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    focusable = true,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
}

-- doc here: https://neovim.io/doc/user/diagnostic.html#diagnostic-api
lvim.builtin.which_key.mappings['lV'] = { "<cmd>lua vim.diagnostic.config({virtual_text = false})<cr>", "VirtualText Off" }
lvim.builtin.which_key.mappings['lv'] = { "<cmd>lua vim.diagnostic.config({virtual_text = true})<cr>", "VirtualText On" }

lvim.builtin.which_key.mappings['lp'] = { "<cmd>Copilot panel<cr>", "Open Copilot Panel" }

lvim.builtin.which_key.mappings['lC'] = { "<cmd>lua vim.diagnostic.disable()<cr>", "Disable Diagnostics" }
lvim.builtin.which_key.mappings['lc'] = {
  "<cmd>lua vim.diagnostic.enable() ; vim.diagnostic.config(Diagnostic_config) <cr>", "Enable Diagnostics" }

lvim.builtin.which_key.mappings['lx'] = { "<cmd>Neogen<cr>", "Generate Docstring" }

lvim.builtin.which_key.mappings["lo"] = { "<cmd>AerialToggle right<cr>", "Saga Outline" }
lvim.builtin.which_key.mappings["lf"] = {
  function()
    require("lvim.lsp.utils").format { timeout_ms = 2000 }
  end,
  "Format" }

local keymap = vim.keymap.set

lvim.builtin.which_key.mappings["f"] = { "<cmd>Telescope find_files recurse_submodules=true<cr>",
  "Find Files (include Submodule)" }

keymap("n", "<C-p>", "<cmd>Legendary commands<CR>", { silent = true })

-- keymap("n", "<CR>", "o<Esc>k", { silent = true })
-- keymap("n", "<CR>", "O<Esc>j", { silent = true })
