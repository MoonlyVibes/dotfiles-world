vim.opt.title = true
vim.opt.guicursor = ""
vim.opt.cursorline = true
vim.opt.ignorecase = true; vim.opt.smartcase = true
vim.opt.number = true; vim.opt.relativenumber = true; vim.opt.numberwidth = 2

vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true

vim.opt.scrolloff = 4
vim.opt.splitbelow = true; vim.opt.splitright = true
vim.opt.undofile = true
vim.opt.updatetime = 250

vim.g.netrw_banner = 0
vim.g.netrw_bufsettings = "noma nomod nonu nowrap ro nobl rnu" -- defaults + rnu

-- vim.opt.viewoptions = "folds" -- don't capture anything besides folds (default "folds,cursor,curdir")
local fold = { "*.rs", "*.cpp", "*.c", "*.py" }
vim.api.nvim_create_autocmd("BufWinLeave", {
    pattern = fold,
    command = "mkview",
})
vim.api.nvim_create_autocmd("BufWinEnter", {
    pattern = fold,
    command = "silent! loadview",
})

vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "*",
    command = "startinsert",
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    command = "setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
    desc = "fix o"
})

vim.api.nvim_create_autocmd('TextYankPost', {
    group = vim.api.nvim_create_augroup('HighlightYank', {}),
    callback = function()
        vim.highlight.on_yank({
            timeout = 60,
        })
    end,
})

vim.g.clipboard = {
    name = "xclip",
    copy = {
        ["+"] = "xclip -selection clipboard",
        ["*"] = "xclip -selection clipboard",
    },
    paste = {
        ["+"] = "xclip -selection clipboard -o",
        ["*"] = "xclip -selection clipboard -o",
    },
    cache_enabled = 1,
}
