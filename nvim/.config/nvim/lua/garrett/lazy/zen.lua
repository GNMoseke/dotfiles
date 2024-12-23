return {
    'folke/zen-mode.nvim',
    config = function()
        vim.keymap.set('n', '<leader>z', function()
            require("zen-mode").toggle({
                window = { width = 140 }
            })
        end)
    end
}
