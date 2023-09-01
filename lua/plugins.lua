-- *** Bootstrap **************************************************************
local LAZY_GIT_URL = "https://github.com/folke/lazy.nvim.git"
local LAZY_GIT_BRANCH = "--branch=stable" -- latest stable release

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


-- *** Settings ***************************************************************
local plugins = {
}

local lazy_opts = {
  git = {
    log = { "-8" },
    timeout = 120,
    url_format = "https://github.com/%s.git",
    -- url_format = "git@github.com:%s.git",
  },
}


-- *** Misc *******************************************************************
table.insert(plugins, { "nvim-lua/plenary.nvim", lazy = true })


-- *** Themes *****************************************************************
table.insert(plugins, { "nvim-tree/nvim-web-devicons", lazy = true })
table.insert(plugins, {
  "ful1e5/onedark.nvim",
  lazy = false,    -- Load on startup
  priority = 1000, -- Load first
  config = function()
    require('onedark').setup()
  end,
})
table.insert(plugins, {
  "nvim-lualine/lualine.nvim",
  lazy = false,
  config = function()
    require('lualine').setup()
  end,
  dependencies = { "nvim-tree/nvim-web-devicons" },
})
table.insert(plugins, {
  "lukas-reineke/indent-blankline.nvim",
  event = "BufRead",
  setup = function()
    require("plugins/indent-blankline")
  end,
})


-- *** UI *********************************************************************
table.insert(plugins, {
  "nvim-tree/nvim-tree.lua",
  config = function()
    require('plugins/nvimtree')
  end,
  dependencies = {
    "nvim-tree/nvim-web-devicons"
  },
})
table.insert(plugins, {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim"
  },
})


-- *** Syntax *****************************************************************
table.insert(plugins, {
  "nvim-treesitter/nvim-treesitter",
  config = function()
    require('plugins/treesitter')
  end,
})


-- *** LSP ********************************************************************
table.insert(plugins, { "williamboman/mason.nvim" })
table.insert(plugins, { "williamboman/mason-lspconfig.nvim" })
table.insert(plugins, {
  "neovim/nvim-lspconfig",
  config = function()
    require('plugins/lsp_config')
  end,
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/nvim-cmp",
  }
})


-- *** Snippets ***************************************************************
table.insert(plugins, { "L3MON4D3/LuaSnip", lazy = true })
table.insert(plugins, { "rafamadriz/friendly-snippets", lazy = true })
table.insert(plugins, {
  "saadparwaiz1/cmp_luasnip",
  lazy = true,
  dependencies = {
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets",
  },
})


-- *** Completion *************************************************************
table.insert(plugins, { "onsails/lspkind-nvim", lazy = true })
table.insert(plugins, { "hrsh7th/cmp-nvim-lsp", lazy = true })
table.insert(plugins, { "hrsh7th/cmp-path", lazy = true })
table.insert(plugins, { "hrsh7th/cmp-buffer", lazy = true })
table.insert(plugins, { "hrsh7th/cmp-nvim-lua", lazy = true })
table.insert(plugins, {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lua",
    "saadparwaiz1/cmp_luasnip",
    "onsails/lspkind-nvim"
  },
  config = function()
    require('plugins/cmp')
  end,
})


-- *** Other ******************************************************************
-- Syntax for kitty config
table.insert(plugins, { "fladson/vim-kitty" })


-- *** Loading Lazy ***********************************************************
require("lazy").setup(plugins, lazy_opts)
