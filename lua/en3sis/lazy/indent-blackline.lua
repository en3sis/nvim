return {
  "echasnovski/mini.indentscope",
  version = false, -- use latest version
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("mini.indentscope").setup({
      symbol = "│",
      options = { try_as_border = true, border= "both"},
      draw = {
        animation = require('mini.indentscope').gen_animation.none(),
        priority = 2
      },
    })

    -- vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = "#F16E93" })


    -- Disable for certain filetypes
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "help",
        "alpha",
        "dashboard",
        "neo-tree",
        "Trouble",
        "lazy",
        "mason",
        "notify",
        "toggleterm",
        "lazyterm",
      },
      callback = function()
        vim.b.miniindentscope_disable = true
      end,
    })
  end,
}
