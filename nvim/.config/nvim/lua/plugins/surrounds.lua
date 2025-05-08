return {
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true,
        opts = {
            enable_check_bracket_line = false,
            ignored_next_char = "[%w%.]" -- will ignore alphanumeric and `.` symbol
        }
    },
    {
        "kylechui/nvim-surround",
        version = "^3.0.0",
        event = "VeryLazy",
        opts = {},
    },
    {
        "HiPhish/rainbow-delimiters.nvim",
        config = function()
            require('rainbow-delimiters.setup').setup({})
        end,
    }
}
