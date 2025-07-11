return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local function optional_jj()
            local filepath = vim.fn.expand('%:p:h')
            local jjdir = vim.fn.finddir('.jj', filepath .. ';')
            if jjdir and #jjdir > 0 and #jjdir < #filepath then
                local handle = io.popen("jj log --revisions @ --no-graph --ignore-working-copy --color never --limit 1 --template powerline_summary")
                local result = handle:read("*a")
                handle:close()
                return result
            else
                return ""
            end
        end
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
                            return " " .. str
                        elseif mode == "visual" or mode == "v-line" or mode == "v-block" then
                            return " " .. str
                        else
                            return str
                        end
                    end }
                },
                lualine_b = { 'branch', 'diff', 'diagnostics', optional_jj },
                lualine_c = {
                    { 'filename', path = 3 }
                }
            }
        }
    end
}
