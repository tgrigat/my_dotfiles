vim.g.mapleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
vim.scriptencoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.mouse = "a"
vim.opt.clipboard:append("unnamedplus")
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.autoread = true
vim.bo.autoread = true
vim.wo.signcolumn = "no"
vim.opt.termguicolors = true

-- below are keymaps

vim.cmd("colorscheme everforest")

local keymap = vim.keymap
keymap.set("n", "<leader>q", "<Cmd>q<CR>")
-- keymap.set("n", "<leader>w", "<Cmd>w<CR>")
keymap.set("n", "<C-a>", "gg<S-v>G")
keymap.set("n", "<leader>ss", ":vsplit<Return><C-w>w", {silent = true})
keymap.set("n", "<leader>w", "<C-w>w")
keymap.set("n", "<leader>h", "<C-w>h")
keymap.set("n", "<leader>j", "<C-w>j")
keymap.set("n", "<leader>k", "<C-w>k")
keymap.set("n", "<leader>l", "<C-w>l")
keymap.set("n", "<leader>s<left>", "10<C-w><")
keymap.set("n", "<leader>s<right>", "10<C-w>>")
keymap.set("n", "<leader>s<up>", "10<C-w>+")
keymap.set("n", "<leader>s<down>", "10<C-w>-")

keymap.set("n", "<S-h>", ":BufferLineCyclePrev<CR>")
keymap.set("n", "<S-l>", ":BufferLineCycleNext<CR>")
