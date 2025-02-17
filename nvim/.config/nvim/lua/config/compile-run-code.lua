-- Compile & Run
vim.keymap.set('n', '<F5>', function()
    local file = vim.fn.expand('%:p')
    local file_extension = vim.fn.expand("%:e")

    if file_extension == "rs" then
        vim.cmd('silent write | Cargo run')

    elseif file_extension == "cpp" then
        vim.cmd('silent write | 13sp')
        local out_file =vim.fn.expand('%:p:h') .. [[/\%]] .. vim.fn.expand('%:t:r')
        vim.cmd('terminal clang++ -g ' .. file .. ' -o ' .. out_file .. ' && ' .. out_file)

    elseif file_extension == "c" then
        vim.cmd('silent write | 13sp')
        local out_file =vim.fn.expand('%:p:h') .. [[/\%]] .. vim.fn.expand('%:t:r')
        vim.cmd('terminal clang -g ' .. file .. ' -o ' .. out_file .. ' -lcs50' .. ' && ' .. out_file)

    elseif file_extension == "py" then
        vim.cmd('silent write | 13sp')
        vim.cmd('terminal python ' .. file)

    else
        print("Unsupported file type!")
    end
end)
-- Compile only
vim.keymap.set('n','<leader><F5>', function()
    local file = vim.fn.expand('%:p')
    local file_extension = vim.fn.expand("%:e")

    if file_extension == "cpp" then
        vim.cmd('silent write | 13sp')
        local out_file =vim.fn.expand('%:p:h') .. [[/\%]] .. vim.fn.expand('%:t:r')
        vim.cmd('terminal clang++ -g ' .. file .. ' -o ' .. out_file)

    elseif file_extension == "c" then
        vim.cmd('silent write | 13sp')
        local out_file =vim.fn.expand('%:p:h') .. [[/\%]] .. vim.fn.expand('%:t:r')
        vim.cmd('terminal clang -g ' .. file .. ' -o ' .. out_file .. ' -lcs50')

    else
        print("Unsupported file type!")
    end
end, {desc = 'Compile code'})
