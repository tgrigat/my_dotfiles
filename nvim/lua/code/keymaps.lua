vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "gr", "<Cmd>call VSCodeNotifyVisual('editor.action.goToReferences',1)<CR>")

keymap.set("n", "<leader>ft", "<Cmd>call VSCodeNotifyVisual('workbench.files.action.focusFilesExplorer',1)<CR>")

keymap.set("n", "<leader>t", "<Cmd>call VSCodeNotifyVisual('workbench.files.action.focusFilesExplorer',1)<CR>")

keymap.set("n", "<leader>z", "<Cmd>call VSCodeNotifyVisual('workbench.action.toggleZenMode',1)<CR>")

keymap.set("n", "<C-w>gd", "<Cmd>call VSCodeNotify('editor.action.revealDefinitionAside')<CR>")

keymap.set("n", "?", "<Cmd>call VSCodeNotify('workbench.action.findInFiles', { 'query': expand('<cword>')})<CR>")

keymap.set("n", "<C-h>", "<Cmd>call VSCodeNotify('workbench.action.focusLeftGroup')<CR>")

keymap.set("n", "<C-l>", "<Cmd>call VSCodeNotify('workbench.action.focusRightGroup')<CR>")

keymap.set("n", "<S-h>", "<Cmd>call VSCodeNotify('workbench.action.previousEditor')<CR>")

keymap.set("n", "<S-l>", "<Cmd>call VSCodeNotify('workbench.action.nextEditor')<CR>")

-- keymap.set("n", "<C-\>", "<Cmd>call VSCodeNotify('workbench.action.terminal.toggleTerminal')<CR>")

keymap.set("n", "<leader>w", "<Cmd>call VSCodeNotify('workbench.action.files.save')<CR>")

keymap.set("n", "<leader>f", "<Cmd>call VSCodeNotify('workbench.action.showCommands')<BS><CR>")

keymap.set("n", "<leader>e", "<Cmd>call VSCodeNotify('workbench.files.action.focusFilesExplorer')<CR>")

keymap.set("n", "<leader>c", "<Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>")


-- keymap.set("n", "j", "jzz")
-- keymap.set("n", "k", "kzz")
