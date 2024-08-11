-- if true then return {} end

return {
  "epwalsh/obsidian.nvim",
  -- the obsidian vault in this default config  ~/obsidian-vault
  -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand':
  -- event = { "BufReadPre " .. vim.fn.expand "~" .. "/obsidian/**.md" },
  -- event = { "BufReadPre  */obsidian/*.md" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
    "nvim-telescope/telescope.nvim",
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            ["<Leader>O"] = { name = "Obsidian" },
            ["<Leader>Ot"] = { "<cmd>ObsidianToday<cr>", desc = "Daily note" },
            ["<Leader>Oy"] = { "<cmd>ObsidianYesterday<cr>", desc = "Yesterday's note" },
            ["<Leader>Of"] = { "<cmd>ObsidianSearch<cr>", desc = "Search notes" },
            ["<Leader>Og"] = { "<cmd>ObsidianFollowLink<cr>", desc = "Goto link" },
            ["<Leader>Oo"] = { "<cmd>ObsidianOpen<cr>", desc = "Open Obsidian" },
            ["<Leader>Oc"] = {
              function() return require("obsidian").util.toggle_checkbox() end,
              desc = "Toggle checkbox",
            },
            ["gf"] = {
              function()
                if require("obsidian").util.cursor_on_markdown_link() then
                  return "<Cmd>ObsidianFollowLink<CR>"
                else
                  return "gf"
                end
              end,
              desc = "Obsidian Follow Link",
            },
          },
        },
      },
    },
  },
  opts = {
    dir = vim.env.HOME .. "/obsidian", -- specify the vault location. no need to call 'vim.fn.expand' here
    use_advanced_uri = true,
    finder = "telescope.nvim",

    templates = {
      subdir = "templates",
      date_format = "%Y-%m-%d-%a",
      time_format = "%H:%M",
    },

    note_frontmatter_func = function(note)
      -- This is equivalent to the default frontmatter function.
      local out = { id = note.id, aliases = note.aliases, tags = note.tags }
      -- `note.metadata` contains any manually added fields in the frontmatter.
      -- So here we just make sure those fields are kept in the frontmatter.
      if note.metadata ~= nil and require("obsidian").util.table_length(note.metadata) > 0 then
        for k, v in pairs(note.metadata) do
          out[k] = v
        end
      end
      return out
    end,

    -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
    -- URL it will be ignored but you can customize this behavior here.
    follow_url_func = vim.ui.open or function(url) require("astrocore").system_open(url) end,
  },
}
