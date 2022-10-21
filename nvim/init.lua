if vim.g.vscode then
    -- vscode settings
    require("vscode")
    require("basic")
else
    -- ordinary Neovim
    -- below are basic configurations for neovim
    require "basic"
    require "keymaps"
    require "plugins"
    require "colorscheme"
    -- require "plugs"

    -- below are configuration files for individual plugins.
    -- require "plugins.lsp_config"
    require "plugins.whichkey"
    require "plugins.alpha"
    require "plugins.autopair"
end
