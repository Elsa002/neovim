-- --- Config -----------------------------------------------------------------
local config = require('user.get_config')


-- --- Bootstrap --------------------------------------------------------------
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


-- --- Settings ---------------------------------------------------------------
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
  install = {
    -- install missing plugins on startup. This doesn't increase startup time.
    missing = false,
    -- try to load one of these colorschemes when starting an installation during startup
    colorscheme = { "habamax" },
  },
  checker = {
    -- automatically check for plugin updates
    enabled = true,
    concurrency = 5, ---@type number? set to 1 to check for updates very slowly
    notify = true, -- get a notification when new updates are found
    frequency = 3600, -- check for updates every hour
  },
  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = true,
    notify = true, -- get a notification when changes are found
  },
}


-- --- Misc -------------------------------------------------------------------
table.insert(plugins, { "nvim-lua/plenary.nvim", lazy = true })

local auto_session_suppress_dirs = config.extra_auto_session_suppress_dirs
table.insert(auto_session_suppress_dirs, "/")
table.insert(auto_session_suppress_dirs, "/tmp")
table.insert(auto_session_suppress_dirs, "/etc")
table.insert(auto_session_suppress_dirs, "~/")
table.insert(auto_session_suppress_dirs, "~/Downloads")
table.insert(auto_session_suppress_dirs, "~/Documents")
table.insert(auto_session_suppress_dirs, "~/Projects")
table.insert(plugins, {
  'rmagatti/auto-session',
  opts = {
    log_level = "error",
    auto_session_suppress_dirs = auto_session_suppress_dirs,
  }
})
table.insert(plugins, {
  'rmagatti/session-lens',
  opts = {--[[your custom config--]]},
  dependencies = {'rmagatti/auto-session', 'nvim-telescope/telescope.nvim'},
})


-- --- Themes -----------------------------------------------------------------
table.insert(plugins, {
  "navarasu/onedark.nvim",
  lazy = false,    -- Load on startup
  priority = 1000, -- Load first
  config = function()
    require('onedark').setup(config.onedark_opts)
  end
})
table.insert(plugins, {
  "ellisonleao/gruvbox.nvim",
  lazy = false,    -- Load on startup
  priority = 1000, -- Load first
  theme_config = function ()
    require('gruvbox').setup(config.gruvbox_opts)
    vim.o.background = "dark"
  end,
})
table.insert(plugins, {
  "folke/tokyonight.nvim",
  lazy = false,    -- Load on startup
  priority = 1000, -- Load first
  config = function()
    require('tokyonight').setup(config.tokyonight_opts)
  end
})
table.insert(plugins, {
  'tanvirtin/monokai.nvim',
  lazy = false,    -- Load on startup
  priority = 1000, -- Load first
  config = function()
    require('monokai').setup(config.monokai_opts)
  end
})

table.insert(plugins, {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,    -- Load on startup
  priority = 1000, -- Load first
})
table.insert(plugins, { "rebelot/kanagawa.nvim", lazy = false, priority = 1000 })
table.insert(plugins, { "NLKNguyen/papercolor-theme", lazy = false, priority = 1000 })
table.insert(plugins, { "Mofiqul/dracula.nvim", lazy = false, priority = 1000 })
table.insert(plugins, { "LunarVim/onedarker.nvim", lazy = false, priority = 1000 })


-- --- UI ---------------------------------------------------------------------
local icons_plugin = nil
if config.use_dev_icons then
  icons_plugin = "nvim-tree/nvim-web-devicons"
  table.insert(plugins, { icons_plugin, lazy = true })
end

