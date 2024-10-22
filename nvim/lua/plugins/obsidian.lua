local workspaces = {
  { name = "public", path = "~/Documents/git/Notes/content", strict = true },
  { name = "private", path = "~/obsidian/" },
}

local function workspace_exists(workspace) return vim.fn.isdirectory(vim.fn.expand(workspace.path)) == 1 end

local any_workspace_exists = false
for _, workspace in ipairs(workspaces) do
  if workspace_exists(workspace) then
    any_workspace_exists = true
    break
  end
end

if not any_workspace_exists then return {} end

return {
  "epwalsh/obsidian.nvim",
  -- Event for all defined workspaces
  event = function()
    local events = {}
    for _, workspace in ipairs(workspaces) do
      if workspace_exists(workspace) then
        table.insert(events, "BufReadPre " .. vim.fn.expand(workspace.path) .. "/*.md")
      end
    end
    return events
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
    "nvim-telescope/telescope.nvim",
    {
      "AstroNvim/astrocore",
      opts = {
        options = {
          opt = {
            conceallevel = 1, -- sets vim.opt.conceallevel to 1
          },
        },
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
  opts = function(_, opts)
    -- opts parameter is the default options table
    -- overwrite the entire opts table
    return {
      use_advanced_uri = true,
      finder = "telescope.nvim",
      workspaces = workspaces,
      -- templates = {
      --   subdir = "templates",
      --   date_format = "%Y-%m-%d-%a",
      --   time_format = "%H:%M",
      -- },
      open_app_foreground = true,
      note_frontmatter_func = function(note)
        local out = { id = note.id, aliases = note.aliases, tags = note.tags }
        if note.metadata ~= nil and require("obsidian").util.table_length(note.metadata) > 0 then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end
        return out
      end,
      mappings = {
        -- ["gf"] = {
        --   action = function() return require("obsidian").util.gf_passthrough() end,
        --   opts = { noremap = false, expr = true, buffer = true },
        -- },
        -- ["<leader>ch"] = {
        --   action = function() return require("obsidian").util.toggle_checkbox() end,
        --   opts = { buffer = true },
        -- },
        ["<cr>"] = {
          action = function() return require("obsidian").util.smart_action() end,
          opts = { buffer = true, expr = true },
        },
      },
      follow_url_func = vim.ui.open or function(url) require("astrocore").system_open(url) end,
      -- Optional, configure additional syntax highlighting / extmarks.
      -- This requires you have `conceallevel` set to 1 or 2. See `:help conceallevel` for more details.
      ui = {
        enable = true, -- set to false to disable all additional syntax features
        update_debounce = 200, -- update delay after a text change (in milliseconds)
        max_file_length = 5000, -- disable UI features for files with more than this many lines
        -- Define how various check-boxes are displayed
        checkboxes = {
          -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
          [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
          ["x"] = { char = "", hl_group = "ObsidianDone" },
          [">"] = { char = "", hl_group = "ObsidianRightArrow" },
          ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
          ["!"] = { char = "", hl_group = "ObsidianImportant" },
          -- Replace the above with this if you don't have a patched font:
          -- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
          -- ["x"] = { char = "✔", hl_group = "ObsidianDone" },

          -- You can also add more custom ones...
        },
        -- Use bullet marks for non-checkbox lists.
        bullets = { char = "•", hl_group = "ObsidianBullet" },
        external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
        -- Replace the above with this if you don't have a patched font:
        -- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
        reference_text = { hl_group = "ObsidianRefText" },
        highlight_text = { hl_group = "ObsidianHighlightText" },
        tags = { hl_group = "ObsidianTag" },
        block_ids = { hl_group = "ObsidianBlockID" },
        hl_groups = {
          -- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
          ObsidianTodo = { bold = true, fg = "#f78c6c" },
          ObsidianDone = { bold = true, fg = "#89ddff" },
          ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
          ObsidianTilde = { bold = true, fg = "#ff5370" },
          ObsidianImportant = { bold = true, fg = "#d73128" },
          ObsidianBullet = { bold = true, fg = "#89ddff" },
          ObsidianRefText = { underline = true, fg = "#c792ea" },
          ObsidianExtLinkIcon = { fg = "#c792ea" },
          ObsidianTag = { italic = true, fg = "#89ddff" },
          ObsidianBlockID = { italic = true, fg = "#89ddff" },
          ObsidianHighlightText = { bg = "#75662e" },
        },
      },

      -- Specify how to handle attachments.
      attachments = {
        -- The default folder to place images in via `:ObsidianPasteImg`.
        -- If this is a relative path it will be interpreted as relative to the vault root.
        -- You can always override this per image by passing a full path to the command instead of just a filename.
        img_folder = "assets/imgs", -- This is the default

        -- Optional, customize the default name or prefix when pasting images via `:ObsidianPasteImg`.
        ---@return string
        img_name_func = function()
          -- Prefix image names with timestamp.
          return string.format("%s-", os.time())
        end,

        -- A function that determines the text to insert in the note when pasting an image.
        -- It takes two arguments, the `obsidian.Client` and an `obsidian.Path` to the image file.
        -- This is the default implementation.
        ---@param client obsidian.Client
        ---@param path obsidian.Path the absolute path to the image file
        ---@return string
        img_text_func = function(client, path)
          path = client:vault_relative_path(path) or path
          return string.format("![%s](%s)", path.name, path)
        end,
      },
    }
  end,
}
