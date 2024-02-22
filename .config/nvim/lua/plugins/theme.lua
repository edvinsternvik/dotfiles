theme_init = function()
     vim.cmd([[
         " Important!!
         if has('termguicolors')
           set termguicolors
         endif


        let g:sonokai_style = 'default'
        let g:sonokai_better_performance = 1
        let g:sonokai_transparent_background = 1

        colorscheme sonokai
    ]])
end

return {
    "sainnhe/sonokai",
    init = theme_init,
}
