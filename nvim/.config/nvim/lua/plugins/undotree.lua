vim.g.undotree_SetFocusWhenToggle = 1
return {
    "mbbill/undotree",
    keys = {
        { '<leader>u', '<cmd>UndotreeToggle | set rnu<CR>', desc = 'Undotree' }
    }
    -- config = function()
    --     vim.keymap.set('n', '<leader>ut', '<cmd>UndotreeToggle | set rnu<CR>', { desc = 'Undotree' })
    -- end,
}
