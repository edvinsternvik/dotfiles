neorg_config = function()
    require("neorg").setup {
        load = {
            ["core.defaults"] = {},
            ["core.concealer"] = {},
            ["core.dirman"] = {
                config = {
                    workspaces = {
                        notes = "~/Documents/notes",
                    },
                    default_workspace = "notes",
                },
            },
            ["core.summary"] = {}
        },
    }

    vim.wo.foldlevel = 99
    vim.wo.conceallevel = 2
end

return {
    "nvim-neorg/neorg",
    tag = "v7.0.0",
    build = ":Neorg sync-parsers",
    ft = "norg",
    cmd = "Neorg",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    config = neorg_config,
    keys = {
        { "<leader>ni", ":Neorg index<cr>" },
        { "<leader>nq", ":Neorg return<cr>" },
    },
}
