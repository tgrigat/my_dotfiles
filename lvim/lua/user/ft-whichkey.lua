local status_ok, wk = pcall(require, "which-key")
if not status_ok then
  return
end
-- local bufNo = vim.fn.bufnr('%') -- this function is not available now.


-------------------- Python Buffer Key Bindings ------------------------------
--
---- Get current buffer number
-- local bufNo = vim.api.nvim_get_current_buf()

-- Create the autocommand
vim.api.nvim_create_autocmd({ "FileType" }, {
  callback = function(ev)
    if vim.bo.filetype == 'python' then
      vim.cmd("lua WhichKeyPython(" .. ev.buf .. ")")
    end
  end
})

function WhichKeyPython(bufNumber)
  wk.register({
    ["<leader>j"] = {
      name = "Jupyter",
      i = { "<Cmd>MagmaInit<CR>", "Init Magma" },
      d = { "<Cmd>MagmaDeinit<CR>", "Deinit Magma" },
      e = { "<Cmd>MagmaEvaluateLine<CR>", "Evaluate Line" },
      r = { "<Cmd>MagmaReevaluateCell<CR>", "Re evaluate cell" },
      D = { "<Cmd>MagmaDelete<CR>", "Delete cell" },
      s = { "<Cmd>MagmaShowOutput<CR>", "Show Output" },
      R = { "<Cmd>MagmaRestart!<CR>", "Restart Magma" },
      S = { "<Cmd>MagmaSave<CR>", "Save" },
    },
    ["<leader>d"] = {
      name = "Debug",
      s = { "<cmd>lua require('dap-python').debug_selection()<cr>", "Debug Selection" },
      f = { "<cmd>lua require('dap-python').test_class()<cr>", "Test Class" },
      m = { "<cmd>lua require('dap-python').test_method()<cr>", "Test Method" }
    },
  }, { buffer = bufNumber })
end

-------------------- Tex Buffer Key Bindings ------------------------------

vim.api.nvim_create_autocmd({ "FileType" }, {
  callback = function(ev)
    if vim.bo.filetype == 'tex' then
      vim.cmd("lua WhichKeyTex(" .. ev.buf .. ")")
    end
  end
})
function WhichKeyTex(bufNumber)
  wk.register({
    -- ["<leader>j"] = {
    --   name = "Jupyter",
    --   i = { "<Cmd>MagmaInit<CR>", "Init Magma" },
    --   d = { "<Cmd>MagmaDeinit<CR>", "Deinit Magma" },
    --   e = { "<Cmd>MagmaEvaluateLine<CR>", "Evaluate Line" },
    --   r = { "<Cmd>MagmaReevaluateCell<CR>", "Re evaluate cell" },
    --   D = { "<Cmd>MagmaDelete<CR>", "Delete cell" },
    --   s = { "<Cmd>MagmaShowOutput<CR>", "Show Output" },
    --   R = { "<Cmd>MagmaRestart!<CR>", "Restart Magma" },
    --   S = { "<Cmd>MagmaSave<CR>", "Save" },
    -- },
    -- ["<leader>d"] = {
    --   name = "Debug",
    --   s = { "<cmd>lua require('dap-python').debug_selection()<cr>", "Debug Selection" },
    --   f = { "<cmd>lua require('dap-python').test_class()<cr>", "Test Class" },
    --   m = { "<cmd>lua require('dap-python').test_method()<cr>", "Test Method" }
    -- },
  }, { buffer = bufNumber })
end

-------------------- Tex Buffer Key Bindings ------------------------------

