-- --- Dap --------------------------------------------------------------------
vim.api.nvim_create_user_command('DapUIOpen', function()
  require('dapui').open()
end, { desc = "Open debug ui", nargs = 0 })

vim.api.nvim_create_user_command('DapUIClose', function()
  require('dapui').close()
end, { desc = "Close debug ui", nargs = 0 })


-- --- Lsp --------------------------------------------------------------------
vim.api.nvim_create_user_command('FormatFile', function()
  vim.lsp.buf.format()
end, { desc = "Format current file", nargs = 0 })


-- --- Telescope --------------------------------------------------------------
vim.api.nvim_create_user_command('FindFiles', function()
  require('telescope.builtin').find_files()
end, { desc = "Find files", nargs = 0 })

vim.api.nvim_create_user_command('FindFilesAll', function()
  require('telescope.builtin').find_files({
    find_command = { 'rg', '--no-ignore', '--hidden' , '--files' },
    prompt_prefix = '🔍'
  })
end, { desc = "Find files (includes hidden and ignored)", nargs = 0 })

vim.api.nvim_create_user_command('FindWords', function()
  require('telescope.builtin').live_grep()
end, { desc = "Find words", nargs = 0 })

vim.api.nvim_create_user_command('SpellSuggest', function()
  require('telescope.builtin').spell_suggest()
end, { desc = "Spell suggestions", nargs = 0 })


-- --- Buffer -----------------------------------------------------------------
vim.api.nvim_create_user_command('BufferDelete', function()
  vim.api.nvim_command('bdelete')
end, { desc = "Close current buffer", nargs = 0 })
