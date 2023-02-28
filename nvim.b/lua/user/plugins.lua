local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--single-branch",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
end
vim.opt.runtimepath:prepend(lazypath)


vim.g.mapleader = " " -- make sure to set `mapleader` before lazy so your mappings are correct

local plugins = {
    -- Packer can manage itself
    -- Leap for better navigation
    { "ggandor/leap.nvim",
        config = function()
            require('leap').add_default_mappings()
        end
    },
    'sainnhe/everforest',
    { 'akinsho/bufferline.nvim', version = "v3.*",
        config = function() require("bufferline").setup {} end },
    {
        'neovim/nvim-lspconfig',
        config = function() require('user.lsp') end
    }, -- Configurations for Nvim LSP
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = {
            'kyazdani42/nvim-web-devicons', opt = true
        },
    }, -- nvim tree for the file exploration
    -- The following plugins are borrowed from LunarVim
    {
        'nvim-telescope/telescope.nvim', version = '0.1.0',
        -- or                            , branch = '0.1.x',
        dependencies = { { 'nvim-lua/plenary.nvim' } }
    },
    { 'hrsh7th/nvim-cmp',
        config = function() require('user.cmp') end,
        dependencies = {
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
    },
    { "williamboman/mason.nvim", config = function()
        require("mason").setup()
    end },
    {
        "jose-elias-alvarez/null-ls.nvim",
        dependencies = "PlatyPew/format-installer.nvim",
        after = "nvim-lspconfig", -- To prevent null-ls from failing to read buffer
    },
    { 'nvim-lua/popup.nvim' },
    { "akinsho/toggleterm.nvim", version = '*', config = function()
        require("toggleterm").setup {
            require("user.terminal").setup()
        }
    end },
    'rcarriga/nvim-notify',
    "goolord/alpha-nvim",
    { "folke/which-key.nvim" },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'kyazdani42/nvim-web-devicons', opt = true },
        config = function()
            require("user.lualine")
        end
    },
    { "mhartington/formatter.nvim",
        config = function()
            pcall(require, "user.formatter")
        end
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("user.nvim-tree")
        end
    },

    {
        "windwp/nvim-autopairs",
        config = function() require("user.autopair") end
    },
    -- Autopairsintegrates with both cmp and treesitter
    "williamboman/nvim-lsp-installer",

    {
        "petertriho/nvim-scrollbar",
        config = function()
            require("scrollbar").setup()
        end
    },

    --
    {
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
    },

    { "numToStr/Comment.nvim",
        config = function()
            require("user.comment")
        end
    },
    { "tpope/vim-surround" },
    {
        'mrjones2014/legendary.nvim'
        -- sqlite is only needed if you want to frecency sorting
        -- dependencies = 'kkharji/sqlite.lua'
    },
    { 'stevearc/dressing.nvim' },
    { "dccsillag/magma-nvim", build = ':UpdateRemotePlugins' },
    -- indent blankline
    { "lukas-reineke/indent-blankline.nvim" },

    -- comment
    'JoosepAlviste/nvim-ts-context-commentstring',
    {
        "ahmedkhalf/project.nvim",
        config = function()
            require("user.project").setup()
        end
    },
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end
    },
    "rafamadriz/friendly-snippets"
}


require("lazy").setup(plugins)