vim.api.nvim_create_autocmd({ "FileType" }, {
  callback = function(ev)
    if vim.bo.filetype == 'norg' then
      vim.cmd("lua WhichKeyNorg(" .. ev.buf .. ")")
    end
  end
})
function WhichKeyNorg(bufNumber)
  wk.register({
    ["<localleader>c"] = {
      { "<cmd>Neorg toggle-concealer<CR>", "Toggle Concealer" },
    },
    ["<localleader>i"] = {
      name = "Inject",
      m = { "<cmd>Neorg inject-metadata<CR>", "Inject Metadata" },
      s = { "<cmd>Neorg generate-workspace-summary<CR>", "Inject Summary" },
      l = { "<cmd>Telescope neorg insert_file_link<CR>", "Insert Link" },
    },
    ["<localleader>l"] = { "<cmd>Telescope neorg insert_file_link<CR>", "Insert Link" },
    ["<localleader>f"] = { "<cmd>Telescope neorg find_linkable<CR>", "Find Element" },
    ["<localleader>k"] = { "<cmd>Neorg keybind norg<cr>", "Neorg keybindings" },
    ["<localleader>m"] = {
      name = "Mode",
      n = { "<cmd>Neorg mode norg<cr>", "Normal" },
      h = { "<cmd>Neorg mode traverse-heading<cr>", "Headings" },
      l = { "<cmd>Neorg mode traverse-link<cr>", "Links" },
    },
    ["<localleader>e"] = { "<cmd>Neorg keybind all core.looking-glass.magnify-code-block<cr>", "Edit Code" },
    ["<localleader>t"] = {
      name = "Task",
      d = { "<cmd>Neorg keybind norg core.qol.todo_items.todo.task_done<cr>", "Done" },
      u = { "<cmd>Neorg keybind norg core.qol.todo_items.todo.task_undone<cr>", "Undone" },
      p = { "<cmd>Neorg keybind norg core.qol.todo_items.todo.task_pending<cr>", "Pending" },
      h = { "<cmd>Neorg keybind norg core.qol.todo_items.todo.task_on_hold<cr>", "On Hold" },
      c = { "<cmd>Neorg keybind norg core.qol.todo_items.todo.task_cancelled<cr>", "Cancelled" },
      r = { "<cmd>Neorg keybind norg core.qol.todo_items.todo.task_recurring<cr>", "Recurring" },
      i = { "<cmd>Neorg keybind norg core.qol.todo_items.todo.task_important<cr>", "Important" },
      
      
    },
    ["<localleader>d"] = { "<cmd>Neorg keybind norg core.qol.todo_items.todo.task_done<cr>", "Task Done" },
    ["<localleader>u"] = { "<cmd>Neorg keybind norg core.qol.todo_items.todo.task_undone<cr>", "Task Undone" },
    ["<localleader>p"] = { "<cmd>Neorg keybind norg core.qol.todo_items.todo.task_pending<cr>", "Task Pending" },
    -- ["<leader>d"] = {
    --   name = "Debug",
    --   s = { "<cmd>lua require('dap-python').debug_selection()<cr>", "Debug Selection" },
    --   f = { "<cmd>lua require('dap-python').test_class()<cr>", "Test Class" },
    --   m = { "<cmd>lua require('dap-python').test_method()<cr>", "Test Method" }
    -- },
  }, { buffer = bufNumber })
end

-------------------- Obsidian Markdown Buffer Key Bindings ------------------------------


local obsidian_dir = vim.fn.expand('~/obsidian')

local function setup_whichkey_markdown()
  local current_dir = vim.fn.expand('%:p:h')
  if vim.bo.filetype == 'markdown' and string.find(current_dir, '^' .. obsidian_dir) then
    WhichKeyObMarkdown(vim.api.nvim_get_current_buf())
  end
end

-- Create the FileType autocmd as before
vim.api.nvim_create_autocmd({ "FileType" }, {
  callback = setup_whichkey_markdown
})

-- Add a new autocmd for BufEnter
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = "*.md",
  callback = setup_whichkey_markdown
})

function WhichKeyObMarkdown(bufNumber)
  wk.register({
    ["<localleader>f"] = { "<cmd>ObsidianSearch<cr>", "Find notes" },
    ["<localleader>t"] = { "<cmd>ObsidianToday<cr>", "Daily note" },
    ['gl'] = { "<cmd>ObsidianFollowLink<cr>", "Goto link" },
  }, { buffer = bufNumber })
end
