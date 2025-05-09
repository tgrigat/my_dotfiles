local dap_config_template = [[
return {
	adapters = {
		-- python_just = {
		-- 	type = "server", -- We will connect to a server (debugpy)
		-- 	host = "127.0.0.1", -- The host where debugpy will be listening
		-- 	port = 5678,     -- The port debugpy will be listening on (must match your justfile)
		--
		-- 	-- This 'executable' block tells nvim-dap how to start the server process
		-- 	-- In this case, the "server process" is initiated by 'just start-debug'
		-- 	executable = {
		-- 		command = "just",     -- The command to run
		-- 		args = { "start-debug" }, -- Arguments for the command
		-- 		env = {
		-- 			PYDEVD_DISABLE_FILE_VALIDATION = 1,
		-- 		},
		-- 		-- detached = true,               -- Optional: nvim-dap usually manages this well for server types
		-- 		-- cwd = '${workspaceFolder}',    -- Optional: if 'just' needs to be run from a specific CWD
		-- 	},
		-- },
	},
	configurations = {
		-- python = {
		-- 	{
		-- 		name = "Attach to Just",
		-- 		type = "python_just",
		-- 		request = "attach",
		-- 	},
		-- },
	},
}
]]

return {
  {
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
        CreateDapConfig = {
          desc = "Create a basic .nvim-dap.lua file",
          function()
            local file_path = ".nvim-dap.lua"
            local file = io.open(file_path, "w")
            if file then
              file:write(dap_config_template)
              file:close()
              vim.notify("Created .nvim-dap.lua file", vim.log.levels.INFO)
            else
              vim.notify("Failed to create .nvim-dap.lua file", vim.log.levels.ERROR)
            end
          end,
        },
      },
      autocmds = {
        custom_dap = {
          {
            event = "VimEnter",
            desc = "Project-wise DAP",
            callback = function() require("user.project-dap").load_and_apply_config() end,
          },
        },
      },
      mappings = {
        n = {
          ["<Leader>dl"] = {
            desc = "Load nvim-dap.lua",
            function() require("user.project-dap").load_and_apply_config() end,
          },
          ["<Leader>dd"] = {
            desc = "Debugmaster Mode Toggle",
            function()
              require("debugmaster").mode.toggle()
              local current_status_message
              if require("debugmaster.debug.mode").is_active() then -- Check the new state
                current_status_message = "Debug Mode: ON"
              else
                current_status_message = "Debug Mode: OFF"
              end
              vim.notify(current_status_message, vim.log.levels.INFO)
            end,
          },
          ["<Leader>ds"] = {
            desc = "Show Dap Log",
            function()
              local log = require "dap.log"
              log.create_logger "dap.log"
              for _, logger in pairs(log._loggers) do
                -- Read log file contents
                local lines = {}
                local file = io.open(logger._path, "r")
                if file then
                  for line in file:lines() do
                    table.insert(lines, line)
                  end
                  file:close()
                end
                -- Create a floating window
                local width = math.min(120, vim.o.columns - 4)
                local height = math.min(30, vim.o.lines - 4)
                local buf = vim.api.nvim_create_buf(false, true)
                -- Set buffer options before setting lines
                vim.bo[buf].buftype = "nofile"
                vim.bo[buf].swapfile = false
                -- Set buffer name with a unique identifier to avoid conflicts
                local log_name = "dap-log-" .. os.time() .. "-" .. logger._fname
                pcall(vim.api.nvim_buf_set_name, buf, log_name)
                -- Set lines and then make non-modifiable
                vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
                vim.bo[buf].modifiable = false
                -- Calculate position
                local col = math.floor((vim.o.columns - width) / 2)
                local row = math.floor((vim.o.lines - height) / 2)
                -- Open the floating window
                local win = vim.api.nvim_open_win(buf, true, {
                  relative = "editor",
                  width = width,
                  height = height,
                  col = col,
                  row = row,
                  border = "rounded",
                  style = "minimal",
                })
                -- Add buffer-local mappings for easier navigation
                vim.api.nvim_buf_set_keymap(buf, "n", "q", ":close<CR>", { noremap = true, silent = true })
              end
            end,
          },
        },
      },
    },
  },
  {
    "rebelot/heirline.nvim",
    opts = function(_, hl_opts)
      local status_util = require "astroui.status.utils"
      local config = assert(require("astroui").config.status)
      local provider = require "astroui.status.provider"
      local component_builder = require("astroui.status.component").builder

      ---@class astroui.status.provider
      provider.debugmode = function(opts)
        local extend_tbl = require("astrocore").extend_tbl
        opts = extend_tbl(vim.tbl_get(config, "providers", "debugmode"), opts)

        return function()
          local text = ""
          if require("debugmaster.debug.mode").is_active() then text = "DEBUG" end

          status_util.stylize(text, opts)
        end
      end

      local component = component_builder(status_util.setup_providers({ debugmode = {} }, { "debugmode" }))

      hl_opts.statusline = require("astrocore").extend_tbl(hl_opts.statusline, { component })
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    config = function(plugin, opts)
      -- run default AstroNvim nvim-dap-ui configuration function
      require "astronvim.plugins.configs.nvim-dap-ui"(plugin, opts)

      -- disable dap events that are created
      local dap = require "dap"
      dap.listeners.after.event_initialized.dapui_config = nil
      dap.listeners.before.event_terminated.dapui_config = nil
      dap.listeners.before.event_exited.dapui_config = nil
    end,
  },
  {
    "miroshQa/debugmaster.nvim",
  },
}
