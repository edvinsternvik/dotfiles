theme_init = function()
    require("nightfox").setup({
        options = {
            transparent = true,
        }
    })
    vim.cmd.colorscheme "nightfox"
    -- vim.cmd.colorscheme "dayfox"
end

return {
    "EdenEast/nightfox.nvim",
    init = theme_init,
    priority = 1000
}
