-- set winborder=rounded
require("options")
require("keymaps")
require("config.lazy")
-- if os.getenv("TERM") ~= "linux" then
if os.getenv("DISPLAY") ~= nil then
    -- vim.opt.title = true
else
    vim.opt.termguicolors = false
    vim.cmd.colorscheme('default')
end
