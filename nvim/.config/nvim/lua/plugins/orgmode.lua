return {
    'nvim-orgmode/orgmode',
    ft = 'org',
    -- event = 'VeryLazy', -- this loads even for non-org files
    config = function()
        require('orgmode').setup({
            org_agenda_files = '~/orgfiles/**/*',
            -- org_agenda_files = {'~/orgfiles/*'},
            org_default_notes_file = '~/orgfiles/refile.org',
            org_startup_folded = "showeverything", -- "content",
            -- org_todo_keywords = {'TODO', 'NEXT', '|', 'DONE'},
            ui = {
                folds = { colored = false },
            },
        })
        vim.cmd('highlight Folded guifg=#669999 guibg=#262626')
    end,
}
