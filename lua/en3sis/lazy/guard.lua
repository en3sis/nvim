return {
  "nvimdev/guard.nvim",
  -- Builtin configuration, optional
  dependencies = {
    "nvimdev/guard-collection",
  },
  config = function()
    require('guard').setup({
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      fmt_on_save = true,
      -- Use lsp if no formatter was defined for this filetype
      lsp_as_default_formatter = false,
    })
  end
}
