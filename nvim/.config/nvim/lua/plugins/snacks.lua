return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        input = { enabled = true },
        picker = {
            layout = { preset = "telescope", },
            sources = { files = { hidden = true, follow = true, }, },
            matcher = { frecency = true, },
        },
        styles = { input = { relative = "cursor", } }
    },
    keys = {
        { "<leader>ss",      function() Snacks.picker() end,                                  desc = "Everything" },
        { "<leader><space>", function() Snacks.picker.smart({ cwd = os.getenv("HOME") }) end, desc = "Smart Find Files" },
        { "<leader>f",       function() Snacks.picker.files() end,                            desc = "Find Files" },
        { "<leader>h",       function() Snacks.picker.recent() end,                           desc = "Recent" },
        { "<leader>,",       function() Snacks.picker.buffers() end,                          desc = "Buffers" },
        { "<leader>sh",      function() Snacks.picker.help() end,                             desc = "Help Pages" },
        { "<leader>sg",      function() Snacks.picker.grep() end,                             desc = "Grep" },
        { "<leader>su",      function() Snacks.picker.undo() end,                             desc = "Undo History" },
        { "gs",              function() Snacks.picker.lsp_symbols() end,                      desc = "LSP Symbols" },
    },
}
