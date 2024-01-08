-- vim.api.nvim_create_autocmd({'TextChanged', 'TextChangedI'}, {
--     callback = function(e)
--         if vim.g.timer_started == true then
--             return
--         end
--         vim.g.timer_started = true
--         vim.fn.timer_start(10000, function()
--             vim.g.timer_started = false
--             write
--         end)
--     end
-- end})
--
vim.opt.background = 'light'
vim.o.laststatus = 0
vim.g.firenvim_config = {
  globalSettings = { alt = "all" },
}

vim.g.mapleader = ' '
vim.api.nvim_set_keymap('n', '<leader>q', ':wq<CR>', {noremap = true, silent = true})

