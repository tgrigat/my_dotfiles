-------------------------------------------------------------------------
----------------------- Additional requires -----------------------------
-------------------------------------------------------------------------
lvim.log.level = "warn"
lvim.format_on_save = false
lvim.colorscheme = "everforest"

reload("user.lsp")
reload("user.keymaps")
reload("user.lvim_plugins")
-- reload("user.cmp")
reload("user.legendary")
reload("user.which-key")
reload("user.alpha")
reload("user.indent_blankline")
reload("user.lvim_opt")
reload("user.terminal")

-------------------------------------------------------------------------
----------------------- Basic setups  -----------------------------------
-------------------------------------------------------------------------
-- general
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

lvim.builtin.breadcrumbs.active = false

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
  "markdown"
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true
lvim.builtin.treesitter.rainbow.enable = true

lvim.builtin.lir.active = false

lvim.format_on_save = false
lvim.builtin.terminal.active = true

-- The bufferline modification

lvim.builtin.bufferline.options.numbers = "ordinal"
lvim.builtin.bufferline.options.numbers = "ordinal"
lvim.builtin.bufferline.options.max_name_length = 35

-- All the treesitter parsers you want to install. If you want all of them, just
-- replace everything with "all".



vim.api.nvim_create_autocmd("FileType", {
  pattern = "zsh",
  callback = function()
    -- let treesitter use bash highlight for zsh files as well
    require("nvim-treesitter.highlight").attach(0, "bash")
  end,
})
