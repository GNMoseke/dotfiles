return {
    {
        "mistweaverco/kulala.nvim",
        keys = {
            { "<leader>Rs", desc = "Send request" },
            { "<leader>Ra", desc = "Send all requests" },
            { "<leader>Rb", desc = "Open scratchpad" },
        },
        ft = { "http", "rest" },
        opts = {
            global_keymaps = true,
            additional_curl_options = { "--fail-with-body" },
            ui = {
                icons = {
                    inlay = {
                        loading = "",
                        done = "󱋌 ",
                        error = " "
                    },
                    lualine = "󰘦 "
                }
            }
        },
    },
}
