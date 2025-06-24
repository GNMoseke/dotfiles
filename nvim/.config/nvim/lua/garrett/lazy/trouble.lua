return {
    "folke/trouble.nvim",
    cmd = "Trouble",
    keys = {
        {
            "<leader>tt",
            "<cmd>Trouble diagnostics toggle<cr>",
            desc = "Diagnostics (Trouble)",
        },
        {
            "<leader>xx",
            "<cmd>Trouble quickfix toggle<cr>",
            desc = "Quickfix (Trouble)",
        }
    },
    opts = {}
}
