return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("todo-comments").setup({
      signs = false,
      keywords = {
        TODO = {
          icon = " ",
          color = "info",
          alt = { "todo" }
        },
      },
      highlight = {
        before = "",      -- "fg" or other highlight type
        keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty
        after = "fg",     -- "fg" or other highlight type
        pattern = [[.*<(KEYWORDS)(\([^\)]*\))?:]],
        comments_only = true,
        max_line_len = 400,
        multiline = true,
      },
      colors = {
        error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
        warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
        info = { "#2563EB" },
        hint = { "DiagnosticHint", "#10B981" },
        default = { "Identifier", "#7C3AED" },
        test = { "Identifier", "#FF00FF" }
      },
    })

    -- Custom highlight group for the non-keyword part of TODO comments
    vim.cmd [[
      highlight TodoComment guifg=#6B7280
      highlight link TodoFg TodoComment
    ]]
  end
}
