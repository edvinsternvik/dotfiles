treesitter_build = function()
    require("nvim-treesitter.install").update({ with_sync = true })()
end

treesitter_config = function(_, opts)
    require("nvim-treesitter.configs").setup {
        -- A list of parser names, or "all" (the five listed parsers should always be installed)
        ensure_installed = { "bash", "c", "cpp", "haskell", "javascript", "lua", "query", "rust", "vimdoc", "yuck" },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        auto_install = false,

        highlight = {
            enable = true,

            additional_vim_regex_highlighting = false,
        },
    }
end

return {
    "nvim-treesitter/nvim-treesitter",
    build = treesitter_build,
    config = treesitter_config,
}
