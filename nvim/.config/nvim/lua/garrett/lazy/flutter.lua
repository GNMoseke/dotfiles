return {
    'akinsho/flutter-tools.nvim',
    lazy = false,
    dependencies = {
        'nvim-lua/plenary.nvim',
        'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    config = function()
        require('flutter-tools').setup({
            widget_guides = { enabled = true },
        })
        local telescope = require('telescope')

        telescope.load_extension('flutter')
        vim.keymap.set('n', '<leader>ao', telescope.extensions.flutter.commands, {})
        vim.keymap.set('n', '<leader>oo', require('flutter-tools.outline').toggle, {})
    end
}
