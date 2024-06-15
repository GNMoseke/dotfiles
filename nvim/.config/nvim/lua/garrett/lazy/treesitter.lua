return {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    config = function()
        require('nvim-treesitter.configs').setup({
            ensure_installed = { "c", "lua", "rust", "fish", "bash", "swift" },
            sync_install = false,
            auto_install = true,
            ignore_install = { "javascript", "typescript" },
            indent = { enable = true},
            highlight = { 
                enable = true,
                additional_vim_regex_highlighting = { 'markdown' }
            }
        })
    end
}
