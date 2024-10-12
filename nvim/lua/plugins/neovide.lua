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
      g = {
        neovide_cursor_animation_length = 0.07,
        neovide_cursor_trail_size = 0.6,
        neovide_cursor_smooth_blink = true,
      },
      -- g = { clipboard = "unnamedplus" },
    },
    mappings = {
      n = {
        ["<C-S-V>"] = {
          function() vim.api.nvim_paste(vim.fn.getreg "+", true, -1) end,
          desc = "Paste from clipboard (normal mode)",
        },
      },
      v = {
        ["<C-S-V>"] = {
          function() vim.api.nvim_paste(vim.fn.getreg "+", true, -1) end,
          desc = "Paste from clipboard (visual mode)",
        },
      },
      s = {
        ["<C-S-V>"] = {
          function() vim.api.nvim_paste(vim.fn.getreg "+", true, -1) end,
          desc = "Paste from clipboard (select mode)",
        },
      },
      x = {
        ["<C-S-V>"] = {
          function() vim.api.nvim_paste(vim.fn.getreg "+", true, -1) end,
          desc = "Paste from clipboard (visual block mode)",
        },
      },
      o = {
        ["<C-S-V>"] = {
          function() vim.api.nvim_paste(vim.fn.getreg "+", true, -1) end,
          desc = "Paste from clipboard (operator-pending mode)",
        },
      },
      i = {
        ["<C-S-V>"] = {
          function() vim.api.nvim_paste(vim.fn.getreg "+", true, -1) end,
          desc = "Paste from clipboard (insert mode)",
        },
      },
      l = {
        ["<C-S-V>"] = {
          function() vim.api.nvim_paste(vim.fn.getreg "+", true, -1) end,
          desc = "Paste from clipboard (language-specific mode)",
        },
      },
      c = {
        ["<C-S-V>"] = {
          function() vim.api.nvim_paste(vim.fn.getreg "+", true, -1) end,
          desc = "Paste from clipboard (command-line mode)",
        },
      },
      t = {
        ["<C-S-V>"] = {
          function() vim.api.nvim_paste(vim.fn.getreg "+", true, -1) end,
          desc = "Paste from clipboard (terminal mode)",
        },
      },
    },
  },
}
