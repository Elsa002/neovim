-- *** Settings ***************************************************************
-- Map leader key to space.
vim.g.mapleader = " "


-- *** Functions **************************************************************
local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend("force", options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end


-- *** General ****************************************************************
-- Clearing highlights after searching word in file.
map("n", "<Leader>h", ":noh<CR>")

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


-- *** NvimTree ***************************************************************
map('n', '<leader>e', ':NvimTreeToggle<CR>')


-- *** Telescope **************************************************************
map("n", "<Leader>fw", ":Telescope live_grep<CR>")
map("n", "<Leader>gt", ":Telescope git_status<CR>")
map("n", "<Leader>cm", ":Telescope git_commits<CR>")
map("n", "<Leader>ff", ":Telescope find_files<CR>")
map("n", "<Leader>fp", ":Telescope media_files<CR>")
map("n", "<Leader>fb", ":Telescope buffers<CR>")
map("n", "<Leader>fh", ":Telescope help_tags<CR>")
map("n", "<Leader>fo", ":Telescope oldfiles<CR>")
map("n", "<Leader>th", ":Telescope colorscheme<CR>")
map("n", "<Leader>t", ":Telescope<CR>")


-- *** Lsp ********************************************************************
map("n", "<Leader>,", ":lua vim.lsp.diagnostic.goto_prev()<CR>")
map("n", "<Leader>;", ":lua vim.lsp.diagnostic.goto_next()<CR>")
map("n", "<Leader>a", ":lua vim.lsp.buf.code_action()<CR>")
map("n", "<Leader>gd", ":lua vim.lsp.buf.definition()<CR>")
-- map("n", "<Leader>f", ":lua vim.lsp.buf.formatting()<CR>")
map("n", "<Leader>k", ":lua vim.lsp.buf.hover()<CR>")
map("n", "<Leader>m", ":lua vim.lsp.buf.rename()<CR>")
-- map("n", "<Leader>r", ":lua vim.lsp.buf.references()<CR>")
map("n", "<Leader>r", ":Telescope lsp_references<CR>")
map("n", "<Leader>s", ":lua vim.lsp.buf.document_symbol()<CR>")
