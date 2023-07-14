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

keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")

-- keymap.set("n", "<C-\>", "<Cmd>call VSCodeNotify('workbench.action.terminal.toggleTerminal')<CR>")

keymap.set("n", "<leader>w", "<Cmd>call VSCodeNotify('workbench.action.files.save')<CR>")

keymap.set("n", "<leader>f", "<Cmd>call VSCodeNotify('workbench.action.showCommands')<BS><CR>")

keymap.set("n", "<leader>e", "<Cmd>call VSCodeNotify('workbench.files.action.focusFilesExplorer')<CR>")

keymap.set("n", "<leader>c", "<Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>")

-- function vscodeCommentary(line1, line2)
--     if not line1 or not line2 then
--         vim.o.operatorfunc = vim.fn.matchstr(vim.fn.expand('<sfile>'), '[^. ]*')
--         return 'g@'
--     end
--     vim.api.nvim_call_function('VSCodeCallRange', {'editor.action.commentLine', line1, line2, 0})
-- end

keymap.set("n", "gcc", "<Cmd>call VSCodeNotify('editor.action.commentLine')<CR>")
keymap.set("v", "gc", "<Cmd>call VSCodeNotifyVisual('editor.action.commentLine', 0)<CR>")

-- keymap.set("v", ">", "<Cmd>call VSCodeNotifyVisual('editor.action.indentLines',1 )<CR>")
keymap.set("v", ">", ">gv")
keymap.set("v", "<", "<gv")
-- keymap.set("v", "<", "<Cmd>call VSCodeNotifyVisual('editor.action.reindentselectedlines', 1)<CR>")


-- keymap.set("n", "j", "jzz")
-- keymap.set("n", "k", "kzz")
