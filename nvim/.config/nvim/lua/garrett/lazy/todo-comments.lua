return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        exclude = { "md" },
    },
    config = function()
        require('todo-comments').setup({
            keywords = {
                MARK = { icon = " ", color = "hint", alt = { "MARK" } },
            },
            merge_keywords = true
        })

        vim.keymap.set('n', '<leader>TT', "<CMD>Trouble todo toggle<CR>")
        vim.keymap.set('n', '<leader>ft', "<CMD>TodoTelescope<CR>")
    end
}
