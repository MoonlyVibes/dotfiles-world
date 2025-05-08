return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        opts = {
            default = true,
        }
    },
    opts = {
        spec = {
            { '<leader>d', group = 'Dap' },
        },
        win = { border = 'rounded' },
        -- disable for c, d, y
        ---@param ctx { mode: string, operator: string }
        defer = function(ctx)
            if vim.list_contains({ "d", "c", "y" }, ctx.operator) then
                return true
            end
            return vim.list_contains({ "<C-V>", "V" }, ctx.mode)
        end,
    },
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps (which-key)",
        },
    },
}
