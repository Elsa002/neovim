-- --- Settings ---------------------------------------------------------------
-- Map leader key to space.
vim.g.mapleader = " "


-- --- Functions --------------------------------------------------------------
local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend("force", options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local function map_cmd(mode, keys, cmd)
  vim.keymap.set(mode, keys, function()
    vim.api.nvim_command(cmd)
  end)
end


-- --- General ----------------------------------------------------------------
-- Clearing highlights after searching word in file.
vim.keymap.set('n', '<Leader>h', function()
  vim.api.nvim_command("noh")
  -- Refresh lualine to hide the search.
  local timer = vim.loop.new_timer()
  timer:start(
    50,
    0,
    vim.schedule_wrap(function()
      require('lualine').refresh({
        place = { "statusline" },
      })
    end)
  )
end)

-- Remove unnecessary white spaces.
vim.keymap.set('n', '<Leader>rs', function()
  pcall(vim.api.nvim_command, "%s/ \\+$//")
  pcall(vim.api.nvim_command, "noh")
end)

-- Split navigations.
map("n", "<A-j>", "<C-w><C-j>")
map("n", "<A-k>", "<C-w><C-k>")
map("n", "<A-l>", "<C-w><C-l>")
map("n", "<A-h>", "<C-w><C-h>")

-- Set j and k to not skip lines.
map("n", "j", "gj")
map("n", "k", "gk")
map("n", "gj", "j")
map("n", "gk", "k")


-- --- NvimTree ---------------------------------------------------------------
map_cmd('n', '<leader>e', 'NvimTreeToggle')


-- --- Telescope --------------------------------------------------------------
map_cmd("n", "<Leader>fw", "Telescope live_grep")
map_cmd("n", "<Leader>gt", "Telescope git_status")
-- map_cmd("n", "<Leader>cm", "Telescope git_commits")
map_cmd("n", "<Leader>ff", "Telescope find_files")
-- map_cmd("n", "<Leader>fp", "Telescope media_files")
map_cmd("n", "<Leader>fb", "Telescope buffers")
map_cmd("n", "<Leader>fh", "Telescope help_tags")
map_cmd("n", "<Leader>fo", "Telescope oldfiles")
map_cmd("n", "<Leader>th", "Telescope colorscheme")
map_cmd("n", "<Leader>ss", "Telescope spell_suggest")
map_cmd("n", "<Leader>fc", "Telescope grep_string")
map_cmd("n", "<Leader>tt", "Telescope")
vim.keymap.set('n', '<Leader><Leader>', function() require('telescope.builtin').builtin() end)


-- --- Buffers ----------------------------------------------------------------
-- Buffer resizing.
map_cmd("n", "<S-h>", "call ResizeLeft(3)")
map_cmd("n", "<S-l>", "call ResizeRight(3)")
map_cmd("n", "<S-k>", "call ResizeUp(1)")
map_cmd("n", "<S-j>", "call ResizeDown(1)")

-- Buffer switching.
map_cmd("n", "<A-[>", "BufferLineCyclePrev")
map_cmd("n", "<A-]>", "BufferLineCycleNext")

-- Buffer opening
map_cmd("n", "<Leader>bb", "BufferLinePick")

-- Buffer closing.
map_cmd("n", "<Leader>bc", "BufferLinePickClose")

-- Buffer moving.
map_cmd("n", "<Leader>bl", "BufferLineMoveNext")
map_cmd("n", "<Leader>bh", "BufferLineMovePrev")


-- --- Lsp --------------------------------------------------------------------
-- Native
vim.keymap.set('n', '<Leader>,', function() vim.diagnostic.goto_prev() end)
vim.keymap.set('n', '<Leader>;', function() vim.diagnostic.goto_next() end)
vim.keymap.set('n', '<Leader>a', function() vim.lsp.buf.code_action() end)
vim.keymap.set('n', '<Leader>k', function() vim.lsp.buf.hover() end)
vim.keymap.set('n', '<Leader>m', function() vim.lsp.buf.rename() end)

-- Telescope
vim.keymap.set('n', '<Leader>tr', function() require('telescope.builtin').lsp_document_symbols() end)
vim.keymap.set('n', '<Leader>gd', function() require('telescope.builtin').lsp_definitions() end)
vim.keymap.set('n', '<Leader>r', function() require('telescope.builtin').lsp_references() end)

-- Disabled
-- vim.keymap.set('n', '<Leader>f', function() vim.lsp.buf.formatting() end)
-- vim.keymap.set('n', '<Leader>s', function() vim.lsp.buf.document_symbol() end)


-- --- ToggleTerm -------------------------------------------------------------
map_cmd("n", "<C-t>", "ToggleTerm")
map_cmd("t", "<C-t>", "ToggleTerm")
-- map("n", "v:count1 <C-t>", ":v:count1" .. "\"ToggleTerm\"<CR>")
-- map("v", "v:count1 <C-t>", ":v:count1" .. "\"ToggleTerm\"<CR>")
function _G.set_terminal_keymaps()
  map("t", "<esc>", "<C-\\><C-n>")
  map("t", "<C-q>", "<esc>")

  map("t", "<A-h>", "<c-\\><c-n><c-w>h")
  map("t", "<A-j>", "<c-\\><c-n><c-w>j")
  map("t", "<A-k>", "<c-\\><c-n><c-w>k")
  map("t", "<A-l>", "<c-\\><c-n><c-w>l")
end
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")


-- --- Comment Toggle ---------------------------------------------------------
map_cmd("n", "<C-/>", "CommentToggle")
map("v", "<C-/>", ":'<,'>CommentToggle<CR>")


-- --- Debug ------------------------------------------------------------------
vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
vim.keymap.set('n', '<Leader>db', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>dB', function() require('dap').set_breakpoint() end)
vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
  require('dap.ui.widgets').hover()
end)
vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
  require('dap.ui.widgets').preview()
end)
vim.keymap.set('n', '<Leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<Leader>ds', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end)
