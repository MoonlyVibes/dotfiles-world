return {
    "hrsh7th/nvim-cmp",
    enabled = false,
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-nvim-lua",

        'saadparwaiz1/cmp_luasnip',
        {
            "L3MON4D3/LuaSnip",
            dependencies = { "rafamadriz/friendly-snippets" },
        }
    },
    event = { "InsertEnter" },
    config = function()
        require("luasnip.loaders.from_vscode").lazy_load() -- for rafamadriz/friendly-snippets
        local luasnip = require("luasnip")
        local cmp = require("cmp")
        cmp.setup({
            formatting = { -- Hide some stuff to reduce width
                format = function(entry, vim_item)
                    vim_item.menu = nil
                    return vim_item
                end,
            },
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                -- ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                ['<C-d>'] = cmp.mapping.scroll_docs(4),
                ['<C-e>'] = cmp.mapping.abort(),
                -- ['<CR>'] = cmp.mapping(function(fallback)
                --     if cmp.visible() then
                --         if luasnip.expandable() then
                --             luasnip.expand()
                --         else
                --             cmp.confirm({ select = true })
                --         end
                --     else
                --         fallback()
                --     end
                -- end),

                ["<C-n>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.locally_jumpable(1) then
                        luasnip.jump(1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),

                ["<C-p>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),

                --     ["<Tab>"] = cmp.mapping(function(fallback)
                --         if cmp.visible() then
                --             cmp.select_next_item()
                --             elseif luasnip.locally_jumpable(1) then
                --                 luasnip.jump(1)
                --         else
                --             fallback()
                --         end
                --     end, { "i", "s" }),
                --
                --     ["<S-Tab>"] = cmp.mapping(function(fallback)
                --         if cmp.visible() then
                --             cmp.select_prev_item()
                --             elseif luasnip.locally_jumpable(-1) then
                --                 luasnip.jump(-1)
                --         else
                --             fallback()
                --         end
                -- end, { "i", "s" }),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'orgmode' },
                { name = 'nvim_lsp_signature_help' },
                { name = 'nvim_lua' },
                { name = 'buffer' },
            })
        })
    end,
}
