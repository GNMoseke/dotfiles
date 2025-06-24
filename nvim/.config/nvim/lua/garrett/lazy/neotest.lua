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
            quickfix = {
                open = function()
                    require("trouble").open({ mode = "quickfix", focus = false })
                end
            },
        })
        vim.keymap.set("n", "<leader>tr", function() neotest.run.run() end, { desc = "[t]est [r]un (nearest)" })
        vim.keymap.set("n", "<leader>tR", function() neotest.run.run(vim.fn.expand("%")) end,
            { desc = "[t]est [R]un (all in file)" })
        vim.keymap.set("n", "<leader>trl", function() neotest.run.run_last() end, { desc = "[t]est [r]un [l]ast" })
        vim.keymap.set("n", "<leader>tc", function() neotest.run.stop() end, { desc = "[t]est [c]ancel" })
        vim.keymap.set("n", "<leader>ts", function() neotest.summary.toggle() end, { desc = "[t]est [s]ummary" })
        vim.keymap.set("n", "<leader>to", function() neotest.output_panel.toggle() end, { desc = "[t]est [o]utput" })
        --vim.keymap.set("n", "<leader>dt", function() neotest.run.run({strategy = "dap"}) end)
    end
}
