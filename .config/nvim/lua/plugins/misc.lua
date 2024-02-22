return {
    {
        "tpope/vim-commentary",
        keys = {
            { "<leader>k", "gcc", remap = true },
            { "<leader>k", "gcgv", mode = "v", remap = true },
        },
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
    },
}
