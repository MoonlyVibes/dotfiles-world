return {
    { 'williamboman/mason.nvim', opts = {}, lazy = false, },
    {
        'williamboman/mason-lspconfig.nvim',
        lazy = false,
        opts = {
            ensure_installed = { "rust_analyzer", "lua_ls", "clangd", "pyright", },
            path = "append"
        }
    },
    {
        'neovim/nvim-lspconfig',

        config = function()
            local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
            function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
                opts = opts or {}
                opts.border = opts.border or "rounded"
                return orig_util_open_floating_preview(contents, syntax, opts, ...)
            end

            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lspconfig = require('lspconfig')
            lspconfig.lua_ls.setup { capabilities = capabilities }
            lspconfig.clangd.setup { capabilities = capabilities }
            lspconfig.pyright.setup { capabilities = capabilities }
            lspconfig.ruff.setup { capabilities = capabilities }
            lspconfig.rust_analyzer.setup { capabilities = capabilities, }
            vim.g.rustfmt_autosave = 1

            vim.api.nvim_create_autocmd("LspAttach", {
                pattern = { "*.c", "*.cpp" },
                callback = function(args)
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = args.buf,
                        callback = function()
                            vim.lsp.buf.format { async = false, id = args.data.client_id }
                        end,
                    })
                end,
                desc = 'Automatically format on save',
            })

            -- Keymappings
            vim.api.nvim_create_autocmd('LspAttach', {
                callback = function(ev)
                    local opts = { buffer = ev.buf }

                    local map = function(lhs, rhs, desc, mode)
                        mode = mode or 'n'
                        vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", opts, { desc = 'LSP: ' .. desc }))
                    end

                    map("gd", vim.lsp.buf.definition, "Go to definition")
                    map("gR", vim.lsp.buf.rename, "Rename symbol")
                    map("<leader>ca", vim.lsp.buf.code_action, "Code action")
                    -- Diagnostics
                    map("<leader>vd", vim.diagnostic.open_float, "View Diagnostics floating")
                    map("[d", vim.diagnostic.goto_prev, "Go to previous diagnostic")
                    map("]d", vim.diagnostic.goto_next, "Go to next diagnostic")

                    -- Hover and Signature Help
                    map("K", vim.lsp.buf.hover, "Show hover")
                    -- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
                    --     vim.lsp.handlers.hover,
                    --     { focusable = false, })
                    map("<C-k>", vim.lsp.buf.signature_help, "Show signature help", "i")
                    -- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
                    --     vim.lsp.handlers.signature_help,
                    --     { focusable = false, })

                    -- Format
                    map('<leader>F', vim.lsp.buf.format, "Format buffer")
                    -- Workspace Management
                    -- map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
                    -- map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols,
                    --     'Telescope Workspace Symbols')
                end
            })
        end
    }
}
