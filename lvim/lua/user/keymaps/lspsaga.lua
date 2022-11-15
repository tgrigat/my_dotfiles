local keymap = vim.keymap.set
local whichkey = lvim.builtin.which_key

-- Lsp finder find the symbol definition implement reference
-- if there is no implement it will hide
-- when you use action in finder like open vsplit then you can
-- use <C-t> to jump back
keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })

whichkey.mappings["o"] = {"<Cmd>LSoutlineToggle<CR>" ," Toggle outline"}

-- Hover Doc
keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
