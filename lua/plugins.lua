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
  concurrency = 5,
  git = {
    log = { "-8" },
    timeout = 120,
    url_format = "https://github.com/%s.git",
    -- url_format = "git@github.com:%s.git",
  },
}


-- *** Misc *******************************************************************
table.insert(plugins, { "nvim-lua/plenary.nvim", lazy = true })
table.insert(plugins, {
  'rmagatti/auto-session',
  opts = {
    log_level = "error",
    auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/", "/tmp" },
  }
})
table.insert(plugins, {
  'rmagatti/session-lens',
  opts = {--[[your custom config--]]},
  dependencies = {'rmagatti/auto-session', 'nvim-telescope/telescope.nvim'},
})


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
table.insert(plugins, {
  'akinsho/bufferline.nvim',
  opts = {},
  dependencies = 'nvim-tree/nvim-web-devicons',
})
table.insert(plugins, {
  "artart222/vim-resize",
  event = "BufEnter"
})
table.insert(plugins, { 'karb94/neoscroll.nvim', opts = {} })
table.insert(plugins, { 'petertriho/nvim-scrollbar', opts = {} })
table.insert(plugins, { 'akinsho/toggleterm.nvim', opts = {} })


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
    "j-hui/fidget.nvim",
  }
})
table.insert(plugins, { "ray-x/lsp_signature.nvim", opts = {} })


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


-- *** Git ********************************************************************
table.insert(plugins, { "tpope/vim-fugitive" })
table.insert(plugins, {
  "lewis6991/gitsigns.nvim",
  opts = {},
  event = "BufRead",
})
table.insert(plugins, {
  "rhysd/committia.vim",
  config = function()
    vim.cmd [[
      source ~/.config/nvim/lua/plugins/committia.vim
    ]]
  end
})


-- *** Other ******************************************************************
table.insert(plugins, { "fladson/vim-kitty" })
table.insert(plugins, { "folke/which-key.nvim", opts = {} })
table.insert(plugins, {
  "jghauser/mkdir.nvim",
  config = function()
    require("mkdir")
  end
})
table.insert(plugins, {
  "terrortylor/nvim-comment",
  config = function()
    require('nvim_comment').setup({
      marker_padding = true,
      comment_empty = false,
      comment_empty_trim_whitespace = true,
      create_mappings = false,
      hook = nil
    })
  end,
})
table.insert(plugins, {
  'Civitasv/cmake-tools.nvim',
  config = function()
    require('plugins/cmake')
  end,
})
table.insert(plugins, {
  "norcalli/nvim-colorizer.lua",
  config = function()
    require('colorizer').setup({})
  end,
})


-- *** Loading Lazy ***********************************************************
require("lazy").setup(plugins, lazy_opts)
