local keymap = vim.keymap

keymap.set("n", "gr", "<Cmd>call VSCodeNotifyVisual("editor.action.goToReferences")<CR>")
