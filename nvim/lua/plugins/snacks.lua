-- lazy.nvim
return {
  "folke/snacks.nvim",
  opts = {
    image = {
      -- your image configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    scroll = {
      enabled = function()
        local uis = vim.api.nvim_list_uis()
        -- If no UIs are attached (headless), disable scrolling as per the new requirement.
        if #uis == 0 then return false end

        for _, ui in ipairs(uis) do
          -- Wrap in pcall in case ui.chan is invalid or get_chan_info fails
          local success, chan_info = pcall(vim.api.nvim_get_chan_info, ui.chan)
          if
            success
            and chan_info
            and chan_info.client
            and chan_info.client.name
            and chan_info.client.name == "neovide"
          then
            -- Neovide is detected, disable scrolling
            return false
          end
        end

        -- If Neovide is not found among the UIs and not headless, enable scrolling
        return true
      end,
    },
    indent = { animate = { enabled = true } },
    dim = { animate = { enabled = true } },
  },
}
