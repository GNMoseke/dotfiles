return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { 'j-hui/fidget.nvim', opts = {} },
        },
        config = function()
            vim.lsp.enable('sourcekit')
            vim.lsp.enable('rust_analyzer')
            vim.lsp.enable('dockerls')
            vim.lsp.enable('terraformls')
            vim.lsp.enable('lua_ls')
            vim.lsp.enable('jsonls')
            vim.lsp.enable('fish_lsp')
            vim.lsp.enable('pyright')

            vim.diagnostic.config({
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = "󰅚 ",
                        [vim.diagnostic.severity.WARN] = "󰀪 ",
                        [vim.diagnostic.severity.INFO] = " ",
                        [vim.diagnostic.severity.HINT] = "󰌶 ",
                    },
                    linehl = {
                        [vim.diagnostic.severity.ERROR] = "Error",
                        [vim.diagnostic.severity.WARN] = "Warn",
                        [vim.diagnostic.severity.INFO] = "Info",
                        [vim.diagnostic.severity.HINT] = "Hint",
                    },
                },
                -- virtual_text = true
            })

            vim.api.nvim_create_autocmd("LspProgress", {
                ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
                callback = function(ev)
                    local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
                    vim.notify(vim.lsp.status(), "info", {
                        id = "lsp_progress",
                        title = "LSP Progress",
                        opts = function(notif)
                            notif.icon = ev.data.params.value.kind == "end" and " "
                                or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
                        end,
                    })
                end,
            })

            vim.api.nvim_create_autocmd('LspAttach', {
                desc = "LSP Actions",
                callback = function(args)
                    local map = function(keys, func, desc)
                        vim.keymap.set('n', keys, func, { buffer = args.buf, desc = 'LSP: ' .. desc })
                    end
                    map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
                    map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
                    map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
                    map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
                    map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
                    map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
                    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
                    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
                    map('K', vim.lsp.buf.hover, 'Hover Documentation')
                    map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
                    map('<leader>gne', function ()
                        vim.diagnostic.jump({ count = 1, float = true, severity = vim.diagnostic.severity.ERROR })
                    end, '[G]oto [N]ext [E]rror')
                    map('<leader>gpe', function ()
                        vim.diagnostic.jump({ count = -1, float = true, severity = vim.diagnostic.severity.ERROR })
                    end, '[G]oto [P]revious [E]rror')
                    map('<leader>th', function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
                    end, '[T]oggle Inlay [H]ints')
                end,
            })
        end,
    },
}
