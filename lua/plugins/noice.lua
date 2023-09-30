-- --- Config -----------------------------------------------------------------
local config = require('user.get_config')


-- --- Noice ------------------------------------------------------------------
require('noice').setup({
  cmdline = config.noice_cmdline_opts,
  lsp = config.noice_lsp_opts,
  presets = config.noice_presets_opts,
  routes = {
    -- { view = "cmdline_ouput",filter = { event = "msg_showmode" } }
  }
})


-- --- Add cmdline to lualine -------------------------------------------------
local lualine = require("lualine")
local lualine_config = lualine.get_config()

vim.api.nvim_create_autocmd("RecordingEnter", {
  callback = function()
    lualine.refresh({
      place = { "statusline" },
    })
  end,
})
vim.api.nvim_create_autocmd("RecordingLeave", {
  callback = function()
    -- This is going to seem really weird!
    -- Instead of just calling refresh we need to wait a moment because of the nature of
    -- `vim.fn.reg_recording`. If we tell lualine to refresh right now it actually will
    -- still show a recording occuring because `vim.fn.reg_recording` hasn't emptied yet.
    -- So what we need to do is wait a tiny amount of time (in this instance 50 ms) to
    -- ensure `vim.fn.reg_recording` is purged before asking lualine to refresh.
    local timer = vim.loop.new_timer()
    timer:start(
      50,
      0,
      vim.schedule_wrap(function()
        lualine.refresh({
          place = { "statusline" },
        })
      end)
    )
  end,
})
table.insert(lualine_config.sections.lualine_x, 1, {
  function()
    local reg = vim.fn.reg_recording()
    if reg ~= "" then
      return "recording @" .. reg
    else
      return ""
    end
  end,
  color = { fg = "#ff9e64" },
})
-- table.insert(lualine_config.sections.lualine_x, 1, {
--   require("noice").api.status.mode.get,
--   cond = require("noice").api.status.mode.has,
--   color = { fg = "#ff9e64" },
-- })

table.insert(lualine_config.sections.lualine_x, 1, {
  require("noice").api.status.search.get,
  cond = require("noice").api.status.search.has,
  color = { fg = "#ff9e64" },
})

vim.opt.showcmdloc = 'statusline'
table.insert(lualine_config.sections.lualine_x, 1, "%S")

lualine.setup(lualine_config)
