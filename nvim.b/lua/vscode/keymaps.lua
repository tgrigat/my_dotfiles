vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "gr", "<Cmd>call VSCodeNotifyVisual('editor.action.goToReferences',1)<CR>")

keymap.set("n", "<leader>ft", "<Cmd>call VSCodeNotifyVisual('workbench.files.action.focusFilesExplorer',1)<CR>")

keymap.set("n", "<leader>t", "<Cmd>call VSCodeNotifyVisual('workbench.files.action.focusFilesExplorer',1)<CR>")

keymap.set("n", "<leader>z", "<Cmd>call VSCodeNotifyVisual('workbench.action.toggleZenMode',1)<CR>")

keymap.set("n", "<C-w>gd", "<Cmd>call VSCodeNotify('editor.action.revealDefinitionAside')<CR>")

keymap.set("n", "?", "<Cmd>call VSCodeNotify('workbench.action.findInFiles', { 'query': expand('<cword>')})<CR>")

keymap.set("n", "j", "jzz")
keymap.set("n", "k", "kzz")


