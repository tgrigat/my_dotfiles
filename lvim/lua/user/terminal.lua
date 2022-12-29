lvim.builtin.terminal.active = true
lvim.builtin.terminal.execs = {
  { vim.o.shell, "<C-->", "Horizontal Terminal", "horizontal", 0.3 },
  { vim.o.shell, "<C-=>", "Vertical Terminal", "vertical", 0.4 },
  { vim.o.shell, "<C-0>", "Float Terminal", "float", nil },
}
