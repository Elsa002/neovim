-- To use custom config, add a file: nvim/lua/user/user_config.lua and
-- have the file return a table with all the settings you want to change.
--
-- example:
-- return {
--   use_dev_icons = false,
--   smooth_scroll = false,
-- }
--
-- It is recommended to copy the default config and changing from there.

local has_user_config, user_config = pcall(require, "user/user_config")

local default_config = {
  -- The colorscheme to use. To add new ones, add them in extra plugins.
  colorscheme = 'onedark',

  -- Use extra icons. Turning this to false will not completely remove icons.
  use_dev_icons = true,

  -- Suppress directories for auto saving sessions.
  extra_auto_session_suppress_dirs = {},

  -- Show indentation marks
  show_indentations = true,

  -- Scroll smoothly.
  smooth_scroll = true,

  -- Show function doc while typing the fields.
  lsp_signiture = true,

  -- Noice configs
  noice_cmdline_opts = {
    enabled = true, -- enables the Noice cmdline UI
    view = "cmdline",
    opts = {}, -- global options for the cmdline. See section on views
    ---@type table<string, CmdlineFormat>
    format = {
      -- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
      -- view: cmdline/cmdline_popup (default is cmdline view)
      -- opts: any options passed to the view
      -- icon_hl_group: optional hl_group for the icon
      -- title: set to anything or empty string to hide
      cmdline = { pattern = "^:", icon = "", lang = "vim" },
      search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
      search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
      bash = { pattern = "^:!", view = "cmdline_popup", icon = "$", lang = "bash" },
      bash_replace = { pattern = "^:%%!", view = "cmdline_popup", icon = "replace $", lang = "bash" },
      lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, view = "cmdline_popup", icon = "", lang = "lua" },
      help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
      input = {}, -- Used by input()
      -- lua = false, -- to disable a format, set to `false`
    }
  },
  noice_lsp_opts = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
    signature = {
      enabled = false
    },
  },
  noice_presets_opts = {
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = true, -- add a border to hover docs and signature help
  },
  notify_opts = {
    timeout = 500,
    render = "wrapped-compact",
    minimum_width = 20,
    max_width = 50,
  },

  -- Settings for the default themes
  onedark_opts = {
    style = "warmer"
  },
  gruvbox_opts = {
    contrast = "hard"
  },
  tokyonight_opts = {},
  monokai_opts = {},

  -- Add extra plugins here in Lazy's format.
  extra_plugins = {},
}

local config = has_user_config and user_config or {}

local function set_default(t, key, default_value)
  if t[key] == nil then
    t[key] = default_value
  end
end

for key, val in pairs(default_config) do
  set_default(config, key, val)
end

return config
