vim.api.nvim_create_user_command(
  'LoadDAP',
  function()
    local dap = require('dap')
    require('dapui').setup()

    local m = {
      ["<leader>dc"] = { "<cmd> lua require('dap').continue()<CR>", "DAP Continue" },
      ["<leader>dx"] = { "<cmd> lua require('dap').terminate()<CR>", "DAP Terminate" },
      ["<leader>dr"] = { "<cmd> lua require('dap').repl.open()<CR>", "DAP REPL" },
      ["<leader>db"] = { "<cmd> lua require('dap').toggle_breakpoint()<CR>", "DAP Toggle Breakpoint" },
      ["<leader>dl"] = { "<cmd> lua require('dap').list_breakpoints()<CR>", "DAP List Break Points" },
      ["<leader>ds"] = { "<cmd> lua require('dap').step_over()<CR>", "DAP Step Over" },
      ["<leader>di"] = { "<cmd> lua require('dap').step_into()<CR>", "DAP Step Into" },
      ["<leader>do"] = { "<cmd> lua require('dap').step_out()<CR>", "DAP Step Out" },
      ["<leader>du"] = { "<cmd> lua require('dapui').toggle()<CR>", "DAP Toggle UI" },
      ["<leader>dp"] = { "<cmd> lua require('dapui').float_element()<CR>", "DAP Float Element" },
    }

    local map = vim.api.nvim_set_keymap
    for k, v in pairs(m) do
      map("n", k, v[1], { desc = v[2], noremap = true, silent = true })
    end

    --- Go ---
    dap.adapters.delve = function(callback, config)
        if config.mode == 'remote' and config.request == 'attach' then
            callback({
                type = 'server',
                host = config.host or '127.0.0.1',
                port = config.port or '38697'
            })
        else
            callback({
                type = 'server',
                port = '${port}',
                executable = {
                    command = 'dlv',
                    args = { 'dap', '-l', '127.0.0.1:${port}', '--log', '--log-output=dap' },
                    detached = vim.fn.has("win32") == 0,
                }
            })
        end
    end
    dap.configurations.go = {
      {
        type = "delve",
        name = "Debug",
        request = "launch",
        program = "${file}"
      },
      {
        type = "delve",
        name = "Debug test", -- configuration for debugging test files
        request = "launch",
        mode = "test",
        program = "${file}"
      },
      -- works with go.mod packages and sub packages 
      {
        type = "delve",
        name = "Debug test (go.mod)",
        request = "launch",
        mode = "test",
        program = "./${relativeFileDirname}"
      }
    }

    --- C/C++/Rust
    dap.adapters.gdb = {
      type = "executable",
      command = "gdb",
      args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
    }
    dap.configurations.c = {
      {
        name = "Launch",
        type = "gdb",
        request = "launch",
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        args = {}, -- provide arguments if needed
        cwd = "${workspaceFolder}",
        stopAtBeginningOfMainSubprogram = false,
      },
      {
        name = "Select and attach to process",
        type = "gdb",
        request = "attach",
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        pid = function()
          local name = vim.fn.input('Executable name (filter): ')
          return require("dap.utils").pick_process({ filter = name })
        end,
        cwd = '${workspaceFolder}'
      },
      {
        name = 'Attach to gdbserver :1234',
        type = 'gdb',
        request = 'attach',
        target = 'localhost:1234',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}'
      }
    }
  end,
  {}
)
