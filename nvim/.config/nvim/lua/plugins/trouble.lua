return {
    "folke/trouble.nvim",
    opts = {
        auto_close = true,       -- auto close when there are no items
        focus = true,            -- Focus the window when opened
        warn_no_results = false, -- show a warning when there are no results

        -- auto_jump = true,      -- auto jump to the item when there's only one
        -- open_no_results = false, -- open the trouble window when there are no results
    },
    cmd = "Trouble",
    keys = {
        {
            "<leader>t",
            "<cmd>Trouble<cr>",
            desc = "Toggle Trouble",
        }, {
            "<leader>xx",
            "<cmd>Trouble diagnostics toggle<cr>",
            desc = "LSP Diagnostics (Trouble)",
        },
        {
            "<leader>xX",
            "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
            desc = "LSP Buffer Diagnostics (Trouble)",
        },
        {
            "gd",
            "<cmd>Trouble lsp_definitions toggle focus=true<cr>",
            desc = "LSP Definitions (Trouble)",
        },
        {
            "gr",
            "<cmd>Trouble lsp_references toggle focus=true<cr>",
            desc = "LSP References (Trouble)",
        },
        {
            "gS",
            "<cmd>Trouble symbols toggle focus=true<cr>",
            desc = "LSP Symbols (Trouble)",
        },
        {
            "gL",
            "<cmd>Trouble lsp toggle<cr>",
            desc = "LSP Everything? (Trouble)",
        },
        {
            "gl",
            "<cmd>Trouble lsp toggle win.position=right filter.buf=0<cr>",
            desc = "LSP Buffer Everything? (Trouble)",
        },
    },
}
