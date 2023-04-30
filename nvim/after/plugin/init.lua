-- plugins which require no setup go here
-- or general setup which should take place
-- after plugins are loaded

local dap = require('dap')

dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
    command = 'vscode-lldb-14',
        args = {"--port", "${port}"},
    }
}

dap.configurations.rust = {
    {
        name = "Rust debug",
        type = "codelldb",
        request = "launch",
        program = function() 
            vim.fn.jobstart("cargo build")
            file = "/home/bmoffett/projects/gb_lang/target/debug/gb_lang"
            print(file)
            return file
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = true,
        showDisassembly = "never"
    },
}

