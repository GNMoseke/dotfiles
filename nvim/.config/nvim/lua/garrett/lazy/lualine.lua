return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('lualine').setup {
            options = {
                theme = 'catppuccin'
            },
            sections = {
                lualine_a = {
                    { 'mode', fmt = function(str)
                        local mode = str:lower()
                        if mode == "normal" then
                            return " " .. str
                        elseif mode == "insert" then
                            return " " .. str
                        elseif mode == "visual" or mode == "v-line" or mode == "v-block" then
                            return " " .. str
                        else
                            return str
                        end
                    end }
                },
                lualine_c = {
                    { 'filename', path = 3 }
                }
            }
        }
    end
}
