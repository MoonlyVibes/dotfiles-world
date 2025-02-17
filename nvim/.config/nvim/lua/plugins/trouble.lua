return {
    "folke/trouble.nvim",
    opts = {
        auto_close = true,              -- Auto-close if trouble is empty
    },
    cmd = "Trouble",
    keys = {
        {
            "<leader>T",
            "<cmd>Trouble<cr>",
            desc = "Toggle Trouble",
        },
        {
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
            "gr",
            "<cmd>Trouble lsp_references toggle focus=true<cr>",
            desc = "LSP References (Trouble)",
        },
        {
            "gs",
            "<cmd>Trouble symbols toggle focus=true<cr>",
            desc = "LSP Symbols (Trouble)",
        },
        {
            "<leader>xl",
            "<cmd>Trouble lsp toggle<cr>",
            desc = "LSP Everything (Trouble)",
        },
        {
            "<leader>xL",
            "<cmd>Trouble lsp toggle win.position=right filter.buf=0<cr>",
            desc = "LSP Buffer Everything (Trouble)",
        },
    },
}
