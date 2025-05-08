return {
    'saghen/blink.cmp',
    event = "InsertEnter",
    dependencies = { 'rafamadriz/friendly-snippets' },
    version = '1.*', -- use a release tag to download pre-built binaries

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        -- disable for $(:set filetype?)
        enabled = function() return not vim.tbl_contains({ "markdown", "org" }, vim.bo.filetype) end,
        keymap = {
            preset = 'default',
            ['<C-p>'] = { 'select_prev', 'snippet_backward', 'fallback_to_mappings' },
            ['<C-n>'] = { 'select_next', 'snippet_forward', 'fallback_to_mappings' },
            ['<CR>'] = { 'accept', 'fallback' },
            ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
            ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
        },
        appearance = {
            nerd_font_variant = 'mono' -- Adjusts spacing to ensure icons are aligned
        },
        completion = {
            menu = {
                border = 'rounded',
            },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 100, -- def 500
                window = { border = 'rounded' }
            },
            keyword = {
                range = 'full'
            },
        },
        signature = {
            window = {
                -- show_documentation = false,
                border = 'rounded'
            },
            enabled = true
        },
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
        },
        fuzzy = { implementation = "prefer_rust_with_warning" },
        cmdline = {
            enabled    = false,
            keymap     = {
                ['<CR>'] = { 'accept_and_enter', 'fallback' },
                -- ['<CR>'] = { 'accept', 'fallback' },
            },
            completion = {
                menu = { auto_show = true },
            }
        },
    },
    opts_extend = { "sources.default" }, -- default
}
