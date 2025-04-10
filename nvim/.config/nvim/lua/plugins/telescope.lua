return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    event = "VeryLazy",
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    config = function()
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', function()
            builtin.find_files { hidden = true }
        end, { desc = 'Telescope find files' })

        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope grep' })
        vim.keymap.set('n', '<leader>f<leader>', builtin.buffers, { desc = 'Telescope buffers' })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help' })

        -- vim.keymap.set('n', '<leader>fn', function()
        --     builtin.find_files { cwd = vim.fn.stdpath 'config', prompt_title = '~/.config/nvim' }
        -- end, { desc = 'Telescope nvim config' })

        vim.keymap.set('n', '<leader><leader>', builtin.oldfiles, { desc = 'Telescope last files' })
        vim.keymap.set('n', '<leader>fm', builtin.builtin, { desc = 'Telescope modes' })
    end,
}
