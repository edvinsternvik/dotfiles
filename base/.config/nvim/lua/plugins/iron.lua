iron_start = function()
    vim.o.ft = "python"
    vim.cmd("IronRepl")
end

iron_init = function()
    local iron = require("iron.core")

    iron.setup {
      config = {
        scratch_repl = true,
        repl_definition = {
          sh = {
            command = {"zsh"}
          },
          python = {
            command = { "ipython", "--no-autoindent" },
            format = require("iron.fts.common").bracketed_paste_python
          }
        },
        repl_open_cmd = require('iron.view').bottom(0.6),
      },
      keymaps = {
        visual_send = "<leader>rr",
        send_line = "<leader>rr",
        send_file = "<leader>rf",
        exit = "<leader>rq",
        clear = "<leader>rc",
      },
      highlight = {
        italic = true
      },
      ignore_blank_lines = false,
    }
end

return {
    'Vigemus/iron.nvim',
    lazy = true,
    keys = {
        { "<leader>rs", iron_start },
    },
    config = iron_init,
}
