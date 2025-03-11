return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        "debugloop/telescope-undo.nvim",
    },
    config = function()
        require('telescope').setup({
            extensions = {
                undo = {
                    use_delta = true,
                    side_by_side = true,
                    layout_strategy = "vertical",
                    layout_config = {
                        preview_height = 0.8,
                    },
                },
            }
        })

        local builtin = require('telescope.builtin')
        require("telescope").load_extension("undo")

        vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
        vim.keymap.set('n', '<leader>fh', "<cmd>Telescope find_files hidden=true<cr>", {})
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
        vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
        vim.keymap.set('n', '<leader>fr', builtin.registers, {})
        vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, {})
        vim.keymap.set('n', '<Leader>u', require('telescope').extensions.undo.undo, {})
    end
}
