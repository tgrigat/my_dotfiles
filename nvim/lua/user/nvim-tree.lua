require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
        {key = { "l", "<CR>", "o" }, action = "edit", mode = "n"},
        { key = "v", action = "vsplit"},
        { key = "c", action = "copy_absolute_path"},
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
