if not vim.g.neovide then return {} end

-- vim.o.guifont = "Iosevka Nerd Font Mono:h12"

return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    options = {
      o = {
        guifont = "Iosevka Nerd Font Mono:h12",
        -- neovide_input_ime = true
      },
      -- g = { clipboard = "unnamedplus" },
    },
    mappings = {
      n = {
        ["<C-S-V>"] = { 'l"+P', desc = "Paste from clipboard left of cursor" },
      },
      -- v = {
      --   ["<Shift-Ctrl-c>"] = { '"+y', desc = "Copy to clipboard" },
      --   ["<Shift-Ctrl-v>"] = { '"+P', desc = "Paste from clipboard replacing selection" },
      -- },
      c = {
        ["<S-C-V>"] = { '<C-o>l<C-o>"+<C-o>P<C-o>l', desc = "Paste from clipboard in command mode" },
      },
      i = {
        ["<C-S-V>"] = { '<ESC>l"+Pli', desc = "Paste from clipboard in insert mode" },
      },
      t = {
        ["<C-S-V>"] = { '<C-\\><C-n>"+Pi', desc = "Paste from clipboard in terminal mode" },
      },
    },
  },
}
