return {
    "Mofiqul/vscode.nvim",
    dependencies = { "tomasiser/vim-code-dark" },
    lazy = false,
    priority = 1000,
    config = function()
        require('vscode').setup({ italic_comments = true, })
        vim.cmd.colorscheme("vscode")
        vim.cmd([[
        highlight Normal guibg=none guifg=#d4d4d4
        highlight NormalFloat guibg=none
        highlight LineNr guibg=none
        highlight CursorLine guibg=#272727
        "highlight! link @markup.raw @property
        highlight! link @markup.raw @function
        highlight! link CursorLineNr Normal

        highlight! link @variable Normal
        highlight! link @variable.parameter Normal
        highlight! link @operator @keyword.import " >= >> + -
]])
        for _, i in ipairs({ "Prompt", "Preview", "Results" }) do
            vim.cmd("highlight! link Telescope" .. i .. "Border Normal")
        end
    end
}
