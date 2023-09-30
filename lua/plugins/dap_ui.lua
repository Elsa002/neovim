local dap = require('dap')
local dapui = require("dapui")

-- Dap signs
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	-- group = "UserDefLoadOnce",
	desc = "prevent colorscheme clears self-defined DAP icon colors.",
	callback = function()
		vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#993939' })
		vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#61afef' })
		vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#98c379' })
	end
})

vim.fn.sign_define('DapBreakpoint', { text=' ', texthl='DapBreakpoint' })
vim.fn.sign_define('DapBreakpointCondition', { text=' ﳁ', texthl='DapBreakpoint' })
vim.fn.sign_define('DapBreakpointRejected', { text=' ', texthl='DapBreakpoint' })
vim.fn.sign_define('DapLogPoint', { text=' ', texthl='DapLogPoint' })
vim.fn.sign_define('DapStopped', { text=' ', texthl='DapStopped' })

-- Dap ui
dapui.setup({
  icons = { expanded = "", collapsed = "", circular = "" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  -- Use this to override mappings for specific elements
  element_mappings = {},
  expand_lines = true,
  layouts = {
    {
      elements = {
        { id = "scopes", size = 0.33 },
        { id = "breakpoints", size = 0.17 },
        { id = "stacks", size = 0.25 },
        { id = "watches", size = 0.25 },
      },
      size = 0.33,
      position = "right",
    },
    {
      elements = {
        { id = "repl", size = 0.65 },
        { id = "console", size = 0.35 },
      },
      size = 0.27,
      position = "bottom",
    },
  },
})

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
