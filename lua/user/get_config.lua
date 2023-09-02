local has_user_config, user_config = pcall(require, "user/user_config")

user_config = has_user_config and user_config or {}

local config = {
  theme_plugin = "ful1e5/onedark.nvim",
  theme_config = function ()
    require('onedark').setup()
  end,
  use_dev_icons = true,
  extra_auto_session_suppress_dirs = {},
  show_indentations = true,
  smooth_scroll = true,
  lsp_signiture = true,
  extra_plugins = {},
}

return config
