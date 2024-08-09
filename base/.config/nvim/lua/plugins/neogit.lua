return {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    dependencies = {
        "plenary.nvim",
        "diffview.nvim",
        "telescope.nvim",
    },
    opts = {
        graph_style = "unicode",
        integrations = {
            telescope = true,
            diffview = true,
        },
    },
    keys = {
        { "<leader>gg", ":Neogit<CR>" },
    },
}
