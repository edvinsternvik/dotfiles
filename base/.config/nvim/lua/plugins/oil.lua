-- local oil_init = function()
     
-- end

-- TODO: enable preview on startup
return {
    'stevearc/oil.nvim',
    lazy = true,
    opts = {
        delete_to_trash = true,
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
        { "<leader>fe", function() require("oil").open() end },
    },
}
