return {
    'tveskag/nvim-blame-line',
    config = function()
        vim.keymap.set('n', '<leader>bb', "<CMD>ToggleBlameLine<CR>")
    end
}
