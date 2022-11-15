vim.opt.clipboard:append("unnamedplus")

local keymap = vim.api.nvim_set_keymap

local opts = {
    noremap = true,
    silent = true
}

keymap("n", "j", "jzz", opt)
keymap("n", "k", "kzz", opt)
