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
            command = '/opt/homebrew/opt/llvm/bin/lldb-dap', -- adjust as needed, must be absolute path
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
