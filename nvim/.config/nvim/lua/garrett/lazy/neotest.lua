return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter"
    },
    config = function()
        local neotest = require("neotest")
        neotest.setup({
            adapters = {
                require('rustaceanvim.neotest')
            },
        })
        vim.keymap.set("n", "<leader>tr", function() neotest.run.run() end)
        vim.keymap.set("n", "<leader>tR", function() neotest.run.run(vim.fn.expand("%")) end)
        vim.keymap.set("n", "<leader>to", function() neotest.output_panel.toggle() end)
        --vim.keymap.set("n", "<leader>dt", function() neotest.run.run({strategy = "dap"}) end)
    end
}
