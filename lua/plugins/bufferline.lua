local get_symbol = function (level)
  if level:match("error") then
    return ' '
  elseif level:match("warning") then
    return ' '
  elseif level:match("hint") then
    return '󰌶 '
  else
    print("Missing icon for level: " .. level)
  end
  return ""
end

require('bufferline').setup({
  highlights = {
    background = {
      italic = true,
    },
    buffer_selected = {
      bold = true,
    },
  },
  options = {
    diagnostics = "nvim_lsp",
    diagnostics_update_in_insert = false,
    diagnostics_indicator = function(_, _, diagnostics_dict, _)
      local string = ""
      for level, count in pairs(diagnostics_dict) do
        string = string .. count .. get_symbol(level)
      end
      return string
    end
  }
})
