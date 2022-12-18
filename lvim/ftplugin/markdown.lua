local g = vim.g

g.mkdp_auto_start = 0

g.mkdp_auto_close = 0

lvim.builtin.which_key["M"] = {
  name="Markdown",
  p = {"<cmd>MarkdownPreviewToggle<cr>", "Toggle preview"}
}
