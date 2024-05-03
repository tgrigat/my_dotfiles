return {
  {
    "ojroques/nvim-osc52",
    config = function()
      local function copy(lines, _) require("osc52").copy(table.concat(lines, "\n")) end

      local function paste() return { vim.fn.split(vim.fn.getreg "", "\n"), vim.fn.getregtype "" } end

      vim.g.clipboard = {
        name = "osc52",
        copy = { ["+"] = copy, ["*"] = copy },
        paste = { ["+"] = paste, ["*"] = paste },
      }
    end,
    cond = function()
      -- disable when running in konsole since no support for OSC52
      if
        vim.fn.getenv "KONSOLE_DBUS_SERVICE" ~= vim.NIL
        or vim.fn.getenv "KONSOLE_DBUS_SESSION" ~= vim.NIL
        or vim.fn.getenv "KONSOLE_VERSION" ~= vim.NIL
      then
        return false
      end

      return true
    end,
  },
}
