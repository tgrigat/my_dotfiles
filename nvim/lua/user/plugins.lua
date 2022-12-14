local fn = vim.fn
-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end
-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end
-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}
-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]
--
return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    -- Leap for better navigation
    use { "ggandor/leap.nvim",
        config = function()
            require('leap').add_default_mappings()
        end
    }
    use 'sainnhe/everforest'
    use { 'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons',
        config = function() require("bufferline").setup {} end }
    use {
        'neovim/nvim-lspconfig',
        config = function() require('user.lsp') end
    } -- Configurations for Nvim LSP
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional, for file icons
        },
    } -- nvim tree for the file exploration
    -- The following plugins are borrowed from LunarVim
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use { 'hrsh7th/nvim-cmp',
        config = function() require('user.cmp') end,
        requires = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-cmdline' },
            -- {'SirVer/ultisnips'},
            -- {'quangnguyen30192/cmp-nvim-ultisnips'}
            { 'hrsh7th/cmp-vsnip' },
            { 'hrsh7th/vim-vsnip' },
            -- { "L3MON4D3/LuaSnip" },
            -- { "saadparwaiz1/cmp_luasnip" },
            { "onsails/lspkind.nvim" },
        },
    }
    use { "williamboman/mason.nvim", config = function()
        require("mason").setup()
    end }
    use {
        "jose-elias-alvarez/null-ls.nvim",
        requires = "PlatyPew/format-installer.nvim",
        after = "nvim-lspconfig", -- To prevent null-ls from failing to read buffer
    }
    use { 'nvim-lua/popup.nvim' }
    -- use { "akinsho/toggleterm.nvim", tag = '*', config = function()
    --   require("toggleterm").setup {
    --     active = true,
    --     on_config_done = nil,
    --     -- size can be a number or function which is passed the current terminal
    --     size = 20,
    --     open_mapping = [[<c-\>]],
    --     hide_numbers = true, -- hide the number column in toggleterm buffers
    --     shade_filetypes = {},
    --     shade_terminals = true,
    --     shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
    --     start_in_insert = true,
    --     insert_mappings = true, -- whether or not the open mapping applies in insert mode
    --     persist_size = false,
    --     -- direction = 'vertical' | 'horizontal' | 'window' | 'float',
    --     direction = "float",
    --     close_on_exit = true, -- close the terminal window when the process exits
    --     shell = vim.o.shell, -- change the default shell
    --     -- This field is only relevant if direction is set to 'float'
    --     float_opts = {
    --       -- The border key is *almost* the same as 'nvim_win_open'
    --       -- see :h nvim_win_open for details on borders however
    --       -- the 'curved' border is a custom border type
    --       -- not natively supported but implemented in this plugin.
    --       -- border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
    --       border = "curved",
    --       -- width = <value>,
    --       -- height = <value>,
    --       winblend = 0,
    --       highlights = {
    --         border = "Normal",
    --         background = "Normal",
    --       },
    --     },
    --     -- Add executables on the config.lua
    --     -- { exec, keymap, name}
    --     -- lvim.builtin.terminal.execs = {{}} to overwrite
    --     -- lvim.builtin.terminal.execs[#lvim.builtin.terminal.execs+1] = {"gdb", "tg", "GNU Debugger"}
    --     -- TODO: pls add mappings in which key and refactor this
    --     execs = {
    --       { vim.o.shell, "<M-1>", "Horizontal Terminal", "horizontal", 0.3 },
    --       { vim.o.shell, "<M-2>", "Vertical Terminal", "vertical", 0.4 },
    --       { vim.o.shell, "<M-3>", "Float Terminal", "float", nil },
    --     },
    --   }
    -- end }
    use { "akinsho/toggleterm.nvim", tag = '*', config = function()
        require("toggleterm").setup {
            require("user.terminal").setup()
        }
    end }
    -- use { "akinsho/toggleterm.nvim", tag = '*', config = function()
    --   require("toggleterm").setup {
    --     active = true,
    --     on_config_done = nil,
    --     -- size can be a number or function which is passed the current terminal
    --     size = 20,
    --     open_mapping = [[<c-\>]],
    --     hide_numbers = true, -- hide the number column in toggleterm buffers
    --     shade_filetypes = {},
    --     shade_terminals = true,
    --     shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
    --     start_in_insert = true,
    --     insert_mappings = true, -- whether or not the open mapping applies in insert mode
    --     persist_size = false,
    --     -- direction = 'vertical' | 'horizontal' | 'window' | 'float',
    --     direction = "float",
    --     close_on_exit = true, -- close the terminal window when the process exits
    --     shell = vim.o.shell, -- change the default shell
    --     -- This field is only relevant if direction is set to 'float'
    --     float_opts = {
    --       -- The border key is *almost* the same as 'nvim_win_open'
    --       -- see :h nvim_win_open for details on borders however
    --       -- the 'curved' border is a custom border type
    --       -- not natively supported but implemented in this plugin.
    --       -- border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
    --       border = "curved",
    --       -- width = <value>,
    --       -- height = <value>,
    --       winblend = 0,
    --       highlights = {
    --         border = "Normal",
    --         background = "Normal",
    --       },
    --     },
    --     -- Add executables on the config.lua
    --     -- { exec, keymap, name}
    --     -- lvim.builtin.terminal.execs = {{}} to overwrite
    --     -- lvim.builtin.terminal.execs[#lvim.builtin.terminal.execs+1] = {"gdb", "tg", "GNU Debugger"}
    --     -- TODO: pls add mappings in which key and refactor this
    --     execs = {
    --       { vim.o.shell, "<M-1>", "Horizontal Terminal", "horizontal", 0.3 },
    --       { vim.o.shell, "<M-2>", "Vertical Terminal", "vertical", 0.4 },
    --       { vim.o.shell, "<M-3>", "Float Terminal", "float", nil },
    --     },
    --   }
    -- end }
    use 'rcarriga/nvim-notify'
    use "goolord/alpha-nvim"
    use { "folke/which-key.nvim" }
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        config = function()
            require("user.lualine")
        end
    }
    use { "mhartington/formatter.nvim",
        config = function()
            pcall(require, "user.formatter")
        end
    }
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = function()
            require("user.nvim-tree")
        end
    }

    use {
        "windwp/nvim-autopairs",
        config = function() require("user.autopair") end
    }
    -- Autopairsintegrates with both cmp and treesitter
    use "williamboman/nvim-lsp-installer"

    use {
        "petertriho/nvim-scrollbar",
        config = function()
            require("scrollbar").setup()
        end
    }

    --
    use {
        "glepnir/lspsaga.nvim",
        branch = "main",
        config = function()
            local saga = require("lspsaga")
            saga.init_lsp_saga({
                -- your configuration
                border_style = "rounded",
                symbol_in_winbar = {
                    in_custom = true,
                    click_support = function(node, clicks, button, modifiers)
                        -- To see all available details: vim.pretty_print(node)
                        local st = node.range.start
                        local en = node.range['end']
                        if button == "l" then
                            if clicks == 2 then
                                -- double left click to do nothing
                            else -- jump to node's starting line+char
                                vim.fn.cursor(st.line + 1, st.character + 1)
                            end
                        elseif button == "r" then
                            if modifiers == "s" then
                                print "lspsaga" -- shift right click to print "lspsaga"
                            end -- jump to node's ending line+char
                            vim.fn.cursor(en.line + 1, en.character + 1)
                        elseif button == "m" then
                            -- middle click to visual select node
                            vim.fn.cursor(st.line + 1, st.character + 1)
                            vim.cmd "normal v"
                            vim.fn.cursor(en.line + 1, en.character + 1)
                        end
                    end
                },
                show_outline = {
                    win_position = 'right',
                    --set special filetype win that outline window split.like NvimTree neotree
                    -- defx, db_ui
                    win_with = '',
                    win_width = 30,
                    auto_enter = true,
                    auto_preview = true,
                    virt_text = '┃',
                    jump_key = 'o',
                    -- auto refresh when change buffer
                    auto_refresh = true,
                },
            })
        end,
    }

    use { "numToStr/Comment.nvim",
        config = function()
            require("user.comment")
        end
    }
    use { "tpope/vim-surround" }
    use {
        'mrjones2014/legendary.nvim'
        -- sqlite is only needed if you want to use frecency sorting
        -- requires = 'kkharji/sqlite.lua'
    }
    use { 'stevearc/dressing.nvim' }
    use { "dccsillag/magma-nvim", run = ':UpdateRemotePlugins' }
    -- indent blankline
    use { "lukas-reineke/indent-blankline.nvim" }

    -- comment
    use 'JoosepAlviste/nvim-ts-context-commentstring'
    use {
        "ahmedkhalf/project.nvim",
        config = function()
            require("user.project").setup()
        end
    }
    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end
    }
    use "rafamadriz/friendly-snippets"
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
