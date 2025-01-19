return {
    "lervag/vimtex",
    ft = "tex",
    init = function()
        vim.g.vimtex_quickfix_open_on_warning = 0
        vim.g.vimtex_view_method = 'zathura_simple'
    end
}
