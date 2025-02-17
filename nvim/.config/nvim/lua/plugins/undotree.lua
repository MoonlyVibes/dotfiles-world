vim.g.undotree_SetFocusWhenToggle = 1
return {
    "mbbill/undotree",
    config = function()
        vim.keymap.set('n', '<leader>ut', '<cmd>UndotreeToggle<CR>', { desc = 'Undotree' })
    end,
}
