return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    keys = {
        { "<leader>.", function() Snacks.scratch() end,        desc = "Toggle Scratch Buffer" },
        { "<leader>S", function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
    },
    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },
        input = { enabled = true },
        picker = { enabled = true },
        notifier = { enabled = true },
        scratch = { enabled = true }
    },
}
