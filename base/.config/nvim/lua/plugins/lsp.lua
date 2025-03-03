-- Configuration for lspconfig
lspconfig_setup = function(_, opts)
    local lspconfig = require('lspconfig')

    -- Language servers
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    lspconfig.clangd.setup        {
        capabilities = capabilities,
        settings = {
            single_file_support = true
        }
    }
    lspconfig.rust_analyzer.setup { capabilities = capabilities }
    lspconfig.hls.setup           { capabilities = capabilities }
    lspconfig.pylsp.setup         { capabilities = capabilities }
    lspconfig.ts_ls.setup         { capabilities = capabilities }
    lspconfig.tinymist.setup      { capabilities = capabilities }
    lspconfig.zls.setup           { capabilities = capabilities }

    -- Map keys after LSP attaches to buffer
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
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
                -- require('luasnip').lsp_expand(args.body)
                vim.snippet.expand(args.body)
            end,
        },
        preselect = cmp.PreselectMode.None,
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
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
