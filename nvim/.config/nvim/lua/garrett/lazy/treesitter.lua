return {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    config = function()
        require('nvim-treesitter.configs').setup({
            ensure_installed = { "c", "lua", "rust", "fish", "bash", "swift", "markdown", "markdown_inline" },
            sync_install = false,
            auto_install = true,
            indent = { enable = true },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = { 'markdown' }
            }
        })

        local parser_config = require(
            'nvim-treesitter.parsers'
        ).get_parser_configs()

        parser_config.supermd = {
            install_info = {
                url = 'https://github.com/kristoff-it/supermd',
                includes = { 'tree-sitter/supermd/src' },
                files = {
                    'tree-sitter/supermd/src/parser.c',
                    'tree-sitter/supermd/src/scanner.c'
                },
                branch = 'main',
                generate_requires_npm = false,
                requires_generate_from_grammar = false,
            },
            filetype = 'supermd',
        }

        vim.filetype.add {
            extension = {
                smd = 'supermd',
                --shtml = 'superhtml',
                --ziggy = 'ziggy',
                --['ziggy-schema'] = 'ziggy_schema',
            },
        }
    end
}
