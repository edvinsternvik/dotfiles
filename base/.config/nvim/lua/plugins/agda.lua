return {
    "isovector/cornelis",
    ft = { "agda" },
    build = "stack build",
    dependencies = {
        "kana/vim-textobj-user",
        "neovimhaskell/nvim-hs.vim",
    },
    init = function()
        vim.cmd [[
            au BufRead,BufNewFile *.agda call AgdaFiletype()
            au QuitPre *.agda :CornelisCloseInfoWindows
            function! AgdaFiletype()
                nnoremap <buffer> <leader>cl :CornelisLoad<CR>:sleep 100ms<CR><Enter>:CornelisQuestionToMeta<CR>
                nnoremap <buffer> <leader>c? :CornelisGoals<CR>
                nnoremap <buffer> <leader>cg :CornelisGive<CR>
                nnoremap <buffer> <leader>cr :CornelisRefine<CR>
                nnoremap <buffer> <leader>cc :CornelisMakeCase<CR>
                nnoremap <buffer> <leader>c, :CornelisTypeContext<CR>
                nnoremap <buffer> <leader>c. :CornelisTypeContextInfer<CR>
                nnoremap <buffer> <leader>cs :CornelisSolve<CR>
                nnoremap <buffer> <leader>ca :CornelisAuto<CR>
                nnoremap <buffer> <leader>cb :CornelisPrevGoal<CR>
                nnoremap <buffer> <leader>cf :CornelisNextGoal<CR>
            endfunction
            let g:cornelis_no_agda_input = 1
        ]]

        vim.g.cornelis_split_location = "bottom"
    end,
}
