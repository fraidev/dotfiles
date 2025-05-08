return {
    "mfussenegger/nvim-dap",
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
        config = function()
            local nnoremap = require("utils").nnoremap
            require("dapui").setup()
            local dap, dapui = require("dap"), require("dapui")

            dap.adapters.lldb = {
                type = "server",
                host = "127.0.0.1",
                port = 13000,
                executable = {
                    -- CHANGE THIS to your path!
                    command = "/Users/frai/bin/codelldb", -- adjust as needed
                    args = {"--port", "13000"}
                }
            }
            dap.adapters.codelldb = {
                type = "server",
                host = "127.0.0.1",
                port = 13000,
                executable = {
                    -- CHANGE THIS to your path!
                    command = "/Users/frai/bin/codelldb", -- adjust as needed
                    args = {"--port", "13000"}
                }
            }

            -- dap.configurations.rust = {
            --     {
            --         name = "Launch",
            --         type = "codelldb",
            --         request = "launch",
            --         program = function()
            --             return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
            --         end,
            --         cwd = "${workspaceFolder}",
            --         stopOnEntry = false
            --     }
            -- }

            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end

            nnoremap("<F5>", "<cmd>lua require'dap'.continue()<cr>")
            nnoremap("<F6>", "<cmd>lua require'dap'.step_over()<cr>")
            nnoremap("<F7>", "<cmd>lua require'dap'.step_into()<cr>")
            nnoremap("<F8>", "<cmd>lua require'dap'.step_out()<cr>")
            nnoremap("<F9>", "<cmd>lua require'dap'.toggle_breakpoint()<cr>")
        end
    }
}
