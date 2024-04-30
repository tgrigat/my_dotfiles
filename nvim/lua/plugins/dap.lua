return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    commands = {
      RunScriptWithArgs = {
        desc = "Run Script With Args",
        function(t)
          -- :help nvim_create_user_command
          local status_ok, dap = pcall(require, "dap")
          if not status_ok then return {} end
          local args = vim.split(vim.fn.expand(t.args), "\n")
          local approval = vim.fn.confirm(
            "Will try to run:\n    "
              .. vim.bo.filetype
              .. " "
              .. vim.fn.expand "%"
              .. " "
              .. t.args
              .. "\n\n"
              .. "Do you approve? ",
            "&Yes\n&No",
            1
          )
          if approval == 1 then
            dap.run {
              type = vim.bo.filetype,
              request = "launch",
              name = "Launch file with custom arguments (adhoc)",
              program = "${file}",
              args = args,
            }
          end
        end,
      },
    },
    autocmds = {
      custom_dap = {
        {
          event = "VimEnter",
          desc = "Project-wise DAP",
          callback = function()
            local project_dap_config = require("user.project-dap").search_project_config()
            local status_ok, dap = pcall(require, "dap")
            if not status_ok then
              vim.notify "[nvim-dap-project] Fail to load DAP"
              return
            end

            if project_dap_config == nil then
              vim.notify "[nvim-dap-project] empty project configuration found"
              return
            end

            for key, config in pairs(project_dap_config) do
              if key == "adapters" then
                for language, adapter in pairs(config) do
                  dap.adapters[language] = adapter
                end
              else
                dap.configurations[key] = config
              end
            end
          end,
        },
      },
    },
    mappings = {
      n = {
        ["<Leader>dl"] = {
          desc = "Load nvim-dap.lua",
          function()
            local project_dap_config = require("user.project-dap").search_project_config()
            local status_ok, dap = pcall(require, "dap")
            if not status_ok then
              vim.notify "[nvim-dap-project] Fail to load DAP"
              return
            else
              vim.notify "[nvim-dap-project] DAP loaded"
            end

            if project_dap_config == nil then
              vim.notify "[nvim-dap-project] empty project configuration found"
              return
            end

            for key, config in pairs(project_dap_config) do
              if key == "adapters" then
                for language, adapter in pairs(config) do
                  dap.adapters[language] = adapter
                end
              else
                dap.configurations[key] = config
              end
            end
          end,
        },
      },
    },
  },
}
