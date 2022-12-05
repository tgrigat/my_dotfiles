vim.g.mapleader = " "

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
