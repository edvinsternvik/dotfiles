-- Configuration for lspconfig
lspconfig_setup = function(_, opts)
    local lspconfig = require('lspconfig')

    -- Language servers
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    lspconfig.clangd.setup        { capabilities = capabilities }
    lspconfig.texlab.setup        { capabilities = capabilities }
    lspconfig.rust_analyzer.setup { capabilities = capabilities }
    lspconfig.hls.setup           { capabilities = capabilities }
    lspconfig.pyright.setup       { capabilities = capabilities }
    lspconfig.tsserver.setup      { capabilities = capabilities }

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
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
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
        preselect = cmp.PreselectMode.None,
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-p>'] = cmp.mapping.select_prev_item({cmp.SelectBehavior.Select}),
            ['<C-n>'] = cmp.mapping.select_next_item({cmp.SelectBehavior.Select}),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
        }, {
            { name = 'buffer' },
        })
    })
end

return {
    {
        "neovim/nvim-lspconfig",
        event = "InsertEnter",
        dependencies = {
            "nvim-cmp",
        },
        keys = {
            { "<space>e", vim.diagnostic.open_float },
            { "[d",       vim.diagnostic.goto_prev },
            { "]d",       vim.diagnostic.goto_next },
            { "<space>q", vim.diagnostic.setloclist },
            { "<A-o>", "<cmd>ClangdSwitchSourceHeader<cr>" },
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
