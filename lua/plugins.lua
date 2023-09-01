local LAZY_GIT_URL = "https://github.com/folke/lazy.nvim.git"
local LAZY_GIT_BRANCH = "--branch=stable"  -- latest stable release

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    LAZY_GIT_URL,
    LAZY_GIT_BRANCH,
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  -- Misc
  { "nvim-lua/plenary.nvim", lazy = true },

  -- Themes
  { "nvim-tree/nvim-web-devicons", lazy = true },
  {
    "ful1e5/onedark.nvim",
    lazy = false, -- Load on startup
    priority = 1000, -- Load first
    config = function()
      require('onedark').setup()
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    config = function()
      require('lualine').setup()
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    setup = function()
      require("plugins/indent-blankline")
    end,
  },

  -- UI
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require('plugins/nvimtree')
    end,
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
  },

  -- Syntax
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require('plugins/treesitter')
    end,
  },

  -- LSP
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",

  -- Nvim-Cmp
  { "onsails/lspkind-nvim", lazy = true },
  { "hrsh7th/cmp-nvim-lsp", lazy = true },
  { "hrsh7th/cmp-path", lazy = true },
  { "hrsh7th/cmp-buffer", lazy = true },
  { "hrsh7th/cmp-nvim-lua", lazy = true },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lua",
      "onsails/lspkind-nvim"
    },
    config = function()
      require('plugins/cmp')
    end,
  },
}

local lazy_opts = {
  git = {
    log = { "-8" },
    timeout = 120,
    url_format = "https://github.com/%s.git",
    -- url_format = "git@github.com:%s.git",
  },
}

require("lazy").setup(plugins, lazy_opts)
