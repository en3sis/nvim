return {
  "m4xshen/hardtime.nvim",
  lazy = true,
  dependencies = { "MunifTanjim/nui.nvim" },
  opts = {
    max_time = 1000,
    max_count = 3,
    disable_mouse = false,
    arrow = true,
    hint = true,
    notification = true,
    allow_different_key = true,
    enabled = false,
  },
}
