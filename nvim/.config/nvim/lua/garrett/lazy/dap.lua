return {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
        local dap = require "dap"
        local ui = require "dapui"
        require("dapui").setup()

        -- NOTE: This is really only necessary becuase on macOS it's installed
        -- in either homebrew's path or with a swift toolchain.
        local lldb_dap_path = vim.fn.trim(vim.fn.system 'which lldb-dap')
        dap.adapters.lldb = {
            type = 'executable',
            command = lldb_dap_path,
            name = 'lldb'
        }

        dap.configurations.swift = {
            {
                name = 'Launch',
                type = 'lldb',
                request = 'launch',
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/.build/debug/', 'file')
                end,
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
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
                end,
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
                args = {},
                initCommands = function()
                    -- Find out where to look for the pretty printer Python module.
                    local rustc_sysroot = vim.fn.trim(vim.fn.system 'rustc --print sysroot')
                    assert(
                        vim.v.shell_error == 0,
                        'failed to get rust sysroot using `rustc --print sysroot`: '
                        .. rustc_sysroot
                    )
                    local script_file = rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py'
                    local commands_file = rustc_sysroot .. '/lib/rustlib/etc/lldb_commands'

                    -- The following is a table/list of lldb commands, which have a syntax
                    -- similar to shell commands.
                    --
                    -- To see which command options are supported, you can run these commands
                    -- in a shell:
                    --
                    --   * lldb --batch -o 'help command script import'
                    --   * lldb --batch -o 'help command source'
                    --
                    -- Commands prefixed with `?` are quiet on success (nothing is written to
                    -- debugger console if the command succeeds).
                    --
                    -- Prefixing a command with `!` enables error checking (if a command
                    -- prefixed with `!` fails, subsequent commands will not be run).
                    --
                    -- NOTE: it is possible to put these commands inside the ~/.lldbinit
                    -- config file instead, which would enable rust types globally for ALL
                    -- lldb sessions (i.e. including those run outside of nvim). However,
                    -- that may lead to conflicts when debugging other languages, as the type
                    -- formatters are merely regex-matched against type names. Also note that
                    -- .lldbinit doesn't support the `!` and `?` prefix shorthands.
                    return {
                        ([[!command script import '%s']]):format(script_file),
                        ([[command source '%s']]):format(commands_file),
                    }
                end,
            }
        }

        vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#993939', bg = '#31353f' })
        vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#61afef', bg = '#31353f' })
        vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#d49b2b', bg = '#31353f' })
        vim.fn.sign_define('DapBreakpoint',
            { text = '', texthl = 'DapBreakpoint', linehl = '', numhl = 'DapBreakpoint' })
        vim.fn.sign_define('DapBreakpointCondition',
            { text = 'ﳁ', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
        vim.fn.sign_define('DapBreakpointRejected',
            { text = '', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
        vim.fn.sign_define('DapLogPoint', {
            text = '',
            texthl = 'DapLogPoint',
            linehl = 'DapLogPoint',
            numhl =
            'DapLogPoint'
        })
        vim.fn.sign_define('DapStopped',
            { text = '󰄾', texthl = 'DapStopped', linehl = 'DapStopped', numhl = 'DapStopped' })

        vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
        vim.keymap.set("n", "<leader>gb", dap.run_to_cursor)
        vim.keymap.set("n", "<leader>dt", ui.toggle)

        -- Eval var under cursor
        vim.keymap.set("n", "<leader>?", function()
            require("dapui").eval(nil, { enter = true })
        end)

        vim.keymap.set("n", "<leader>dc", dap.continue)
        vim.keymap.set("n", "<leader>dsi", dap.step_into)
        vim.keymap.set("n", "<leader>dso", dap.step_over)
        vim.keymap.set("n", "<leader>dff", dap.step_out)
        vim.keymap.set("n", "<leader>dq", dap.terminate)
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
