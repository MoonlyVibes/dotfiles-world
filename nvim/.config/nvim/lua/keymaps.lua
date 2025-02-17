vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require('config.compile-run-code')
vim.keymap.set('n', '<leader>t', '<cmd>13split | terminal<CR>', {desc = 'Toggle Terminal'})
vim.keymap.set('t', '<C-j>', '<C-\\><C-n>', {desc = 'close terminal'})

vim.keymap.set('n', '-', '<cmd>Explore<CR>', { desc = 'Netrw' })
-- vim.keymap.set('n', '<leader>nt', '<cmd>20Lex<CR>', { desc = 'Netrw'})
-- vim.keymap.set('n', '<leader>nc', '<cmd>20Lex %:p:h<CR>', { desc = 'Netrw current folder'})

vim.keymap.set('n', '<esc>', '<cmd>noh<CR>')

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<A-h>', '5<C-W>>', { desc = 'increase width'})
vim.keymap.set('n', '<A-l>', '5<C-W><', { desc = 'decrease width'})
vim.keymap.set('n', '<A-k>', '5<C-W>+', { desc = 'increase height'})
vim.keymap.set('n', '<A-j>', '5<C-W>-', { desc = 'decrease height'})

vim.opt.langmap = "ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz"
