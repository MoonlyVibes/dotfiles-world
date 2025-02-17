if os.getenv("TERM") ~= "linux" then
vim.opt.title = true
end
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

vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    command = "setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
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
