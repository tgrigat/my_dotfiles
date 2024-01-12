-- vim.api.nvim_create_autocmd({ 'TextChanged', 'TextChangedI' }, {
--   nested = true,
--   command = "write"
-- })

vim.opt.background = 'light'
vim.o.laststatus = 0
vim.g.firenvim_config = {
  globalSettings = { alt = "all" },
}
vim.opt.clipboard = "unnamedplus"

vim.g.mapleader = ' '
vim.api.nvim_set_keymap('n', '<leader>q', ':wq<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>w', ':w<CR>', { noremap = true, silent = true })

vim.g.firenvim_config = {
  globalSettings = {
    ignoreKeys = {
      all = { '<A-1>', '<A-2>', '<A-3>', '<A-4>', '<A-5>', '<A-6>', '<A-7>', '<A-8>', '<A-9>' }
    }
  }
}
vim.g.firenvim_config.localSettings['.*'] = { cmdline = 'firenvim' }
