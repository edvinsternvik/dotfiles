-- Configuration for lspconfig
lspconfig_setup = function(_, opts)
    -- Language servers
    vim.lsp.enable('clangd')
    vim.lsp.enable('rust_analyzer')
    vim.lsp.enable('hls')
    vim.lsp.enable('pylsp')
    vim.lsp.enable('ts_ls')
    vim.lsp.enable('tinymist')
    vim.lsp.enable('zls')

    -- Map keys after LSP attaches to buffer
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Disable default mappings
        vim.keymap.del('n', 'gra')
        vim.keymap.del('n', 'gri')
        vim.keymap.del('n', 'grn')
        vim.keymap.del('n', 'grr')
        vim.keymap.del('n', 'grt')

        -- Buffer local mappings.
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', 'go', vim.lsp.buf.document_symbol, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '<leader>cf', function()
          vim.lsp.buf.format { async = true }
        end, opts)
      end,
    })
end

cmp_setup = function(_, opts)
    local cmp = require("cmp")

    cmp.setup({
        snippet = {
            expand = function(args)
                vim.snippet.expand(args.body)
            end,
        },
        preselect = cmp.PreselectMode.None,
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        },
        view = {                                                        
            docs = { auto_open = false },
        },                                                               
        mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            ['<C-g>'] = function()
                if cmp.visible_docs() then
                  cmp.close_docs()
                else
                  cmp.open_docs()
                end
              end,
        }),
        sources = cmp.config.sources(
            {
                { name = 'nvim_lsp' },
            },
            {
                { name = 'buffer' },
            }
        )
    })


    vim.keymap.set({ 'i', 's' }, '<Tab>', function()
        if vim.snippet.active({ direction = 1 }) then
            return '<cmd>lua vim.snippet.jump(1)<cr>'
        else
            return '<Tab>'
        end
    end, { expr = true })
end

return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "nvim-cmp",
        },
        lazy = false,
        keys = {
            { "<space>e", vim.diagnostic.open_float },
            { "[d",       vim.diagnostic.goto_prev },
            { "]d",       vim.diagnostic.goto_next },
            { "<space>q", vim.diagnostic.setloclist },
            { "<space>o", "<cmd>ClangdSwitchSourceHeader<cr>" },
        },
        config = lspconfig_setup,
    },
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
        },
        config = cmp_setup,
  },
}
