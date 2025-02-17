return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        {
            'theHamsta/nvim-dap-virtual-text',
            opts = {
                -- commented = true,
                virt_text_pos = 'eol',
            },
        },
    },
    config = function()
        vim.fn.sign_define("DapBreakpoint", { text = "󰯯 ", texthl = "", linehl = "", numhl = "" })
        require("dapui").setup({
            -- default config
            controls = {
                element = "repl",
                enabled = true,
                icons = {
                    disconnect = "",
                    pause = "",
                    play = "",
                    run_last = "",
                    step_back = "",
                    step_into = "",
                    step_out = "",
                    step_over = "",
                    terminate = ""
                }
            },
            element_mappings = {},
            expand_lines = true,
            floating = {
                border = "single",
                mappings = {
                    close = { "q", "<Esc>" }
                }
            },
            force_buffers = true,
            icons = {
                collapsed = "",
                current_frame = "",
                expanded = ""
            },
            layouts = { {
                elements = { {
                    id = "scopes",
                    size = 0.25
                }, {
                    id = "breakpoints",
                    size = 0.25
                }, {
                    id = "stacks",
                    size = 0.25
                }, {
                    id = "watches",
                    size = 0.25
                } },
                position = "left",
                size = 40
            }, {
                -- changed console and repl positions
                elements = { {
                    id = "console",
                    size = 0.5
                }, {
                    id = "repl",
                    size = 0.5
                } },
                position = "bottom",
                size = 10
            } },
            mappings = {
                edit = "e",
                expand = { "<CR>", "<2-LeftMouse>" },
                open = "o",
                remove = "d",
                repl = "r",
                toggle = "t"
            },
            render = {
                indent = 1,
                max_value_lines = 100
            }
        })
        local dap = require("dap")
        dap.adapters.cppdbg = {
            id = 'cppdbg',
            type = 'executable',
            command = vim.fn.expand(
            "$HOME/.local/share/nvim/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7"),
        }
        dap.configurations.cpp = {
            {
                name = "Launch file",
                type = "cppdbg",
                request = "launch",
                program = function()
                    local out_file = vim.fn.expand('%:p:h') .. [[/\%]] .. vim.fn.expand('%:t:r')
                    return out_file
                end,
                cwd = '${workspaceFolder}',
                stopAtEntry = true,
            },
        }
        dap.configurations.c = dap.configurations.cpp

        -- Eval var under cursor
        vim.keymap.set("n", "<space>?", function()
            require("dapui").eval(nil, { enter = true })
        end)

        dap.listeners.before.attach.dapui_config = function()
            require("dapui").open()
        end
        dap.listeners.before.launch.dapui_config = function()
            require("dapui").open()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            require("dapui").close()
        end
        dap.listeners.before.terminate.dapui_config = function()
            require("dapui").close()
        end
        dap.listeners.before.disconnect.dapui_config = function()
            require("dapui").close()
        end

        -- Breakpoint Management
        vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
        vim.keymap.set("n", "<leader>dB", dap.clear_breakpoints, { desc = "Clear Breakpoints" })
        vim.keymap.set("n", "<space>b", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })

        -- Execution Control
        vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Run/Continue" })
        vim.keymap.set("n", "<leader>dd", dap.continue, { desc = "Run/Continue" })
        vim.keymap.set("n", "<leader>dr", dap.restart, { desc = "Restart" })
        vim.keymap.set("n", "<F1>", dap.continue, { desc = "Run/Continue" })
        -- vim.keymap.set("n", "<leader>dp", dap.pause, { desc = "Pause Execution" })
        vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
        vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step Over" })
        vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "Step Out" })
        -- vim.keymap.set("n", "<leader>dC", dap.run_to_cursor, { desc = "Run to Cursor" })

        vim.keymap.set("n", "<leader>dt", function()
            dap.terminate()
            vim.cmd("DapVirtualTextForceRefresh")
        end, { desc = "Terminate" })

        -- UI and Widgets
        vim.keymap.set("n", "<leader>dU", function() require("dapui").toggle({ reset = true }) end,
            { desc = "Toggle Dap UI" })
    end,
}
