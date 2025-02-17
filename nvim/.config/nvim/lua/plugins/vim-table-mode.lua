return {
    "dhruvasagar/vim-table-mode",
    ft = "org",
    config = function()
        vim.cmd('silent TableModeEnable')
    end,
}
