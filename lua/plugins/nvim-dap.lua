return {
    "mfussenegger/nvim-dap",
    event = "BufRead",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
        "nvim-telescope/telescope-dap.nvim",
        "folke/neodev.nvim",
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")
        local virtual_text = require("nvim-dap-virtual-text")
        local dap_go = require("dap-go")

        dap.adapters.lldb = {
            type = 'executable',
            -- command = '/opt/homebrew/opt/llvm/bin/lldb-vscode', -- adjust as needed, must be absolute path
            command = '/usr/bin/lldb-dap', -- adjust as needed, must be absolute path
            name = 'lldb'
        }

        local lldb = {
            name = "Launch lldb",
            type = "lldb",      -- matches the adapter
            request = "launch", -- could also attach to a currently running process
            program = function()
                return vim.fn.input(
                    "Path to executable: ",
                    vim.fn.getcwd() .. "/",
                    "file"
                )
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
            args = {},
            runInTerminal = false,
        }

        dap.configurations.rust = {
            lldb
        }

        -- dap.configurations.zig = {
        --     {
        --         name = "Launch",
        --         type = "lldb",
        --         request = "launch",
        --         program = function()
        --             return vim.fn.input(
        --                 "Path to executable: ",
        --                 vim.fn.getcwd() .. "/",
        --                 "file"
        --             )
        --         end,
        --         cwd = "${workspaceFolder}",
        --         stopOnEntry = false,
        --         args = {},
        --         -- runInTerminal = false,
        --     },
        -- }

        dap.configurations.c = {
            {
                name = 'Launch',
                type = 'lldb',
                request = 'launch',
                program = function()
                    return vim.fn.input(
                        'Path to executable: ',
                        vim.fn.getcwd() .. '/',
                        'file'
                    )
                end,
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
                args = {},
                runInTerminal = false,
            },
            {
                name = 'Attach to process',
                type = 'lldb',
                request = 'attach',
                pid = require('dap.utils').pick_process,
                args = {},
            },
        }

        dap.configurations.zig = dap.configurations.c

        dapui.setup()
        virtual_text.setup()
        dap_go.setup()
    end
}
