return {
  "AstroNvim/astrocore",
  ---@param opts AstroCoreOpts
  opts = function(_, opts)
    local nmaps = opts.mappings.n
    -- Dap telescope
    nmaps["<Leader>dw"] = {
      function() require("telescope").extensions.dap.configurations() end,
      desc = "Configurations",
    }

    -- Section Search
    local leaders_tbl = {
      name = "Search",
      ["m"] = { function() require("telescope.builtin").marks { initial_mode = "normal" } end, "Marks" },
      ["s"] = { "<cmd>lua require('telescope.builtin').treesitter()<cr>", "Treesitter Symbol" },
      ["w"] = {
        function() require("telescope.builtin").current_buffer_fuzzy_find() end,
        "Words in current buffer",
      },
      ["t"] = {
        function()
          require("telescope.builtin").live_grep {
            additional_args = function(args) return vim.list_extend(args, { "--hidden", "--no-ignore" }) end,
          }
        end,
        "Text",
      },
      ["r"] = { function() require("telescope.builtin").registers() end, "Registers" },
      ["k"] = { function() require("telescope.builtin").keymaps() end, "Keymaps" },
      ["o"] = { function() require("telescope.builtin").oldfiles() end, "History" },
      ["M"] = { function() require("telescope.builtin").man_pages() end, "Man" },
      ["n"] = { function() require("telescope").extensions.notify.notify() end, "Notifications" },
      ["h"] = { function() require("telescope.builtin").help_tags() end, "Help" },
      ["C"] = { function() require("telescope.builtin").commands() end, "Commands" },
      ["T"] = {
        function() require("telescope.builtin").colorscheme { enable_preview = true } end,
        "Themes",
      },
      ["a"] = {
        function()
          require("telescope.builtin").find_files {
            prompt_title = "Config Files",
            cwd = vim.fn.stdpath "config",
            follow = true,
          }
        end,
        "AstroNvim config files",
      },
      ["<CR>"] = { function() require("telescope.builtin").resume() end, "Resume previous search" },
      ["f"] = { function() require("telescope.builtin").find_files() end, "Files" },
      ["b"] = {
        function()
          require("telescope.builtin").buffers {
            show_all_buffers = true,
            sort_lastused = true,
            ignore_current_buffer = true,
          }
        end,
        "Buffers",
      },
    }

    require("astrocore").extend_tbl(nmaps["<Leader>s"], leaders_tbl)

    if not nmaps["<Leader>s"] then
      nmaps["<Leader>s"] = leaders_tbl
    else
      nmaps["<Leader>s"] = require("astrocore").extend_tbl(nmaps["<Leader>s"], leaders_tbl)
    end

    nmaps["<Leader>lV"] = { "<cmd>lua vim.diagnostic.config({virtual_text = false})<cr>", desc = "VirtualText Off" }
    nmaps["<Leader>lv"] = { "<cmd>lua vim.diagnostic.config({virtual_text = true})<cr>", desc = "VirtualText On" }
    nmaps["<Leader>=w"] = { "<cmd>set wrap<cr>", desc = "Wrap" }
    nmaps["<Leader>=W"] = { "<cmd>set nowrap<cr>", desc = "Unwrap" }
    nmaps["<C-\\>"] = { "<Cmd>ToggleTerm direction=float<CR>", desc = "ToggleTerm float" }

    -- -- disable default leader-f mappings
    for lhs, _ in pairs(nmaps) do
      if lhs:match "^<Leader>f" then nmaps[lhs] = nil end
    end

    nmaps["<Leader>f"] = { function() require("telescope.builtin").find_files() end, desc = "Find files" }
    -- TODO config here: https://github.com/AstroNvim/AstroNvim/blob/b505f4ff41f851fa4a008586995f79408daf72bc/lua/astronvim/plugins/todo-comments.lua#L12
    -- dap telescope, related shortcuts are here: https://github.com/AstroNvim/astrocommunity/blob/main/lua/astrocommunity/debugging/telescope-dap-nvim/init.lua

    nmaps["<Leader>bf"] = {
      function()
        require("telescope.builtin").buffers {
          show_all_buffers = true,
          sort_lastused = true,
          ignore_current_buffer = true,
        }
      end,
      desc = "Buffers",
    }
  end,
}