table.insert(plugins, {
  "nvim-lualine/lualine.nvim",
  lazy = false,
  config = function()
    require('lualine').setup({})
  end,
  dependencies = { icons_plugin },
})
table.insert(plugins, {
  "lukas-reineke/indent-blankline.nvim",
  enabled = config.show_indentations,
  main = "ibl",
  config = function()
    require('plugins.indent_blankline')
  end,
})
table.insert(plugins, {
  "nvim-tree/nvim-tree.lua",
  config = function()
    require('plugins.nvimtree')
  end,
  dependencies = {
    icons_plugin
  },
})
table.insert(plugins, {
  "nvim-telescope/telescope.nvim",
  config = function()
    require("telescope").setup {
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown {
            -- even more opts
          }
        }
      }
    }
  end,
  dependencies = {
    "nvim-lua/plenary.nvim"
  },
})
table.insert(plugins, {
  'nvim-telescope/telescope-ui-select.nvim',
  config = function()
    require("telescope").load_extension("ui-select")
  end,
  dependencies = {
    "nvim-telescope/telescope.nvim",
  }
})
table.insert(plugins, {
  'akinsho/bufferline.nvim',
  config = function()
    require('plugins.bufferline')
  end,
  dependencies = icons_plugin,
})
table.insert(plugins, {
  "artart222/vim-resize",
  event = "BufEnter"
})
table.insert(plugins, {
  'karb94/neoscroll.nvim',
  enabled = config.smooth_scroll,
  opts = {}
})
table.insert(plugins, { 'petertriho/nvim-scrollbar', opts = {} })
table.insert(plugins, { 'akinsho/toggleterm.nvim', opts = {} })
table.insert(plugins, {
  'rcarriga/nvim-notify',
  config = function()
    require('notify').setup(config.notify_opts)
  end,
})
table.insert(plugins, { 'MunifTanjim/nui.nvim' })
table.insert(plugins, {
  "folke/noice.nvim",
  enabled = true,
  event = "VeryLazy",
  config = function()
    require('plugins.noice')
  end,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
    "nvim-lualine/lualine.nvim",
  }
})


-- --- Syntax -----------------------------------------------------------------
table.insert(plugins, {
  "nvim-treesitter/nvim-treesitter",
  config = function()
    require('plugins.treesitter')
  end,
})


-- --- LSP --------------------------------------------------------------------
table.insert(plugins, {
  "williamboman/mason.nvim",
  config = function()
    require('mason').setup({})
  end
})
table.insert(plugins, {
  "williamboman/mason-lspconfig.nvim",
  dependencies = { "williamboman/mason.nvim" }
})
table.insert(plugins, {
  "jay-babu/mason-nvim-dap.nvim",
  config = function()
    require('plugins.dap_config')
  end,
  dependencies = { "williamboman/mason.nvim" }
})
table.insert(plugins, {
  "neovim/nvim-lspconfig",
  config = function()
    require('plugins.lsp_config')
  end,
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/nvim-cmp",
    "j-hui/fidget.nvim",
  }
})
table.insert(plugins, { "folke/neodev.nvim", opts = {} })
table.insert(plugins, {
  "ray-x/lsp_signature.nvim",
  enabled = config.lsp_signiture,
  opts = {}
})
table.insert(plugins, {
  "RRethy/vim-illuminate",
  config = function()
    require('illuminate').configure({
      providers = {
        'lsp',
        'treesitter',
      },
    })

    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function()
        vim.api.nvim_set_hl(0, 'IlluminatedWordText', {})
        vim.api.nvim_set_hl(0, 'IlluminatedWordRead', { link = 'MatchParen' })
        vim.api.nvim_set_hl(0, 'IlluminatedWordWrite', { link = 'MatchParen' })
      end
    })
  end
})


-- --- Snippets ---------------------------------------------------------------
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


-- --- Completion -------------------------------------------------------------
local lspkind_plugin = nil
if config.use_dev_icons then
  lspkind_plugin = "onsails/lspkind-nvim"
  table.insert(plugins, { lspkind_plugin, lazy = true })
end
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
    lspkind_plugin
  },
  config = function()
    require('plugins.cmp')
  end,
})

table.insert(plugins, {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    require("plugins.autopairs")
  end,
  enabled = config.enable_autopairs,
  dependencies = { "nvim-treesitter/nvim-treesitter", "hrsh7th/nvim-cmp" },
})


-- --- Git --------------------------------------------------------------------
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


-- --- Other ------------------------------------------------------------------
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
    require('plugins.cmake')
  end,
})
table.insert(plugins, {
  'mfussenegger/nvim-dap',
})
table.insert(plugins, {
  'rcarriga/nvim-dap-ui',
  config = function ()
    require('plugins.dapui')
  end,
  dependencies = { 'mfussenegger/nvim-dap' }
})
table.insert(plugins, {
  "norcalli/nvim-colorizer.lua",
  config = function()
    require('colorizer').setup({})
  end,
})


-- --- Loading Lazy -----------------------------------------------------------
for _, p in ipairs(config.extra_plugins) do
  table.insert(plugins, p)
end


-- --- Loading Lazy -----------------------------------------------------------
require("lazy").setup(plugins, lazy_opts)
