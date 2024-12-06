return {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
        local dap = require "dap"
        local ui = require "dapui"

        require("dapui").setup()
        dap.adapters.lldb = {
            type = 'executable',
            -- TODO: once I can actually use swift 6, this is bundled with 6.x+ toolchains
            command = '/usr/bin/lldb-dap', -- adjust as needed, must be absolute path
            name = 'lldb'
        }

        dap.configurations.swift = {
            {
                name = 'Launch',
                type = 'lldb',
                request = 'launch',
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                 -- FIXME: this is funky
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
                args = {},
            },
        }

        dap.configurations.rust = {
            {
                name = 'Launch',
                type = 'lldb',
                request = 'launch',
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                 -- FIXME: this is funky
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
                args = {},
            },
              initCommands = function()
              -- Find out where to look for the pretty printer Python module
              local rustc_sysroot = vim.fn.trim(vim.fn.system('rustc --print sysroot'))

              local script_import = 'command script import "' .. rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py"'
              local commands_file = rustc_sysroot .. '/lib/rustlib/etc/lldb_commands'

              local commands = {}
              local file = io.open(commands_file, 'r')
              if file then
                for line in file:lines() do
                  table.insert(commands, line)
                end
                file:close()
              end
              table.insert(commands, 1, script_import)

              return commands
            end,
        }
        
        vim.fn.sign_define('DapBreakpoint', {text='', texthl='', linehl='', numhl=''})
        vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
        vim.keymap.set("n", "<leader>gb", dap.run_to_cursor)

        -- Eval var under cursor
        vim.keymap.set("n", "<leader>?", function()
            require("dapui").eval(nil, { enter = true })
        end)

        vim.keymap.set("n", "<leader>dc", dap.continue)
        vim.keymap.set("n", "<leader>dsi", dap.step_into)
        vim.keymap.set("n", "<leader>dso", dap.step_over)
        vim.keymap.set("n", "<leader>dff", dap.step_out)
        vim.keymap.set("n", "<leader>dta", dap.restart)

        dap.listeners.before.attach.dapui_config = function()
            ui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            ui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            ui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            ui.close()
        end
    end
}
