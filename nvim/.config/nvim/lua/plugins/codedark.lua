return {
    "tomasiser/vim-code-dark",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
        -- load the colorscheme here
        vim.cmd([[let g:codedark_italics=1]])
        vim.cmd([[colorscheme codedark]])
        vim.cmd([[hi CursorLine guibg=#272727]])
        vim.cmd([[highlight NormalFloat guibg=none]])
    end,
}
