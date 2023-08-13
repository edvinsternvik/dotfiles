local dap = require('dap')
local dapui = require('dapui')
dapui.setup {}

-- Open dapui when starting dap, and close dapui when closing dap
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

-- Set dap keymaps

-- Start / continue / stop debugging
vim.keymap.set('n', '<leader>dc', function() require('dap').continue() end)
vim.keymap.set('n', '<leader>de', function() require('dap').terminate() end)

-- Breakpoints
vim.keymap.set('n', '<leader>db', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<leader>dB', function() require('dap').clear_breakpoints() end)

-- Stepping
vim.keymap.set('n', '<leader>dN', function() require('dap').step_into() end)
vim.keymap.set('n', '<leader>dn', function() require('dap').step_over() end)
vim.keymap.set('n', '<leader>do', function() require('dap').step_out() end)

-- Language server config --

-- LLDB config
dap.adapters.lldb = {
    type = 'executable',
    command = '/usr/bin/lldb-vscode',
    name = 'lldb'
}

local lldbconfig = {
    {
        name = 'Launch LLDB',
        type = 'lldb',
        request = 'launch',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
    },
}

dap.configurations.cpp = lldbconfig

dap.configurations.c = lldbconfig
dap.configurations.rust = lldbconfig
