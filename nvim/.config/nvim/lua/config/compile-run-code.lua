-- this stuff is barely tested
local function term_exec(args)
    vim.cmd('silent write | 13sp')
    vim.cmd('terminal ' .. args)
end
local function get_file_info()
    return {
        name = vim.fn.expand('%'),
        ext = vim.fn.expand('%:e'),
        out_name = vim.fn.expand('%:p:h') .. '/_' .. vim.fn.expand('%:t:r')
    }
end
-- Compile & Run
vim.keymap.set('n', '<F5>', function()
    local f = get_file_info()
    if
        f.ext == "rs" then
        vim.cmd('silent write | Cargo run')
    elseif
        f.ext == "cpp" then
        term_exec('clang++ -g ' .. f.name .. ' -o ' .. f.out_name .. ' && ' .. f.out_name)
    elseif
        f.ext == "c" then
        term_exec('clang -g ' .. f.name .. ' -o ' .. f.out_name .. ' -lcs50' .. ' && ' .. f.out_name)
    elseif
        f.ext == "py" then
        term_exec('python ' .. f.name)
    else
        print("Unsupported file type!")
    end
end)

-- Compile only
vim.keymap.set('n', '<leader><F5>', function()
    local f = get_file_info()
    if
        f.ext == "cpp" then
        term_exec('clang++ -g ' .. f.name .. ' -o ' .. f.out_name)
    elseif
        f.ext == "c" then
        term_exec('clang -g ' .. f.name .. ' -o ' .. f.out_name .. ' -lcs50')
    else
        print("Unsupported file type!")
    end
end, { desc = 'Compile code' })

-- Run rust file without cargo project
vim.keymap.set('n', '<leader>r', function()
    local f = get_file_info()
    term_exec('rustc ' .. f.name .. ' -o ' .. f.out_name .. ' && ' .. f.out_name .. ' && rm ' .. f.out_name)
end, { desc = "Run random rust file" })
