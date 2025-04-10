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
            -- set winborder=rounded
            local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
            function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
                opts = opts or {}
                opts.border = opts.border or "rounded"
                return orig_util_open_floating_preview(contents, syntax, opts, ...)
            end

            -- local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local capabilities = require('blink.cmp').get_lsp_capabilities() -- only for lsp-config plugin
            local lspconfig = require('lspconfig')
            lspconfig.lua_ls.setup { capabilities = capabilities }
            lspconfig.clangd.setup { capabilities = capabilities }
            lspconfig.pyright.setup { capabilities = capabilities }
            lspconfig.ruff.setup { capabilities = capabilities }
            lspconfig.rust_analyzer.setup { capabilities = capabilities, }
            vim.g.rustfmt_autosave = 1

            vim.diagnostic.config({ virtual_text = { current_line = true } }) -- enable diagnostic text back

            -- Keymappings
            vim.api.nvim_create_autocmd('LspAttach', {
                callback = function(args)
                    local opts = { buffer = args.buf }
                    local map = function(lhs, rhs, desc, mode)
                        mode = mode or 'n'
                        vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", opts, { desc = 'LSP: ' .. desc }))
                    end

                    map("gR", vim.lsp.buf.rename, "Rename symbol")
                    map("<leader>ca", vim.lsp.buf.code_action, "Code action")
                    map("<leader>F", vim.lsp.buf.format, "Format buffer")
                    map("gs", require('telescope.builtin').lsp_document_symbols, 'Telescope symbols')
                    map("<leader>vd", vim.diagnostic.open_float, "View Diagnostics floating")
                    -- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with( vim.lsp.handlers.hover, { focusable = false, })
                    map("<C-k>", vim.lsp.buf.signature_help, "Show signature help", "i")
                    -- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with( vim.lsp.handlers.signature_help, { focusable = false, })
                    map("gK", function()
                        vim.diagnostic.config({
                            virtual_text = {
                                current_line = not vim.diagnostic.config().virtual_text.current_line
                            }
                        })
                    end, "Toggle diagnostic current_line")
                end
            })

            vim.api.nvim_create_autocmd("LspAttach", {
                pattern = { "*.c", "*.cpp", "*.lua" },
                callback = function(args)
                    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = args.buf,
                        callback = function()
                            -- vim.lsp.buf.format { id = args.data.client_id }
                            vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
                        end,
                    })
                end,
                desc = 'Automatically format on save',
            })
        end
    }
}
