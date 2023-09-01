require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = { "lua_ls", "clangd", "cmake" }
})

require("mason-lspconfig").setup_handlers {
  function (server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup {}
  end,
  ["lua_ls"] = function ()
    require('lspconfig').lua_ls.setup {
      settings = {
        Lua = {
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = {'vim'},
          },
        },
      },
    }
  end,
}
