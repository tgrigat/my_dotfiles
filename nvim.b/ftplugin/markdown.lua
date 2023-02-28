local g = vim.g

g.mkdp_auto_start = 1

g.mkdp_auto_close = 1

lvim.builtin.which_key["M"] = {
  name="Markdown",
  p = {"<cmd>MarkdownPreviewToggle<cr>", "Toggle preview"}
}
