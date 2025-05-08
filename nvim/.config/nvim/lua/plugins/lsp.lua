return {
    { 'williamboman/mason.nvim', event = "VeryLazy", opts = {}, },
    -- { 'williamboman/mason-lspconfig.nvim', event = "VeryLazy", opts = {} },
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

            vim.lsp.enable('lua_ls')
            vim.lsp.enable('clangd')
            vim.lsp.enable('pyright')
            vim.lsp.enable('ruff')
            vim.lsp.enable('bashls')
            vim.lsp.enable('rust_analyzer')
            vim.lsp.enable('hls')
            vim.lsp.config('hls', { settings = { haskell = { formattingProvider = "fourmolu" } } })
            vim.g.rustfmt_autosave = 1

            -- vim.diagnostic.config({ virtual_text = { current_line = true } }) -- enable diagnostic text back
            vim.diagnostic.config({ virtual_text = { true, current_line = false } }) -- enable diagnostic text back

            -- Keymappings
            vim.api.nvim_create_autocmd('LspAttach', {
                callback = function(args)
                    local map = function(lhs, rhs, desc, mode)
                        mode = mode or 'n'
                        vim.keymap.set(mode, lhs, rhs, { buffer = args.buf, desc = 'LSP: ' .. desc })
                    end
                    map("gR", vim.lsp.buf.rename, "Rename symbol")
                    map("<leader>ca", vim.lsp.buf.code_action, "Code action")
                    map("<leader>F", vim.lsp.buf.format, "Format buffer")
                    map("<C-k>", vim.lsp.buf.signature_help, "Show signature help", "i")
                    map("<leader>vd", vim.diagnostic.open_float, "View Diagnostics floating")
                    map("<leader>vv", function()
                        vim.diagnostic.config({
                            virtual_text = {
                                current_line = not vim.diagnostic.config().virtual_text.current_line
                            }
                        })
                    end, "Toggle diagnostic current_line")
                end
            })

            vim.api.nvim_create_autocmd("LspAttach", {
                pattern = { "*.c", "*.cpp", "*.lua", "*.hs" },
                callback = function(args)
                    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = args.buf,
                        callback = function()
                            vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
                        end,
                    })
                end,
                desc = 'Automatically format on save',
            })
        end
    }
}
