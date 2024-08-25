return {
    'stevearc/oil.nvim',
    opts = {},
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- Show files and directories that start with "."
    config = function()
        require('oil').setup {
            default_file_explorer = true,
            view_options = {
                show_hidden = true,
            }
        }
        vim.keymap.set('n', '<leader>pv', "<CMD>Oil<CR>")
    end

}
