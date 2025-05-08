return {
    'nvim-orgmode/orgmode',
    ft = 'org',
    dependencies = {
        "dhruvasagar/vim-table-mode",
    },
    -- event = 'VeryLazy', -- this loads even for non-org files
    config = function()
        require('orgmode').setup({
            org_agenda_files = '~/orgfiles/**/*',
            -- org_agenda_files = {'~/orgfiles/*'},
            org_default_notes_file = '~/orgfiles/refile.org',
            org_startup_folded = "showeverything", -- or "content",
            -- org_todo_keywords = {'TODO', 'NEXT', '|', 'DONE'},
            ui = {
                folds = { colored = false },
            },
        })
        vim.cmd('silent TableModeEnable')
    end,
}
