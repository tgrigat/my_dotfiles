local M = {}

M.config_paths = { "./.nvim-dap/nvim-dap.lua", "./.nvim-dap.lua", "./.nvim/nvim-dap.lua" }

function M.search_project_config()
  local project_config = ""
  for _, p in ipairs(M.config_paths) do
    local f = io.open(p)
    if f ~= nil then
      f:close()
      project_config = p
      break
    end
  end
  if project_config == "" then return end

  -- Use pcall to safely require the file
  local status, result = pcall(function() return dofile(project_config) end)
  if status then
    return result
  else
    print("Error loading configuration file: " .. project_config)
  end
end

return M
