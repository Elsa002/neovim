-- To use custom config, add a file: nvim/lua/user/user_config.lua and
-- have the file return a table with all the settings you want to change.
--
-- example:
-- return {
--   use_dev_icons = false,
--   smooth_scroll = false,
-- }
local has_user_config, user_config = pcall(require, "user/user_config")

local default_config = {
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
