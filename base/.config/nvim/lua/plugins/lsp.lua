function open_or_set_split()
    local wins = vim.api.nvim_tabpage_list_wins(0)
    local current_cursor_pos = vim.api.nvim_win_get_cursor(0)

    local current_buf = vim.api.nvim_get_current_buf()
    local current_win = vim.api.nvim_get_current_win()

    local target_win

    if #wins >= 2 then
        for _, win_num in pairs(wins) do
            if win_num ~= current_win then
                target_win = win_num
                break
            end
        end
    else
        vim.cmd("vsplit")
        target_win = vim.api.nvim_get_current_win()
    end

    vim.api.nvim_win_set_buf(target_win, current_buf)
    vim.api.nvim_win_set_cursor(target_win, current_cursor_pos)
    vim.api.nvim_set_current_win(target_win)
end

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
    vim.lsp.enable('ols')

    -- Map keys after LSP attaches to buffer
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(ev)

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
        vim.keymap.set({ 'n', 'v' }, '<leader>s', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<leader>cf', function()
          vim.lsp.buf.format { async = true }
        end, opts)

        vim.keymap.set('n', 'gsd', function()
            open_or_set_split()
            vim.lsp.buf.definition()
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
            ['<C-j>'] = cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Select}),
            ['<C-k>'] = cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Select}),
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
