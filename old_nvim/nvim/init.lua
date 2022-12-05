if vim.g.vscode then
    -- vscode settings
    require("vscode")
    require("basic")
    require "plugins"
else
    -- ordinary Neovim
    -- below are basic configurations for neovim
    require "basic"
    require "keymaps"
    require "plugins"
    require "colorscheme"
    -- require "plugs"

end
